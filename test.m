function test(handles)
    [tickers, dollars] = get_inputs(handles.A);
    params = get_params(handles);
    for i=1:length(tickers)
        t = tickers(i);
        d = dollars(i);
        out = backtest_(t, d, params);
        if i == 1
            graphs = zeros(length(out), 1);
            graphs(1:end,1) = out;
        else
            graphs(1:end,i) = out;
        end
    end
    plot(graphs);
end