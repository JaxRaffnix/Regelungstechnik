%___________________________________________________________________
% find optimum TN and run simulation

% addpath('../functions/')

model = 'piControllerLoad';
rotationSpeedControl = 100;
TN = 2.44;

% bestTN = BestResetTime(model, 'TN', 'rotation speed', 2.4, 0.01)
% = 2.5

output = sim(model);

%___________________________________________________________________
% plotting
figure
load_plot = tiledlayout('vertical');

nexttile
plot(output.tout, get(output.yout, 'rotation speed control').Values.Data);
hold on
plot(output.tout, get(output.yout, 'rotation speed').Values.Data);
title('Drehzal');
ylabel('Drehzal in rad/s')
legend('Führungsgröße', 'Regelgröße');

nexttile
plot(output.tout, get(output.yout, 'voltage').Values.Data);
hold on
ylabel('Spannung in V')
yyaxis right
plot(output.tout, get(output.yout, 'controller voltage').Values.Data);
title('Spannung');
ylabel('Spannung in V')
xlabel(load_plot, 'Zeit in s')
legend('Begrenzer', 'Regler');

nexttile
plot(output.tout, get(output.yout, 'motor torque').Values.Data);
hold on
% yyaxis right
plot(output.tout, get(output.yout, 'total torque').Values.Data);
title('Drehmoment');
ylabel('Drehmoment in NM')
xlabel(load_plot, 'Zeit in s')
legend('Motor','Gesamt');

saveas(load_plot, "graphPiControllerLoad.png");
saveas(get_param(model, 'Handle'), 'blockPiControllerLoad.png')

% save_system(model);
close_system(model);