
function P = portfolio(bars)   
    portfolioData = IBMatlab('action','portfolio');
    if ~isempty(portfolioData)
        tickers = transpose({portfolioData.localSymbol});
        pos = transpose({portfolioData.position});
        avgPx = transpose({portfolioData.averageCost});
        MV = num2cell(cell2mat(avgPx).*cell2mat(pos));
        realizedPnL = transpose({portfolioData.realizedPnL});
        
        closePx = zeros(length(tickers),1);
        for i=1:length(bars)
            ticker_idx = find(string(tickers)==bars(i).symbol);
            if ~isempty(ticker_idx)   
                closePx(ticker_idx) = bars(i).data.close(length(bars(i).data.close));
            end
        end
    
        unrealizedPnL = num2cell((closePx-cell2mat(avgPx)).*cell2mat(pos));
    
        P = [tickers,pos,avgPx,MV,unrealizedPnL,realizedPnL];
    else
        P = [];
    end

end