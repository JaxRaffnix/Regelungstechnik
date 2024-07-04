%___________________________________________________________________
% run simulation
model = 'pidController';

R6 = 2e3;
C2 = 1e-7;
C3 = 1e-6;

% R6 = 1e3;
% C2 = 90e-9;
% C3 = 1e-1;

POINTS = 100;
STOPTIME = 0.1;

load_system(model)
set_param(model,...
    'SolverType','Variable-step', ...
    'SolverName', 'VariableStepAuto', ...
    'MaxStep', num2str(STOPTIME / POINTS), ...
    'StopTime', num2str(STOPTIME));
output = sim(model);

%___________________________________________________________________
% find t*
data = get(output.yout, 'control').Values.Data;
max_value = max(data);
value_t = 5 * 0.98;
[~, index] = min(abs(data-value_t));
time_t = output.tout(index);

fprintf('Value: %f, Index: %.6f\nMaxValue: %f', value_t, time_t, max_value);    % maxvalue =  5.158215

%___________________________________________________________________
% plotting
pid_plot = tiledlayout('vertical');

nexttile
plot(output.tout, get(output.yout, 'reference').Values.Data);
hold on
plot(output.tout, get(output.yout, 'control').Values.Data);
% title('Drehzal');
% ylabel('Drehzal in rad/s')
xlabel(pid_plot, 'Zeit in s')
xline(time_t , ':',['t* = ' sprintf('%.3f', time_t)])
legend('Führungsgröße', 'Regelgröße');

nexttile
plot(output.tout, get(output.yout, 'manipulated').Values.Data);
hold on
% ylabel('Spannung in V')
% title('Spannung');
legend('Stellgröße');

%___________________________________________________________________
% export and close system

saveas(pid_plot, 'graphPidController.png')
saveas(get_param(model, 'Handle'), 'blockPidController.png')

save_system(model);
close_system(model);

% save_system('pidController',[],'OverwriteIfChangedOnDisk',true)