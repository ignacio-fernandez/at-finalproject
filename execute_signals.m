function orderId = execute_signals(dollar, symbol,signals, close)

result = zeros(1, size(signals, 2));

for i = 1:size(signals, 2)
    column = signals(:, i);
    
   
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

action = result(end);
if action ~= 0
    if action > 0
        action = 'BUY';
    else
        action = 'SELL';
    end
    
    N = round(dollar / close(end), 0);
   
    
    orderId = IBMatlab('action', action, 'symbol', symbol, 'quantity', N, 'type', 'MKT');
else
    orderId = NaN;
end
