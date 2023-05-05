function start(handles)
    i = 2;
    windowSize = 20;
    arraySize = 2^16;
    X = zeros(arraySize, 1);
    
    %tickers = %get user input here
    %dollar = %get user input here, dollar amount of each trade
    dollar = 20000;
    tickers = ["DIS", "TSLA", "NVDA", "AAPL", "TXN"];
    for t = tickers
        IBMatlab('action','realtime', 'symbol',t,'QuotesNumber',inf,'QuotesBufferSize',50,'useRTH',1);
    end
    
    while (1)
        % See if there's a more efficient way to create bars array
        bars = IBMatlab('action','realtime', 'symbol',tickers(1),'QuotesNumber',-1);
        if length(tickers) > 1    
            for j = 2:length(tickers)
                bars(j) = IBMatlab('action','realtime', 'symbol',tickers(j),'QuotesNumber',-1);
            end
        end
        if get(handles.stop_btn, 'userdata') % stop condition
            cla(handles.pnl_graph);
            break;
        end

        if get(handles.pause_btn, 'userdata')
            % do nothing
        else
            exe(bars, dollar);
        end
        
        p = portfolio(bars);
        curr_pnl = total_pnl(p);
        set(handles.portfolio_table, 'Data', p);
        set(handles.total_pnl_text, 'String', curr_pnl);
        set(handles.orders_table, 'Data', orders());
        X(i) = curr_pnl;

        if i <= windowSize
            plot(handles.pnl_graph, 0:i-1, X(1:i));
        else
            plot(handles.pnl_graph, i-windowSize:i, X(i-windowSize:i));
        end
        
        i = i+1;

        pause(5);
    end
end