function exe(bars, dollar)
for i = 1:length(bars)
    bar = bars(i);
    % calculate signals and combine to a 2d-vector, which is signals
    symbol = bar.symbol;
    close = bar.data.close;
    macd_vec = macd(X=close, slow=26, macd_window=9, fast=12);
    rsi_vec = rsi(X=close, h=6, L=20, U=80);
    kdj_vec = kdj(bar_data=bar, n=9, m1=3);
    signals = vertcat(macd_vec, rsi_vec, kdj_vec);
    orderId = execute_signals(dollar, symbol,signals, close);
    disp(orderId);

end