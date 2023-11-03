clc
close all;
clear;
delete *.xlsx



test

disp('<strong>****************************************************************************************</strong>');
disp('<strong>OPTIMAL PLACEMENT OF ELECTRIC VEHICLE CHARGING STATION USING PARTICLE SWARM OPTIMIZATION</strong>');
disp('<strong>                             TESTED IN IEEE 33 BUS SYSTEM                        </strong>');
disp('<strong>****************************************************************************************</strong>');
pause(2);

disp('<strong>-------------------</strong>');
disp('<strong>EXECUTING BASE CASE</strong>');
disp('<strong>-------------------</strong>');
pause(1);
tic;

[objective_result]=loadflow_basecase_test(nbus,sw_open,radial_check,data_pass_to_loadflow);


REAL_POWER_LOSS_BASE_CASE=objective_result{2};
REACTIVE_POWER_LOSS_BASE_CASE=objective_result{3};
VOLTAGE_BASE_CASE=objective_result{4};
plossbase=objective_result{5};
qlossbase=objective_result{6};
data_pass_to_loadflow{22}=objective_result;
BASE_CASE{1,1}=num2str(objective_result{2});
BASE_CASE{2,1}=num2str(objective_result{3});
BASE_CASE{3,1}=num2str(sw_open);
BASE_CASE{4,1}=num2str('NIL');
BASE_CASE{5,1}=num2str('NIL');
BASE_CASE{6,1}=num2str('NIL');
BASE_CASE{7,1}=num2str('NIL');
BASE_CASE{8,1}=num2str(min(objective_result{4}));
BASE_CASE{9,1}=num2str(max(objective_result{4}));
BASE_CASE{10,1}=num2str(toc);

disp('<strong>------------------------------------------------------------------------------------</strong>');
disp('<strong>EXECUTING OPTIMAL PLACEMENT OF ELECRIC VEHICLE CHARGING STATIONS USING PSO ALGORITHM</strong>');
disp('<strong>------------------------------------------------------------------------------------</strong>');

pause(1);
tic;
min_val1=2;   % lower limit
max_val1=nbus;  % upper limit
min_val2=EV_NUMBER_MIN;  % lower limit
max_val2=EV_NUMBER_MAX; % upper limit
radial_check=0;

% algorithm process

[algorithm_result,final_fit_art] = PSO_EVtest(nbus,no_of_int_pop,no_of_iter,min_val1,min_val2,max_val1,max_val2,sw_open,radial_check,data_pass_to_loadflow);
conver_evpso=final_fit_art; 
objective_result=LOAD_FLOW_PROCESS_EV(nbus,algorithm_result,data_pass_to_loadflow);
REAL_POWER_LOSS_EV_PLACEMENT=objective_result{2};
REACTIVE_POWER_LOSS_EV_PLACEMENT=objective_result{3};
VOLTAGE_EV_PLACEMENT_PSO=objective_result{4};
EV_LOCATION=objective_result{11};
NUMBER_OF_EV=objective_result{12};
REAL_POWER_EV=objective_result{13};
REACTIVE_POWER_EV=objective_result{14};

EVCS_PLACEMENT_PSO_ALG{1,1}=num2str(objective_result{2});
EVCS_PLACEMENT_PSO_ALG{2,1}=num2str(objective_result{3});
EVCS_PLACEMENT_PSO_ALG{3,1}=num2str(sw_open);
EVCS_PLACEMENT_PSO_ALG{4,1}=num2str(EV_LOCATION);
EVCS_PLACEMENT_PSO_ALG{5,1}=num2str(NUMBER_OF_EV);
EVCS_PLACEMENT_PSO_ALG{6,1}=num2str(REAL_POWER_EV);
EVCS_PLACEMENT_PSO_ALG{7,1}=num2str(REACTIVE_POWER_EV);
EVCS_PLACEMENT_PSO_ALG{8,1}=num2str(min(objective_result{4}));
EVCS_PLACEMENT_PSO_ALG{9,1}=num2str(max(objective_result{4}));
EVCS_PLACEMENT_PSO_ALG{10,1}=num2str(toc);

Resulttest




