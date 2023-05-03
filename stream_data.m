function stream_data(tickers)
    
    for i = 1:length(tickers)
        disp(tickers(i));
        reqId = IBMatlab('action','realtime', 'symbol',tickers(i),'QuotesNumber',inf,'QuotesBufferSize',200,'useRTH',1);
    end

end


reqId = IBMatlab('action','realtime', 'symbol','DIS','QuotesNumber',inf,'QuotesBufferSize',200,'useRTH',1);