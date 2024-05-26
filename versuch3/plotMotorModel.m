
addpath('../functions/')

%___________________________________________________________________
% run simulation 
model = 'motorModel';
load_system(model);

output = sim(model);

%___________________________________________________________________
% find the time constant value

index = TimeConstantIndex(output.yout{3}.Values.Data);
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
%plot time constant
xline(tau, ':', ['\tau = ' sprintf('%.2f', tau)])

saveas(motor_plot, "motor_plot.png")

save_system(model)
close_system(model);