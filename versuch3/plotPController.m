
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
plot(output.tout, get(output.yout, 'current').Values.Data);
title('Strom');
ylabel('Strom in A')

nexttile
plot(output.tout, get(output.yout, 'torque').Values.Data);
title('Drehmoment');
ylabel('Drehmoment in Nm')

nexttile
plot(output.tout, get(output.yout, 'rotation speed').Values.Data);
title('Drehzal');
ylabel('Drehzal in rad/s')
xlabel(motor_plot, 'Zeit in s')

saveas(motor_plot, "p_regler_plot.png")

save_system(model)
close_system(model);