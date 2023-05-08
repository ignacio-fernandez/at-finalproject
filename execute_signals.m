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
        orderId = BuyOrder(symbol, N);
    else
        orderId = SellOrder(symbol, N);
    end

elseif signal ~= 0
    if signal > 0
        orderId = BuyOrder(symbol, N);
    else
        orderId = SellOrder(symbol, N);
    end
    
else
    orderId = NaN;
end
end

function B = BuyOrder(tickerB, N)
    position = get_position(tickerB);
    if position >= 0
        B = IBMatlab('action','BUY','symbol',tickerB,'quantity',N,'type','MKT');
    else
        B = IBMatlab('action','BUY','symbol',tickerB,'quantity',(-position)+N,'type','MKT');
    end
end


function S = SellOrder(tickerS, N)
    position = get_position(tickerS);
    if position <= 0
        S = IBMatlab('action','SELL','symbol',tickerS,'quantity',N,'type','MKT');
    else
        S = IBMatlab('action','SELL','symbol',tickerS,'quantity',position+N,'type','MKT');
    end
end

