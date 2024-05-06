%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';
STOPTIME = 500;
% POINTS = 1e3;
% STEPSIZE = STOPTIME / POINTS;
SURFACE_AREA = pi*(18e-2)^2;

KR_list = [0.01,0.005,0.001,0.0005,0.0001];

%___________________________________________________________________
% load model
model = 'kessel_loch_modell';
load_system(model);
set_param(model,...
    "SolverType","Variable-step", ...
    "SolverName", "VariableStepAuto" ...
)

%___________________________________________________________________
% run simulation 
figure
kessel_plot = tiledlayout('flow');

for i = 1:length(KR_list)
    KR = KR_list(i);
    output = sim(model);

    % plotting
    nexttile
        plot(output.tout, output.yout{1}.Values.Data);
        hold on 
        plot(output.tout, output.yout{2}.Values.Data);
        hold on
        yyaxis right
        plot(output.tout, output.yout{3}.Values.Data);
    hold off
    title(sprintf('KR = %f', KR))
end

xlabel(kessel_plot, 'Zeit in s')
lgd = legend('Führungsgröße in m', 'Regelgröße in m', 'Stellgröße in $\frac{m^3}{s}$', 'Interpreter','latex');
lgd.Layout.Tile = 'South';

save_system(model)
close_system(model);
