function test(handles)
    [tickers, dollars] = get_inputs(handles.A);
    params = get_params(handles);
    for i=1:length(tickers)
        t = tickers(i);
        d = dollars(i);
        out = backtest_(t, d, params);
        if i == 1
            graphs = out;
        else
            graphs = graphs + out;
        end
    end
    plot(graphs);
end