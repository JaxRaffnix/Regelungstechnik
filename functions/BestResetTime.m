function bestResetTime = BestResetTime(model, resetTimeName, variableName, initialGuess, valueThreshold, stepSize)
    % Goal: Find the best reset time for a given Simulink model to ensure there is no overshoot a variable.
    % CAVE: - initalGuess has to result in an overshoot.
    %       - variable has to be linked to an outport.
    %       - After the function execution, the model is closed.

    load_system(model);

    % Check if initial guess causes overshoot
    assignin('base', resetTimeName, initialGuess)
    output = sim(model);
    if max(get(output.yout, variableName).Values.Data) < valueThreshold
        error('No overshoot for initial guess %.4f. Decrease initialGuess.', initialGuess);
    end
    
    TN = initialGuess;
    maxValue = inf;

    % Loop until no overshoot compared to threshold
    while maxValue > valueThreshold  
        TN = TN + stepSize;
        % Check if TN is non-positive to avoid infinite loop
        if TN <= 0
            error('TN %.4f has become negative or 0. Stopping the simulation.', TN);
        end
        assignin('base', resetTimeName, TN)
        output = sim(model);

        maxValue = max(get(output.yout, variableName).Values.Data);
    end

    close_system(model, 0);
    bestResetTime = TN;

end