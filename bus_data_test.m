function busdata = bus_data_test(nbus)

busdata33=[1	0         0  	  0
    2	100       60 	  0
    3	90        40      0  	
    4	120       80	  0  
    5	60        30	  0  
    6	60        20      0 
    7	200       100	  0
    8	200       100	  0 
    9	60        20      0	
    10	60        20 	  0
    11	45        30 	  0
    12	60        35      0 
    13	60        35      0 
    14	120       80      0 
    15	60        10      0 
    16	60        20      0 
    17	60        20      0 
    18	90        40      0 
    19	90        40      0 
    20	90        40      0 
    21	90        40      0
    22	90        40      0 
    23	90        50      0
    24	420       200	  0
    25	420       200	  0
    26	60        25      0  
    27	60        25      0 
    28	60        20      0
    29	120       70      0
    30	200       600	  0
    31	150       70      0  
    32	210       100	  0
    33	60        40      0];

busdata11=[1	0         0  	  0
    2	80       60 	  0
    3	96        128     0  	
    4	128       96	  0  
    5	120       60	  0  
    6	90        120     0 
    7	189       252	  0
    8	80       60	      0 
    9	80        60      0	
    10	160       120 	  0
    11	80       60 	  0];

if (nbus==33)
    busdata = busdata33;

elseif (nbus==11)
    busdata = busdata11
end
