function [S] = Signal(bar, h, L, U)
    
    Close = bar.close;
    
    End =length(Close);
    

    UU2 = 0;
    DD2 = 0;
    for i1 = End-h:End
        u2 = Close(i1) - Close(i1-1);
        d2 = Close(i1-1) - Close(i1);
        if u2 > 0
            UU2 = UU2 + u2;
        end
        if d2 > 0
            DD2 = DD2 + d2;
        end
    end
    RS2 = ((1/h)*UU2)/((1/h)*DD2);
    RSI2 = 100*(1-(1/(1+RS2)));
    

    UU1 = 0;
    DD1 = 0;
    for i2 = End-h-1:End-1
        u1 = Close(i2) - Close(i2-1);
        d1 = Close(i2-1) - Close(i2);
        if u1 > 0
            UU1 = UU1 + u1;
        end
        if d1 > 0
            DD1 = DD1 + d1;
        end
    end
    RS1= ((1/h)*UU1)/((1/h)*DD1);
    RSI1 = 100*(1-(1/(1+RS1)));

    % Check for buy and sell signals
    s = 0;
    if (RSI1 < L) && (RSI2 > L) 
        s = 1;
    elseif (RSI1 > U) && (RSI2 < U) 
        s = -1;
    end
    
    [S] = s;


end