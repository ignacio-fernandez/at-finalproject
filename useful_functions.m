

function CloseOut()
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

function [P] = Position(tickerP)
    portfolioData = IBMatlab('action','portfolio', 'type','positions');
    symbols = {portfolioData.localSymbol};
    idx = strcmpi(tickerP, symbols);
    if sum(idx) ~= 0
        [P] = portfolioData(idx).position;
    else
        [P] = 0;
    end
end

function [bar2] = Convert(bar1, n)
    
    O=bar1.open;
    H=bar1.high;
    L=bar1.low;
    C=bar1.close;
    
    m = n/5;
    last = length(O);
    size = (last - mod(last,m))/m;

    O2 = zeros(1,size);
    H2 = zeros(1,size);
    L2 = zeros(1,size);
    C2 = zeros(1,size);

    ic = last;
    jc = size;
    while jc > 0
        O2(jc) = O(ic-m+1);
        H2(jc) = max(H(ic-m+1:ic));
        L2(jc) = min(L(ic-m+1:ic));
        C2(jc) = C(ic);

        ic = ic - m;
        jc = jc - 1;
    end

    [bar2] = struct('open',O2,'high',H2,'low',L2,'close',C2);
    
end