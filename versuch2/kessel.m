%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';
% STOPTIME = 500;
% POINTS = 1e3;
% STEPSIZE = STOPTIME / POINTS;
SURFACE_AREA = pi*(18e-2)^2;

KR_LIST = [0.01,0.005,0.001,0.0005,0.0001];
STOPTIME_LIST = [80, 150, 600, 1500, 6000];

ERROR_MARGIN_LIST = [1e-5, 1e-5, 1e-6, 1e-6, 1e-7];

%___________________________________________________________________
% load model
model = 'kessel_modell';
load_system(model);
%     'MaxStep', num2str(STEPSIZE), ...

    

%___________________________________________________________________
% run simulation 
figure
kessel_plot = tiledlayout('flow');

% for i = 1:length(KR_LIST)
for i = 1:5
    set_param(model,...
        'StopTime', num2str(STOPTIME_LIST(i)), ...
        "SolverType","Variable-step", ...
        "SolverName", "VariableStepAuto" ...
    )

    KR = KR_LIST(i);
    output = sim(model);

    % find the time constant value
    ERROR_MARGIN = ERROR_MARGIN_LIST(i);
    max_value = output.yout{3}.Values.Data(1);
    q_t = max_value * (1 - 0.632);
    index_list = find(abs(output.yout{3}.Values.Data - q_t) < ERROR_MARGIN);
    t_t_index = index_list(1);
    t_t = output.yout{3}.Values.Time(t_t_index);
    disp(fprintf('KR = %.4f \t Tau = %.4f', KR, t_t))

    % plotting
    nexttile
    yyaxis left
        plot(output.tout, output.yout{1}.Values.Data);
        ylabel('Höhe in m')
        ylim padded % little margin on the y-axis
        hold on 
        plot(output.tout, output.yout{2}.Values.Data);
        hold on
    yyaxis right
        plot(output.yout{3}.Values.Time, output.yout{3}.Values.Data);
        ylabel('Durchfluss in m^3/s')
        title(sprintf('KR = %.4f', KR))
        xlabel('Zeit in s')

        %plot time constant
        xline(t_t, ':', 'Time constant')
        yline(q_t)
end

lgd = legend('Führungsgröße', 'Stellgröße', 'Regelgröße');
lgd.Layout.Tile = 'south';
lgd.NumColumns = 3;


saveas(kessel_plot, LOCAL_DIRECTORY + "kessel_plot.png")
% print('-skessel_modell', '-dpng',  LOCAL_DIRECTORY + 'kessel_block.png')

save_system(model)
close_system(model);
