LOCAL_DIRECTORY = "C:\Users\janho\Coding\Regelungstechnik\versuch1\";

param_k1 = 10/400;
param_k2 = 400/230;

param_time_const = 15*60;

param_switch_on = 0.2;
param_switch_off = -0.2;
param_switch_maxv = 230;


% sim(LOCAL_DIRECTORY + 'temp_regler.slx')
% mdl = "IntegrateSine";
% open("mdl")

model = LOCAL_DIRECTORY +  'tempregler_modell.slx';