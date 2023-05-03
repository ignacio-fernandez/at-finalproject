function [buy, sell] = execute_signals(X, slow, macd_window, fast, rsi_period, kdj_period, L, U)
    % Compute the MACD indicator
    macd_line = ema(X, fast) - ema(X, slow);
    signal_line = ema(macd_line, macd_window);
    
    % Compute the RSI indicator
    RSI = rsi(X, rsi_period, L, U);
    
    % Compute the KDJ indicator
    [K, D] = kdj(X, kdj_period);
    
    % Determine buy and sell signals based on the indicators
    if (macd_line(end-1) < signal_line(end-1)) && (macd_line(end) > signal_line(end)) ...
            && (RSI == 1 || K == 1 || D == 1)
        buy = true;
    else
        buy = false;
    end
    
    if (macd_line(end-1) > signal_line(end-1)) && (macd_line(end) < signal_line(end)) ...
            && (RSI == -1 || K == -1 || D == -1)
        sell = true;
    else
        sell = false;
    end
end
