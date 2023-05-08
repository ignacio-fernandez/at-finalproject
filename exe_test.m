function [pos, close] = exe_test(bars, dollars, params, position)
for i = 1:length(bars)
    bar = bars(i);
    dollar = dollars(i);
    % calculate signals and combine to a 2d-vector, which is signals
    symbol = bar.symbol;
    close = bar.data.close;
    macd_vec = macd(close, params.slow, params.macd, params.fast);
    rsi_vec = rsi(close, 6, params.lower, params.upper);
    kdj_vec = kdj(bar.data);
    signals = vertcat(macd_vec, rsi_vec, kdj_vec);
    disp("Signals:");
    disp(signals);
    [pos, close] = execute_signals_test(dollar, symbol,signals, close, position);
    %disp(orderId);
end
end