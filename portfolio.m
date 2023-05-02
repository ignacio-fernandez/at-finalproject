
function P = portfolio()   
    portfolioData = IBMatlab('action','portfolio');
    tickers = transpose({portfolioData.localSymbol});
    pos = transpose({portfolioData.position});
    avgPx = transpose({portfolioData.averageCost});
    MV = num2cell(cell2mat(avgPx).*cell2mat(pos));
    realizedPnL = transpose({portfolioData.realizedPnL});
    
    %closePx = zeros(length(tickers),1);
    %idx = 1;
    %for t=tickers
        %bar = IBMatlab('action','realtime', 'symbol',t,'QuotesNumber',1);
        %closePx(idx) = bar.close;
    %end
    closePx = ((2*rand(length(tickers),1))-1)+cell2mat(avgPx);

    unrealizedPnL = num2cell((closePx-cell2mat(avgPx)).*cell2mat(pos));

    P = [tickers,pos,avgPx,MV,unrealizedPnL,realizedPnL];
end