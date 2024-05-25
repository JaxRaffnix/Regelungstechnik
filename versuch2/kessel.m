addpath('../functions/')

%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';

KR_LIST =           [1e-2, 5e-3, 1e-3, 5e-4, 1e-4];
STOPTIME_LIST =     [20, 30, 200, 500, 2000];
ERROR_MARGIN_LIST = [1e-5, 1e-5, 1e-6, 1e-6, 1e-7];

%___________________________________________________________________
% load model
model = 'kessel_modell';
load_system(model);

%___________________________________________________________________
% run simulation 
figure
kessel_plot = tiledlayout('flow');

for i = 1:length(KR_LIST)
    set_param(model,...
        'StopTime', num2str(STOPTIME_LIST(i)), ...
        "SolverType","Variable-step", ...
        "SolverName", "VariableStepAuto" ...
    )
    KR = KR_LIST(i);
    
    output = sim(model);

    % find the time constant value
    index = time_constant(output.yout{3}.Values.Data, false);
    tau = output.yout{3}.Values.Time(index);
    fprintf('KR = %.4f \t Tau = %.4f\n', KR, tau)

    ERROR_MARGIN = ERROR_MARGIN_LIST(i);
    max_value = output.yout{3}.Values.Data(1);
    q_t = max_value * (1 - 0.632);
    index_list = find(abs(output.yout{3}.Values.Data - q_t) < ERROR_MARGIN);
    t_t_index = index_list(1);
    t_t = output.yout{3}.Values.Time(t_t_index);
    fprintf('KR = %.4f \t Tau = %.4f\n', KR, t_t)

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
        xline(tau, ':', 'Time constant')
end

lgd = legend('Führungsgröße', 'Stellgröße', 'Regelgröße');
lgd.Layout.Tile = 'south';
lgd.NumColumns = 3;


saveas(kessel_plot, LOCAL_DIRECTORY + "kessel_plot.png")
% print('-skessel_modell', '-dpng',  LOCAL_DIRECTORY + 'kessel_block.png')

save_system(model)
close_system(model);
