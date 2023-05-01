function close_position()
    portfolioData = IBMatlab('action','portfolio', 'type','positions');
    tickersCO = {portfolioData.localSymbol};
    for tCOs = tickersCO
        tCO = string(tCOs);
        pos = Position(tCO);
        if pos < 0
            IBMatlab('action','BUY','symbol',tCO,'quantity',-pos,'type','MKT');
        elseif pos > 0
            IBMatlab('action','SELL','symbol',tCO,'quantity',pos,'type','MKT');
        end
    end
end

%test