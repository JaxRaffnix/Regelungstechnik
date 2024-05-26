addpath('../functions/')

%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';

KR_LIST =           [1e-2, 5e-3, 1e-3, 5e-4, 1e-4];
STOPTIME_LIST =     [20, 30, 200, 500, 2000];

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
    index = TimeConstantIndex(output.yout{3}.Values.Data);
    tau = output.yout{3}.Values.Time(index);
    fprintf('KR = %.4f \t Tau = %.4f\n', KR, tau)

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
