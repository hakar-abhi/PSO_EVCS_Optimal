function finaldlf = DLF_MATRIX_GENERATE_test(node_name_final,final_network_to_source,network_final_model,rxdata)

for km = length(node_name_final):-1:1
    bfnew = bfsearch(final_network_to_source,node_name_final{km});
    
    
    for km2 = 1:length(bfnew)-1
        idxval(km2) = findedge(network_final_model,bfnew{km2+1},bfnew{km2}); % gives ROW INDICES of G.Edges.Endnodes for each specified edge.
    end
    
    wgtv =network_final_model.Edges.Weight(idxval); % gives weight associated for he specified row index by idxval
   
    newbibc(str2double(node_name_final{km}), wgtv)=1;
    newbcbv(str2double(node_name_final{km}),wgtv)=rxdata(wgtv);
    idxval=[];
end

finalbibc = newbibc(2:end,:);
finalbcbv = newbcbv(2:end,:);
dlfmat=finalbcbv*finalbibc';

finaldlf = dlfmat;
    
        
    

