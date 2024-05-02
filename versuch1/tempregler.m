% global parameters
LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";
STOPTIME = 70*60 - 1;   % hide last data point to hide second positive flank of the pulse generator
POINTS = 1e4;

STEPSIZE = STOPTIME / POINTS    % = 0.42


% set model parameters
k1 = 10/400;
k2 = 400/230;
time_const = 15*60;
controlller_on = 0.2;
controller_off = -0.2;

% first simulation
%model = LOCAL_DIRECTORY +  'tempregler_modell.slx';
model = "tempregler_modell";
load_system(model);

% open_system(model);
set_param(model,...
    "SolverType","Variable-step", ...
    "SolverName", "VariableStepAuto", ...
    "MaxStep", num2str(STEPSIZE), ...
    "StopTime", num2str(STOPTIME));
output = sim(model);    % 1: control variable, 2: manipulated_variable, 3: reference_variable

% second simulation with changed parameters
controlller_on = 0.3;
controller_off = -0.3;
output_new = sim(model);    % 1: control variable, 2: manipulated_variable, 3: reference_variable


% plotting
label = {"Führungsgröße", "Stellgröße", "Regelgröße"};
unit = {"Temperatur in °C", "Spannung in V", "Temperatur in °C"};

figure;
tempregler_plot = tiledlayout("vertical");
nexttile(tempregler_plot);
plot(output.yout{1}.Values.Time, output.yout{1}.Values.Data);
hold on
plot(output.yout{3}.Values.Time, output.yout{3}.Values.Data)
xlabel("Zeit in s")
ylabel("Temperatur in °C")

yyaxis right
plot(output.yout{2}.Values.Time, output.yout{2}.Values.Data);
ylabel("Spannung in V")

legend("Führungsgröße", "Regelgröße", "Stellgröße")
    
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
