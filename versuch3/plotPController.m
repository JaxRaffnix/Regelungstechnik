
%___________________________________________________________________
% run simulation 
model = 'pController';
load_system(model);

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
title('Eingangsspannung');
ylabel('Spannung in V')
xlabel(motor_plot, 'Zeit in s')

saveas(motor_plot, "graphPController.png");
saveas(get_param(model, 'Handle'), 'blockPController.png')

save_system(model)
close_system(model);