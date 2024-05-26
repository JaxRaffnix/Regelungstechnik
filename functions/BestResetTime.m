function bestResetTime = BestResetTime(model, variableName, outport, initialGuess, valueThreshold, stepSize)
    % Goal: Find the best reset time for a given Simulink model to ensure there is no overshoot a variable.
    % CAVE: - reset time has to be specified as 'TN' in the simulink model!
    %       - variable has to be linked to an outport.
    %       - after the function the model is closed.

    load_system(model);

    assignin('base', variableName, initialGuess)
    output = sim(model);
    if max(output.yout{outport}.Values.Data) < valueThreshold
        error('No overshoot for initial guess %.4f. Increase or decrease initialGuess.', initialGuess);
    end
    
    TN = initialGuess;
    maxValue = inf;

    while maxValue > valueThreshold  
        TN = TN - stepSize;
        % Check if TN is getting too small to avoid potential infinite loop
        if TN <= 0
            error('TN %.4f has become negative or 0. Stopping the simulation.', TN);
            % break;
        end
        assignin('base', variableName, TN)
        output = sim(model);

        maxValue = max(output.yout{outport}.Values.Data);
        fprintf('TN = \t\t%f \nMaxValue = \t%f\n', TN, maxValue);
    end

    close_system(model, 0);
    bestResetTime = TN;

end