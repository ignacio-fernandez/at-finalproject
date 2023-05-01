function [S] = macd(X, slow, macd_window, fast)
    macd_line = ema(X, fast) - ema(X, slow);
    signal_line = ema(macd_line, macd_window);

    if (macd_line(end-1) < signal_line(end-1)) && (macd_line(end) > signal_line(end))
        S = 1; % BUY
    elseif (macd_line(end-1) > signal_line(end-1)) && (macd_line(end) < signal_line(end))
        S = -1; % SELL
    else
        S = 0;
    end
end