% global parameters
LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";
STOPTIME = 70*60 - 1;   % hide last data point to hide second positive flank of the pulse generator
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

% plotting
variables = {"Führungsgröße", "Stellgröße", "Regelgröße"};
unnit = {"Spannung in V", };
figure;
% title(outputplot, "alte controller werte")
subplot(3,2,1)      % rows, columns, position
plot(output.yout{1}.Values.Time, output.yout{1}.Values.Data)
subplot(3,2,3)
plot(output.yout{2}.Values.Time, output.yout{2}.Values.Data)
subplot(3,2,5)
plot(output.yout{2}.Values.Time, output.yout{3}.Values.Data)

subplot(3,2,2)
plot(output_new.yout{1}.Values.Time, output_new.yout{1}.Values.Data)
subplot(3,2,4)
plot(output_new.yout{2}.Values.Time, output_new.yout{2}.Values.Data)
subplot(3,2,6)
plot(output_new.yout{2}.Values.Time, output_new.yout{3}.Values.Data)

% save block diagram
print('-stempregler_modell', '-dpng', LOCAL_DIRECTORY + 'output.png')
