%___________________________________________________________________
% global parameters
addpath('../functions/')

KR = 1e-2;
model = 'kessel_loch_pi_modell';

%___________________________________________________________________
% find optimum TN

bestTN = BestResetTime(model, 'TN', 3, 10, 0.1, 1)

