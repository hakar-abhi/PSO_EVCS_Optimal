function finalres=bibc_bcbv_test(nbus,sw_open,radial_check,baseKV,baseMVA,data_pass_to_loadflow)


final_line_data = test_for_linedata_swopen(nbus, sw_open,radial_check);


from_node = final_line_data(:,2).';

to_node = final_line_data(:,3).';

path_number = final_line_data(:,1).';

for km = 1:nbus
    node_name_final{km} = num2str(km);
end


network_final_model = digraph(to_node,from_node,path_number,node_name_final);




while(1)
    
    for kmx = 2:length(node_name_final)
        
        bfdata = bfsearch(network_final_model,node_name_final{kmx});
      
        memchk =ismember(bfdata,num2str(1));
        filp_nodes_edges=[];
        
        
        if(isempty(find(memchk)))  % find gives indices of non zero elements
            
            fprintf("\n hello \n");
            preid=predecessors(network_final_model,node_name_final{kmx}); %  returns the predecessor nodes of the node in directed graph specified by nodeID. The predecessor nodes form directed edges with preIDs as the source nodes, and nodeID as the target node
            
            for kmd1 = 1:length(preid)
                
                filp_nodes_edges=[filp_nodes_edges ;[str2num(preid{kmd1}) str2num(node_name_final{kmx})]];
                
            end
            
            edgedata=network_final_model.Edges;
            
            if(~isempty(filp_nodes_edges))
                fprintf("\n hy \n");
            edgenum=findedge(network_final_model,filp_nodes_edges(:,1),filp_nodes_edges(:,2));
            ss=edgedata(edgenum,:);
            wval=ss.Weight;
            network_final_model=rmedge(network_final_model,edgenum);
            network_final_model=addedge(network_final_model,filp_nodes_edges(:,2), filp_nodes_edges(:,1),wval);
            end
           end
       end
    count=0;
    
      for kit=1:length(node_name_final)
        bfdata=bfsearch(network_final_model,node_name_final{kit});
        memchk=ismember(bfdata,num2str(1));
        if(~isempty(find(memchk)))
            count=count+1;
        end
      end
     
     if(count==length(node_name_final))
        break;
     end
end

final_network_to_source = network_final_model;
network_edges = network_final_model.Edges;
node_number_data = network_edges.EndNodes;

edgenum = findedge(network_final_model, node_number_data(:,1),node_number_data(:,2));

% edgedata = network_final_model.Edges;

wval = network_edges.Weight;

network_final_model = rmedge(network_final_model,edgenum);
network_final_model = addedge(network_final_model,node_number_data(:,2), node_number_data(:,1), wval);

plot(network_final_model);
[linedata_value] = test_for_linedata_swopen(nbus,[],radial_check);
ZBASE = (baseKV^2)/baseMVA;
PBASE = baseMVA*1000;
linedata_value(:,4:5) = linedata_value(:,4:5)/ZBASE;
rxdata = complex(linedata_value(:,4),linedata_value(:,5));

finaldlf = DLF_MATRIX_GENERATE_test(node_name_final,final_network_to_source,network_final_model,rxdata);


busdata_value = bus_data_test(nbus);
load_percentage = data_pass_to_loadflow{33};

busdata_value(:,[2 3]) = busdata_value(:,[2 3])*(load_percentage/100);
busdata_value(:,[2 3])=(busdata_value(:,[2 3])/PBASE);

resistance_val=linedata_value(:,4);
reactance_val=linedata_value(:,5);
resistance_val(sw_open)=[];
reactance_val(sw_open)=[];
linedata_value(sw_open,:)=[];
actual_imped=complex(resistance_val,reactance_val);

finalres{1}=finaldlf;
finalres{2}=busdata_value;
finalres{3}=resistance_val;
finalres{4}=reactance_val;
finalres{5}=actual_imped;
finalres{6}=linedata_value;
finalres{7}=PBASE;
