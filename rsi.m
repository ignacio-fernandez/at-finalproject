function [S] = rsi(X, h, L, U)
    R = diff(X);

    UUt = R.*(R > 0);
    DDt = -R.*(-R > 0);

    RS = (sum(UUt(end-h:end)) / h) / (sum(DDt(end-h:end)) / h);
    RSI = 100*(1 - 1/(1+RS));

    if RSI > U
        S = -1;
    elseif RSI < L
        S = 1;
    else
        S = 0;
    end

end