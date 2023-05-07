function backtest()
    
    data1 = IBMatlab('action','history', 'symbol','TSLA','barSize','5 secs','EndDateTime','20230425 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data2 = IBMatlab('action','history', 'symbol','TSLA','barSize','5 secs','EndDateTime','20230426 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data3 = IBMatlab('action','history', 'symbol','TSLA','barSize','5 secs','EndDateTime','20230427 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data4 = IBMatlab('action','history', 'symbol','TSLA','barSize','5 secs','EndDateTime','20230428 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data5 = IBMatlab('action','history', 'symbol','TSLA','barSize','5 secs','EndDateTime','20230429 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    
    pnl1 = get_pnl(data1);
    pnl2 = get_pnl(data2) + pnl1(end);
    pnl3 = get_pnl(data3) + pnl2(end);
    pnl4 = get_pnl(data4) + pnl3(end);
    pnl5 = get_pnl(data5) + pnl4(end);
    
    plot([pnl1; pnl2; pnl3; pnl4; pnl5])

end


function pnl = get_pnl(data)
    bar = struct('symbol', 'TSLA', 'data', data);
    p = struct( ...
        'slow', 26, ...
        'fast', 12, ...
        'macd', 9, ...
        'upper', 70, ...
        'lower', 30);
    dollar = 10000;
    
    m = 50;
    
    idx = 1;
    order = zeros(length(bar.data.close),4);
    pnl = zeros(length(bar.data.close),1);
    for i = 1:length(bar.data.close)-m
        temp_bar = bar_window(i, m, 'TSLA', data);
        [pos, close] = exe_test(temp_bar, dollar, p);
        if ~isempty(pos)
            order(idx, 1) = pos;
            order(idx, 2) = close;
            idx = idx + 1;
        end
    
        order(1:idx,3) = temp_bar.data.close(end);
        order(1:idx,4) = (order(1:idx,3) - order(1:idx,2)).*order(1:idx,1);    
        pnl(i) = sum(order(1:idx,4));
    end
    pnl = pnl(1:end-m);
end

function [bar] = bar_window(start, m, symbol, data)
    data = struct( ...
        'open', data.open(start:start+m), ...
        'low', data.close(start:start+m), ...
        'high', data.high(start:start+m), ...
        'close', data.close(start:start+m));
    bar = struct('symbol', symbol, 'data', data);
end