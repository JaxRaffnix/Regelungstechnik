%___________________________________________________________________
% run simulation
model = 'pController';

KR_LIST = [7, 8, 9, 9.45, 10];

STOPTIME = 0.1;
POINTS = 1e3;

load_system(model)
set_param(model,...
    'SolverType','Variable-step', ...
    'SolverName', 'VariableStepAuto', ...
    'MaxStep', num2str(STOPTIME / POINTS), ...
    'StopTime', num2str(STOPTIME), ...
    'FixedStep', num2str(POINTS));

%___________________________________________________________________
% plotting
p_plot = tiledlayout('flow');

for i = 1:length(KR_LIST)
    KR = KR_LIST(i);
    output = sim(model);

    nexttile
    plot(output.tout, get(output.yout, 'reference').Values.Data);
    hold on
    plot(output.tout, get(output.yout, 'control').Values.Data);
    title(sprintf('KR = %.2f', KR));
    % ylabel('Drehzal in rad/s')
    xlabel(p_plot, 'Zeit in s')
end
legend('Führungsgröße', 'Regelgröße');
% lgd = legend('Führungsgröße', 'Regelgröße');
% lgd.Location = 'southeastoutside';

%___________________________________________________________________
% export and close system

saveas(p_plot, 'graphPController.png')
saveas(get_param(model, 'Handle'), 'blockPController.png')

save_system(model);
close_system(model, 0);