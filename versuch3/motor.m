
addpath('../functions/')

%___________________________________________________________________
% run simulation 
model = 'motor_modell';
load_system(model);

output = sim(model);

%___________________________________________________________________
% find the time constant value

index = time_constant(output.yout{3}.Values.Data, true);
tau = output.tout(index)

%___________________________________________________________________
% plotting
figure
motor_plot = tiledlayout('vertical');
nexttile
plot(output.tout, output.yout{1}.Values.Data);
title('Strom');
ylabel('Strom in A')
nexttile
plot(output.tout, output.yout{2}.Values.Data);
title('Drehmoment');
ylabel('Drehmoment in Nm')
nexttile
plot(output.tout, output.yout{3}.Values.Data);
title('Drehzal');
ylabel('Drehzal in rad/s')
xlabel(motor_plot, 'Zeit in s')

saveas(motor_plot, "motor_plot.png")

save_system(model)
close_system(model);