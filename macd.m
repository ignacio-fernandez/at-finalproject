function [S, macd_val, avg_val] = macd(X, slow, macd_window, fast)
    macd_line = ema(X, fast) - ema(X, slow);
    signal_line = ema(macd_line, macd_window);
    macd_val = macd_line(end);
    avg_val = signal_line(end);

    if (macd_line(end-1) < signal_line(end-1)) && (macd_line(end) > signal_line(end))
        S = 1; % BUY
    elseif (macd_line(end-1) > signal_line(end-1)) && (macd_line(end) < signal_line(end))
        S = -1; % SELL
    else
        S = 0;
    end
end