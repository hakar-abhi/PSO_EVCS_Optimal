function [finalres,radial_cond] = loadflow_basecase_test(nbus,sw_open,radial_check,data_pass_to_loadflow)

baseKV = 12.66;
baseMVA = 100;
source_num = [1];



finalresbic = bibc_bcbv_test(nbus,sw_open,radial_check,baseKV,baseMVA,data_pass_to_loadflow);

finaldlf = finalresbic{1};
busdata_value = finalresbic{2};
resistance_val = finalresbic{3};
reactance_val = finalresbic{4};
actual_imped = finalresbic{5};
linedata_value = finalresbic{6};

imped_value = actual_imped;


final_dlf_matrix = finaldlf;
complex_load_d = complex(busdata_value(:,2),busdata_value(:,3)); 
complex_load_g = zeros(size(busdata_value,1),1); % size(A,1) provides number of rows in matrix A.

final_load_matrix = (complex_load_d - complex_load_g);

final_load_matrix(length(source_num)) = []; % lets remove the 1 bus load value as it is not a load bus

initial_volt_value=ones(size(busdata_value,1)-length(source_num),1);
voltage_drop_value = initial_volt_value;

max_iter=100;

for ind_loop = 1:max_iter
    %backward_sweep
    inject_current_data = conj(final_load_matrix./voltage_drop_value); % injected current at each bus
    old_volt = voltage_drop_value;
    volt_drop_each = final_dlf_matrix*inject_current_data; %voltage_drop_at_each_branch
    voltage_drop_value = initial_volt_value - volt_drop_each;
    old_volt1 = old_volt;
    new_volt = voltage_drop_value;
    error_volt_tolr = max(abs(old_volt1-new_volt));
end

final_volt_data = [ones(length(source_num),1);voltage_drop_value];
from_node = linedata_value(:,2);
to_node = linedata_value(:,3);
for ind = 1:length(from_node)
    volt_diff_value(ind,:) = final_volt_data(from_node(ind))-final_volt_data(to_node(ind));
end
volt_diff_value = abs(volt_diff_value);
ploss = ((volt_diff_value.^2).*resistance_val)./(abs(imped_value).*abs(imped_value))*10^5; % ploss in kWs
qloss =  ((volt_diff_value.^2).*reactance_val)./(abs(imped_value).*abs(imped_value))*10^5; % qloss in kVARs
loc1 = find(~(isnan(ploss)));
loc2 = find(~(isnan(qloss)));
total_power_lossp = sum(ploss(loc1));
total_power_lossq = sum(qloss(loc2));
final_voltage = real(final_volt_data);
gmh = linedata_value(:,2:3);
[rr,cc]=size(gmh);

for km = 1:rr
    linename{km} = [num2str(gmh(km,1)),'-',num2str(gmh(km,2))];
end
finalres{1} = total_power_lossp;
finalres{2} = total_power_lossp;
finalres{3} = total_power_lossq;
finalres{4} = final_voltage;
finalres{5} = ploss;
finalres{6} = qloss;
finalres{15} = finalresbic;
finalres{18} = linename;