function resetTime = BestResetTime(model, outport)
    % Goal: change the reset time 'TN' so that there is no overshoot
    % CAVE: reset time has to be specified as 'TN' in the simulink model!

    TN = 1;
    maxValue = 200;
    control = 100;
    step = 0.1;

    while maxValue > control  
        TN = TN - step;
        assignin('base','TN',TN)
        output = sim(model);

        maxValue = max(output.yout{outport}.Values.Data);
    end

    fprintf('TN max = \t%f \n MaxValue = \t%f', TN, maxValue);
    resetTime = TN;

end