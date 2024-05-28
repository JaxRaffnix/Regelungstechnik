function bestResetTime = BestResetTime(model, resetTimeName, variableName, initialGuess, stepSize)
    % Goal: Find the best reset time for a given Simulink model to ensure there is no overshoot a variable.
    % CAVE: - initalGuess has to result in an overshoot.
    %       - variable has to be linked to an outport.
    %       - After the function execution, the model is closed.
    %       - steady state at the last data points is assumed. 

    validateattributes(model, {'char', 'string'}, {'nonempty'}, mfilename, 'model', 1);
    validateattributes(resetTimeName, {'char', 'string'}, {'nonempty'}, mfilename, 'resetTimeName', 2);
    validateattributes(variableName, {'char', 'string'}, {'nonempty'}, mfilename, 'variableName', 3);
    validateattributes(initialGuess, {'numeric'}, {'scalar', 'positive'}, mfilename, 'initialGuess', 4);
    validateattributes(stepSize, {'numeric'}, {'scalar', 'positive'}, mfilename, 'stepSize', 5);

    % get current data
    load_system(model);
    assignin('base', resetTimeName, initialGuess)
    output = sim(model);
    data = get(output.yout, variableName).Values.Data;
    threshold = data(end);

    % Check if initial guess causes overshoot
    if max(data) < threshold
        error('No overshoot for initial guess %.4f. Decrease initialGuess.', initialGuess);
    end
    
    % Loop until no overshoot compared to threshold
    TN = initialGuess;
    maxValue = inf;
    while maxValue > threshold  
        TN = TN + stepSize;
        if TN <= 0  % Check if TN is non-positive to avoid infinite loop
            error('TN %.4f has become negative or 0. Stopping the simulation.', TN);
        end
        assignin('base', resetTimeName, TN)

        output = sim(model);
        data = get(output.yout, variableName).Values.Data;
        maxValue = max(data);
        fprintf('Testing reset time: %.4f, Max value: %.4f\n', TN, maxValue);
    end

    close_system(model, 0);
    bestResetTime = TN;
    fprintf('Best reset time found: %.4f\n', bestResetTime);
end