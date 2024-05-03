%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';
STEPTIME = 1;
POINTS = 1e3;
STEPSIZE = STEPTIME / POINTS;
SURFACE_AREA = pi*(18e-2)^2;

KR_list = {1,2,3,4,5};

%___________________________________________________________________
% load model
model = 'kessel_modell';
load_system(model);
set_param(model,...
    'MaxStep', num2str(STEPSIZE), ...
    'StopTime', num2str(STOPTIME));

%___________________________________________________________________
% run simulation 
for i = 1:3
    KR = KR_list(i);
    output = sim(model);

    % plotting
    figure
    for j = 1:3
        plot(output_1.tout, output_1.yout{i}.Values.Data);
        hold on 
    end
    xlabel('Zeit in s')
end

%___________________________________________________________________
% plotting
% label = {'Führungsgröße', 'Stellgröße', 'Regelgröße'};
% unit = {'Höhe in m', 'Zufluss in m^3/s', 'Höhe in m'};

% figure
% kessel_plot = tiledlayout('vertical');
% for i = 1:3
%     nexttile
%     plot(output_1.tout, output_1.yout{i}.Values.Data);
%     title(label(i))
%     ylabel(unit(i))
% end
% xlabel('Zeit in s')
