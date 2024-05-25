function index = time_constant(data, rising_data)
    % GOAL: find the index number of the time constant value in a list

    % Check if the data is not empty
    if isempty(data)
        error('Input data is empty.');
    end

    if rising_data == true
        OFFSET = 0.632;
    else
        OFFSET = (1 - 0.632);
    end

    max_value = max(data);
    value_tau = max_value * OFFSET;
    [~, index] = min(abs(data - value_tau ));
end