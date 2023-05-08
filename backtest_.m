function [out] = backtest_(symbol, dollar, params)
    
    data1 = IBMatlab('action','history', 'symbol',symbol,'barSize','5 secs','EndDateTime','20230425 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data2 = IBMatlab('action','history', 'symbol',symbol,'barSize','5 secs','EndDateTime','20230426 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data3 = IBMatlab('action','history', 'symbol',symbol,'barSize','5 secs','EndDateTime','20230427 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data4 = IBMatlab('action','history', 'symbol',symbol,'barSize','5 secs','EndDateTime','20230428 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    data5 = IBMatlab('action','history', 'symbol',symbol,'barSize','5 secs','EndDateTime','20230429 00:00:00','useRTH',1,'DurationValue',1, 'DurationUnits','D');
    
    pnl1 = get_pnl(data1, symbol, dollar, params);
    pnl2 = get_pnl(data2, symbol, dollar, params) + pnl1(end);
    pnl3 = get_pnl(data3, symbol, dollar, params) + pnl2(end);
    pnl4 = get_pnl(data4, symbol, dollar, params) + pnl3(end);
    pnl5 = get_pnl(data5, symbol, dollar, params) + pnl4(end);
    
    out = [pnl1; pnl2; pnl3; pnl4; pnl5];

end


function pnl = get_pnl(data, symbol, dollar, params)
    bar = struct('symbol', symbol, 'data', data);
    
    m = 50;
    
    idx = 1;
    order = zeros(length(bar.data.close),4);
    pnl = zeros(length(bar.data.close),1);
    for i = 1:length(bar.data.close)-m
        temp_bar = bar_window(i, m, symbol, data);
        [pos, close] = exe_test(temp_bar, dollar, params);
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