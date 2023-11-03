function [linedata,radial_cond] = LINE_DATA_test(nbus,sw_open,radial_check)




linedata33=[1    1      2     0.0922    0.0470
    2    2      3     0.4930    0.2511
    3    3      4     0.3660    0.1864
    4    4      5     0.3811    0.1941
    5    5      6     0.8190    0.7070
    6    6      7     0.1872    0.6188
    7    7      8     0.7114    0.2351
    8    8      9     1.0300    0.7400
    9    9      10    1.0440    0.7400
    10    10     11    0.1966    0.0650
    11    11     12    0.3744    0.1238
    12    12     13    1.4680    1.1550
    13    13     14    0.5416    0.7129
    14    14     15    0.5910    0.5260
    15    15     16    0.7463    0.5450
    16    16     17    1.2890    1.7210
    17    17     18    0.7320    0.5740
    18     2     19    0.1640    0.1565
    19    19     20    1.5042    1.3554
    20    20     21    0.4095    0.4784
    21    21     22    0.7089    0.9373
    22     3     23    0.4512    0.3083
    23    23     24    0.8980    0.7091
    24    24     25    0.8960    0.7011
    25     6     26    0.2030    0.1034
    26    26     27    0.2842    0.1447
    27    27     28    1.0590    0.9337
    28    28     29    0.8042    0.7006
    29    29     30    0.5075    0.2585
    30    30     31    0.9744    0.9630
    31    31     32    0.3105    0.3619
    32    32     33    0.3410    0.5302
    33     8     21    2.0000    2.0000
    34      9     15    2.0000    2.0000
    35     12     22    2.0000    2.0000
    36     18     33    0.5000    0.5000
    37     25     29    0.5000    0.5000];

linedata11=[1	1	2	1.695	1.575
    2	2	3	0.968	0.8995
    3	3	4	0.9705	0.9018
    4	4	5	1.017	0.945
    5	2	6	0.678	0.63
    6	6	7	1.017	0.945
    7	7	8	0.5755	0.5348
    8	8	9	0.5713	0.5309
    9	9	10	0.6056	0.5627
    10	10	11	0.6441	0.5985];


if(nbus==33)
    
    if(isempty(sw_open))
        
        linedata = linedata33;
        radial_cond=0;
        
    else
        sw_opent = sw_open;
        linedata = linedata33;
        linedatar1 = linedata33(:,1);
        ind = 1;

    for km = 1:length(sw_opent)
    
        locm1 = find(linedatar1 == sw_opent(km));
        if (~isempty(locm1))
            locm(ind,1) = locm1(1);
            ind = ind+1;
        end
       end

linedata(locm,:)=[];
if(radial_check==1)
          radial_cond=LOOP_CHECK_PROCESS(linedata);
    else
          radial_cond=0;
     end

    end
    elseif(nbus==11)
    if(isempty(sw_open))
        %fprintf('\n ---- inside empty ----- \n');
        
        linedata=linedata11;
        radial_cond=0;
    end
end


