function [S] = rsi(X, h, L, U)
    disp(L);
    R = diff(X);

    UUt = R.*(R > 0);
    DDt = -R.*(-R > 0);

    RS = (sum(UUt(end-h:end)) / h) / (sum(DDt(end-h:end)) / h);
    RSI = 100*(1 - 1/(1+RS));

    RS_lag = (sum(UUt(end-h-1:end-1)) / h) / (sum(DDt(end-h-1:end-1)) / h);
    RSI_lag = 100*(1 - 1/(1+RS_lag));

    if RSI_lag < U && RSI > U
        S = -1;
    elseif RSI_lag > L && RSI < L
        S = 1;
    else
        S = 0;
    end

end