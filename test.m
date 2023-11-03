clc
close all;

prompt1 = "enter minimum voltage limit for the buses: ";
min_volt_limit = input(prompt1);

prompt2 = "enter maximum voltage limit for the buses: ";
max_volt_limit = input(prompt2);


prompt3 = "enter required power factor: ";
power_factor = input(prompt3);



prompt4 = "enter number of charging stations: ";
num_ev = input(prompt4);

prompt5 = "enter ev size: ";
ev_size = input(prompt5);

prompt6 = "enter number of iterations: ";
no_of_iter = input(prompt6);

prompt7 = "enter population size: ";
no_of_int_pop = input(prompt7);

prompt8 = "enter test bus size: ";
nbus = input(prompt8);

if nbus==33
    sw_open = [33 34 35 36 37];
    radial_check = 0;
elseif(nbus==11)
        sw_open = [];
        radial_check = 0;
    
    
end
EV_NUMBER_MIN = 10;
EV_NUMBER_MAX = 50;

data_pass_to_loadflow = cell(1,52);
data_pass_to_loadflow{33}=100;
data_pass_to_loadflow{4}= power_factor;
data_pass_to_loadflow{52} = num_ev;
data_pass_to_loadflow{2} = min_volt_limit;
data_pass_to_loadflow{3} = max_volt_limit;
data_pass_to_loadflow{51} = ev_size;
data_pass_to_loadflow{22} = cell(1,18);
