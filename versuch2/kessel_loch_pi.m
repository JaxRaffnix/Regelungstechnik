%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';

KR = 1e-2;
TN_LIST =       [1e1, 1e2, 1e3, 1e4];
STOPTIME_LIST = [4e1, 4e1, 2e1, 2e1];

%___________________________________________________________________
% load model
model = 'kessel_loch_pi_modell';
load_system(model);

%___________________________________________________________________
% run simulation 
figure
kessel_plot = tiledlayout('flow');

for i = 1:length(TN_LIST)
    set_param(model,...
        'StopTime', num2str(STOPTIME_LIST(i)), ...
        "SolverType","Variable-step", ...
        "SolverName", "VariableStepAuto" ...
    )
    TN = TN_LIST(i);
    
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
        title(sprintf('NT = %.0f', TN))
        xlabel('Zeit in s')
end

lgd = legend('Führungsgröße', 'Stellgröße', 'Regelgröße');
lgd.Layout.Tile = 'south';
lgd.NumColumns = 3;

%___________________________________________________________________
% find optimum TN
while output.yout{3}.Values.Data.max < output.yout{1}.Values.Data(1)
    TN = TN + 1;
end


saveas(kessel_plot, LOCAL_DIRECTORY + "kessel_loch_pi_plot.png")
% print('-skessel_modell', '-dpng',  LOCAL_DIRECTORY + 'kessel_block.png')

save_system(model)
close_system(model);
