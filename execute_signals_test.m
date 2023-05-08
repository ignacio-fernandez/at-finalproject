function [pos, closePx] = execute_signals_test(dollar, symbol,signals, close, position)

disp(signals);
result = zeros(1, size(signals, 2));

for i = 1:size(signals, 2)
    column = signals(2:end, i);
    macd = signals(1,i);
    
   
    [uniqueNums, ~, indices] = unique(column);
    counts = accumarray(indices, 1);
    
    maxCount = max(counts);
    if maxCount > 1
        maxIndices = find(counts == maxCount);
        if length(maxIndices) == 1
            result(i) = uniqueNums(maxIndices);
        end
    end
end

signal = result(end);
N = round(dollar / close(end), 0);
if macd(end) ~= 0
    % trade on mac d
    if macd(end) > 0
        if position >= 0
            action = 'BUY';
        else
            action = 'BUY';
            N = N - position;
        end
    else
        if position <= 0
            action = 'SELL';
            N = -N;
        else
            action = 'SELL';
            N = -N - position;
        end
    end

    pos = N;
    closePx = close(end);
elseif signal ~= 0
    if signal > 0
         if position >= 0
            action = 'BUY';
        else
            action = 'BUY';
            N = N - position;
        end
    else
        if position <= 0
            action = 'SELL';
            N = -N;
        else
            action = 'SELL';
            N = -N - position;
        end
    end
    
    pos = N;
    closePx = close(end);
else
    pos = [];
    closePx = [];
end
end