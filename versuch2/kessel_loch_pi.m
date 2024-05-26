%___________________________________________________________________
% global parameters
addpath('../functions/')

model = 'kessel_loch_pi_modell';

%___________________________________________________________________
% find optimum TN

bestTN = BestResetTime(model, 'TN', 'control_variable', 7, 0.1, 0.1)
% = 8.5
