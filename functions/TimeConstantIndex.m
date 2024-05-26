function index = TimeConstantIndex(data)
    % GOAL: find the index number of the time constant value in a list

    % Check if the data is not empty
    if isempty(data)
        error('Input data is empty.');
    elseif ~isnumeric(data) || ~isvector(data)
        error('Input data must be a numeric vector.');
    end

    % check if the data is increasing or decreasing and set the offset
    diffs = diff(data);

    % Ensure the data is strictly monotonic
    if all(diffs >= 0)
        is_rising = true;
    elseif all(diffs <= 0)
        is_rising = false;
    else
        error('Input data must be monotonic increasing or decreasing.');
    end

    OFFSET = 0.632;
    if is_rising == false
        OFFSET = 1 - OFFSET;
    end

    % find the index of the time constant
    max_value = max(data);
    value_tau = max_value * OFFSET;
    [~, index] = min(abs(data - value_tau ));
end