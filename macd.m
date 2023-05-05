function [S] = macd(X, slow, macd_window, fast)
    slow_line = ema(X, slow);
    fast_line = ema(X, fast);
    macd_line = fast_line(end-macd_window:end) - slow_line(end-macd_window:end);
    signal_line = ema(macd_line, macd_window);
    
    if (macd_line(end-1) < signal_line(end-1)) && (macd_line(end) > signal_line(end))
        S = 1; % BUY
    elseif (macd_line(end-1) > signal_line(end-1)) && (macd_line(end) < signal_line(end))
        S = -1; % SELL
    else
        S = 0;
    end
end