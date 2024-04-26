% global parameters
LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";
STOPTIME = 70*60 - 1;
POINTS = 1e2;

STEPSIZE = STOPTIME / POINTS;


% set model parameters
model = LOCAL_DIRECTORY +  'tempregler_modell.slx';
k1 = 10/400;
k2 = 400/230;
time_const = 15*60;

% run first simulation
controlller_on = 0.2;
controller_off = -0.2;
output = sim(model, "StopTime", num2str(STOPTIME), 'FixedStep', num2str(STEPSIZE));  % 1: control variable, 2: manipulated_variable, 3: reference_variable

% second simulation with changed parameters
controlller_on = 0.01;
controller_off = -0.01;
output_new = sim(model, "StopTime", num2str(STOPTIME), 'FixedStep', num2str(STEPSIZE));  % 1: control variable, 2: manipulated_variable, 3: reference_variable

figure;
subplot(1,2,1)      % rows, columns, position
outputplot = tiledlayout(3,1);
title(outputplot, "alte controller werte")
nexttile
plot(output.yout{1}.Values.Time, output.yout{1}.Values.Data)
nexttile
plot(output.yout{2}.Values.Time, output.yout{2}.Values.Data)
nexttile
plot(output.yout{2}.Values.Time, output.yout{3}.Values.Data)

subplot(1,2,2)      % rows, columns, position
outputplot_new = tiledlayout(3,1);
nexttile
plot(output_new.yout{1}.Values.Time, output_new.yout{1}.Values.Data)
nexttile
plot(output_new.yout{2}.Values.Time, output_new.yout{2}.Values.Data)
nexttile
plot(output_new.yout{2}.Values.Time, output_new.yout{3}.Values.Data)
title(outputplot_new, "neue controller werte")