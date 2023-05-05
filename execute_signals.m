function orderId = execute_signals(dollar, symbol,signals, close)

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
        action = 'BUY';
    else
        action = 'SELL';
    end

    orderId = IBMatlab('action', action, 'symbol', symbol, 'quantity', N, 'type', 'MKT');
elseif signal ~= 0
    if signal > 0
        action = 'BUY';
    else
        action = 'SELL';
    end   
    
    orderId = IBMatlab('action', action, 'symbol', symbol, 'quantity', N, 'type', 'MKT');
else
    orderId = NaN;
end
end

