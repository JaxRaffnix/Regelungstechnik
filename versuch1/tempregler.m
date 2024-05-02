% global parameters
LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";
STOPTIME = 70*60 - 1;   % hide last data point to hide second positive flank of the pulse generator
POINTS = 1e7;

STEPSIZE = STOPTIME / POINTS;


% set model parameters
model = LOCAL_DIRECTORY +  'tempregler_modell.slx';
k1 = 10/400;
k2 = 400/230;
time_const = 15*60;

% run first simulation
controlller_on = 0.2;
controller_off = -0.2;
% output = sim(model, "StopTime", num2str(STOPTIME), 'FixedStep', num2str(STEPSIZE));  % 1: control variable, 2: manipulated_variable, 3: reference_variable
options = simset('SrcWorkspace','current');
set_param(model, 'FixedStep', '0.00001')
output = sim(model, "StopTime", num2str(STOPTIME));  % 1: control variable, 2: manipulated_variable, 3: reference_variable

% second simulation with changed parameters
controlller_on = 0.01;
controller_off = -0.01;
output_new = sim(model, "StopTime", num2str(STOPTIME), 'FixedStep', "0.0001");  % 1: control variable, 2: manipulated_variable, 3: reference_variable


% plotting
label = {"Führungsgröße", "Stellgröße", "Regelgröße"};
unit = {"Temperatur in °C", "Spannung in V", "Temperatur in °C"};

figure;
tempregler_plot = tiledlayout("vertical");
nexttile(tempregler_plot);
plot(output.yout{1}.Values.Time, output.yout{1}.Values.Data, output.yout{3}.Values.Time, output.yout{3}.Values.Data);
xlabel("Zeit in s")
ylabel("Temperatur in °C")

yyaxis right
plot(output.yout{2}.Values.Time, output.yout{2}.Values.Data);
ylabel("Spannung in V")

legend("Führungsgröße", "Stellgröße", "Regelgröße")
    
saveas(tempregler_plot, LOCAL_DIRECTORY + "tempregler_plot.png")

figure;
tempregler_plot_new = tiledlayout("vertical");
for i = 1:3
    nexttile
    plot(output_new.yout{1}.Values.Time, output_new.yout{i}.Values.Data);
    title(label(i))
    ylabel(unit(i))
end
xlabel(tempregler_plot_new, "Zeit in s")
saveas(tempregler_plot_new, LOCAL_DIRECTORY + "tempregler_plot_new.png")

% save block diagram
print('-stempregler_modell', '-dpng', LOCAL_DIRECTORY + 'tempregler_block.png')
