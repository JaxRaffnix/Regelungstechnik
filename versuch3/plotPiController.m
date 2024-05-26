
%___________________________________________________________________
% run simulation 
model = 'piController';
load_system(model);

%___________________________________________________________________
% find optimum TN

best = BestResetTime(model, 3);

output = sim(model);

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

saveas(motor_plot, "p_regler_plot.png")

save_system(model);
close_system(model);