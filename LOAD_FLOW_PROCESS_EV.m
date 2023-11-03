function [finalres]=LOAD_FLOW_PROCESS_EV(nbus,ev_place,data_pass_to_loadflow)
voltage_minimum=data_pass_to_loadflow{2};
voltage_maximum=data_pass_to_loadflow{3};
power_factor=data_pass_to_loadflow{4};

evsize=data_pass_to_loadflow{51};
no_ofev=data_pass_to_loadflow{52};

objective_result_base=data_pass_to_loadflow{22};
finalresbic=objective_result_base{15};

source_num=[1];
finaldlf=finalresbic{1};
busdata_value=finalresbic{2};
resistance_val=finalresbic{3};
reactance_val=finalresbic{4};
actual_imped=finalresbic{5};
linedata_value=finalresbic{6};
PBASE=finalresbic{7};
final_dlf_matrix=finaldlf;
imped_value=actual_imped;

complex_load_d=complex(busdata_value(:,2),busdata_value(:,3));% complex power load
complex_load_g=zeros(size(busdata_value,1),1);
pfdata=tand(acosd(power_factor));
    
ev_place11=ev_place(1:no_ofev*2);
loc_value=ev_place11(1:no_ofev);
ev_value=ev_place11(no_ofev+1:end);

%% ev place
for ind=1:length(loc_value)
        PG=evsize*(ev_value(ind));
        QG=pfdata*PG;
        ev_valueq(1,ind)=QG;
        ev_valuep(1,ind)=PG;
    
       complex_load_g(loc_value(ind))=complex(PG/PBASE,QG/PBASE);
end

final_load_matrix=(complex_load_d+complex_load_g);
final_load_matrix(length(source_num))=[];
initial_volt_value=ones(size(busdata_value,1)-length(source_num),1);% initial bus voltage
voltage_drop_value=initial_volt_value;
max_iter=300; 
for ind_lop=1:max_iter
    %backward sweep
    inject_current_data=conj(final_load_matrix./voltage_drop_value); % injected current at each bus
    old_volt=voltage_drop_value;
    volt_drop_each=final_dlf_matrix*inject_current_data; %voltage drops along each branch.
    voltage_drop_value=initial_volt_value-volt_drop_each;
    old_volt1=(old_volt);
    new_volt=(voltage_drop_value);
    error_volt_tolr=max(abs(old_volt1-new_volt));
end

final_volt_data=[ones(length(source_num),1);voltage_drop_value];


from_node=linedata_value(:,2);
to_node=linedata_value(:,3);
for ind=1:length(from_node)
    volt_diff_value(ind,:)=final_volt_data(from_node(ind))-final_volt_data(to_node(ind));
end
volt_diff_value1=abs(volt_diff_value);
ploss=((volt_diff_value1.^2).*resistance_val)./(abs(imped_value).*abs(imped_value))*10^5; % Each Line Loss in kWs
loc1=find(~(isnan(ploss)));
qloss=((volt_diff_value1.^2).*reactance_val)./(abs(imped_value).*abs(imped_value))*10^5; % Each Line Loss in kVAr
loc2=find(~(isnan(qloss)));
power_loss=sum(ploss(loc1));power_lossq=sum(qloss(loc2));
finalvoltage=real(final_volt_data);


finalres{1}=power_loss;
finalres{2}=power_loss;
finalres{3}=power_lossq;
finalres{4}=finalvoltage;
finalres{5}=ploss;
finalres{6}=qloss;

finalres{11}=loc_value;
finalres{12}=ev_value;
finalres{13}=ev_valuep;
finalres{14}=ev_valueq;
finalres{15}=[];






