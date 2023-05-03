function stream_data(tickers)
    
    for i = 1:length(tickers)
        reqId = IBMatlab('action','realtime', 'symbol',string(tickers(i)),'QuotesNumber',inf,'QuotesBufferSize',60,'useRTH',1);
    end

end