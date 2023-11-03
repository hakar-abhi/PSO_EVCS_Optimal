


PARAMETERS = ["Total Active Power Loss";"Total Reactive Power Loss";"Network Tie Switch Numbers";"EV Location";"Number of Evs";"Real Power EV kW";"Reactive Power EV kVAR";"Voltage Minimum";"Voltage Maximum";"Execution time in Seconds"];


OPTIMAL_PLACEMENT_OF_EVCS = table;

OPTIMAL_PLACEMENT_OF_EVCS.PARAMETERS =PARAMETERS;
OPTIMAL_PLACEMENT_OF_EVCS.BASE_CASE = BASE_CASE;
OPTIMAL_PLACEMENT_OF_EVCS.UNDER_EVCS_PLACEMENT = EVCS_PLACEMENT_PSO_ALG;

OPTIMAL_PLACEMENT_OF_EVCS
plotstest