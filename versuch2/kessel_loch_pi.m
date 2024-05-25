%___________________________________________________________________
% global parameters
LOCAL_DIRECTORY = 'C:\Users\janho\Coding\Regelungstechnik\versuch2\';

KR = 1e-2;

%___________________________________________________________________
% load model
model = 'kessel_loch_pi_modell';
load_system(model);

%___________________________________________________________________
% find optimum TN
TN = 800;
max_value = 10;
% while max(output.yout{2}.Values.Data) > output.yout{1}.Values.Data(1)
while max_value > 0.1
    output = sim(model);
    max_value = max(output.yout{3}.Values.Data);
    TN = TN + 1
end
disp(fprintf('TN max = %f', TN))

save_system(model)
close_system(model);
