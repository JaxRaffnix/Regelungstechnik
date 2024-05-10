%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';

KR_LIST =           [1e-2, 5e-3, 1e-3, 5e-4, 1e-4];
STOPTIME_LIST =     [1e1 , 2e1 , 4e1 , 6e1 , 8e1];

%___________________________________________________________________
% load model
model = 'kessel_loch_p_modell';
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

    % plotting
    nexttile
    yyaxis left
        plot(output.tout, output.yout{1}.Values.Data);
        ylabel('Höhe in m')
        ylim padded % little margin on the y-axis
        hold on 
        plot(output.tout, output.yout{3}.Values.Data);
        hold on
    yyaxis right
        plot(output.yout{2}.Values.Time, output.yout{2}.Values.Data);
        ylabel('Durchfluss in m^3/s')
        title(sprintf('KR = %.4f', KR))
        xlabel('Zeit in s')
end

lgd = legend('Führungsgröße', 'Stellgröße', 'Regelgröße');
lgd.Layout.Tile = 'south';
lgd.NumColumns = 3;


saveas(kessel_plot, LOCAL_DIRECTORY + "kessel_loch_p_plot.png")
% print('-skessel_modell', '-dpng',  LOCAL_DIRECTORY + 'kessel_block.png')

save_system(model)
close_system(model);
