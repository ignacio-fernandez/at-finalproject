function exe(bars, dollars)
for i = 1:length(bars)
    bar = bars(i);
    disp(bar);
    dollar = dollars(i);
    % calculate signals and combine to a 2d-vector, which is signals
    symbol = bar.symbol;
    close = bar.data.close;
    macd_vec = macd(close, 26, 9, 12);
    rsi_vec = rsi(close, 6, 20, 80);
    kdj_vec = kdj(bar.data, 9, 3);
    signals = vertcat(macd_vec, rsi_vec, kdj_vec);
    orderId = execute_signals(dollar, symbol,signals, close);
    disp(orderId);

end