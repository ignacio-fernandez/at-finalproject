function [P] = get_position(tickerP)
    portfolioData = IBMatlab('action','portfolio', 'type','positions');
    symbols = {portfolioData.localSymbol};
    idx = strcmpi(tickerP, symbols);
    if sum(idx) ~= 0
        [P] = portfolioData(idx).position;
    else
        [P] = 0;
    end
end