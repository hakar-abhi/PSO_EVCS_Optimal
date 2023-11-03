if nbus==33
    X = (1:33).';      %  X:  vector of bus number
elseif nbus==11
    X = (1:11).';
end
    

Y = VOLTAGE_BASE_CASE; %  Y:  vector of bus voltages in pu

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create plot
plot(X,Y,'DisplayName','Base Case','Parent',axes1,...
    'LineWidth',2,...
    'LineStyle','--',...
    'Color',[0.3010 0.7450 0.9330]);
ax = gca;

% Create ylabel
ylabel('Voltage(p.u)');
ax.YColor=[0 0.4470 0.7410];

% Create xlabel
xlabel('Node Number');
ax.XColor=[0 0.4470 0.7410];
ax.TitleFontSizeMultiplier = 0.8;

% Create title
title('Voltage Profile of Base Case');

box(axes1,'on');
grid(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'FontSize',15);
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'Location','east');

if nbus==33
    X1 = (1:33).';      %  X1:  vector of bus number
elseif nbus==11
    X1 = (1:11).';
end
Y1 = VOLTAGE_EV_PLACEMENT_PSO;   %  Y1:  vector of voltages after Optimal EV placement

X2 = no_of_iter;               %  X2:  no of iter
Y2 = conver_evpso;             %  Y2:  power loss data


% Create figure
figure1 = figure;

% Create subplot
subplot1 = subplot(2,1,1,'Parent',figure1);
hold(subplot1,'on');

% Create plot
plot(X1,Y1,'DisplayName','Voltage Profile with Optimal EV Placement',...
    'Parent',subplot1,...
    'LineWidth',2,...
    'Color',[0.4660 0.6740 0.1880]);

ax1 = gca;

% Create ylabel
ylabel('Voltage(p.u)');
ax1.YColor=[0 0.4470 0.7410];

% Create xlabel
xlabel('Node Number');
ax1.XColor=[0 0.4470 0.7410];
ax1.TitleFontSizeMultiplier = 0.8;

% Create title
title('PSO Algorithm--Voltage Profile--Optimal EVCS Placement');


box(subplot1,'on');
grid(subplot1,'on');
hold(subplot1,'off');
% Set the remaining axes properties
set(subplot1,'FontSize',15);
% Create legend
legend1 = legend(subplot1,'show');
set(legend1,'Location','east');


% Create subplot
subplot2 = subplot(2,1,2,'Parent',figure1);
hold(subplot2,'on');

% Create plot
plot(Y2,'DisplayName','Fitness value for number of iterations','Parent',subplot2,...
    'LineWidth',2,...
    'LineStyle','--',...
    'Color',[0.8500 0.3250 0.0980]);
ax2 = gca;

% Create ylabel
ylabel('Fitness');
ax2.YColor=[0 0.4470 0.7410];


% Create xlabel
xlabel('Iteration');
ax2.XColor=[0 0.4470 0.7410];
ax2.TitleFontSizeMultiplier = 0.8;

% Create title
title('PSO Algorithm-Convergence Graph-Optimal EVCS Placement');

box(subplot2,'on');
grid(subplot2,'on');
hold(subplot2,'off');
% Set the remaining axes properties
set(subplot2,'FontSize',15);
% Create legend
legend2 = legend(subplot2,'show');
set(legend2,'Location','east');


