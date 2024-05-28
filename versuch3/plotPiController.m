%___________________________________________________________________
% find optimum TN and run simulation

addpath('../functions/')

model = 'piController';
rotationSpeedControl = 100;

bestTN = BestResetTime(model, 'TN', 'rotation speed', 2.4, 0.01)
% = 2.5

output = sim(model);

%___________________________________________________________________
% plotting
figure
motor_plot = tiledlayout('vertical');

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
xlabel(motor_plot, 'Zeit in s')
legend('Begrenzer', 'Regler');

saveas(motor_plot, "graphPiController.png")

%___________________________________________________________________
% plot with new control variable 

rotationSpeedControl = 300;
output = sim(model);

figure
motor_plot_new = tiledlayout('vertical');

nexttile
plot(output.tout, get(output.yout, 'rotation speed control').Values.Data);
hold on
plot(output.tout, get(output.yout, 'rotation speed').Values.Data);
title('Drehzal');
ylabel('Drehzal in rad/s')
lgd = legend('Führungsgröße', 'Regelgröße');
lgd.Location = 'best';

nexttile
plot(output.tout, get(output.yout, 'voltage').Values.Data);
ylabel('Spannung in V')
hold on
yyaxis right
plot(output.tout, get(output.yout, 'controller voltage').Values.Data);
title('Spannung');
ylabel('Spannung in V')
legend('Begrenzer', 'Regler');

xlabel(motor_plot_new, 'Zeit in s')

saveas(motor_plot_new, "graphPiControllerNew.png");

saveas(get_param(model, 'Handle'), 'blockPiControllerNew.png')

% save_system(model);
close_system(model);