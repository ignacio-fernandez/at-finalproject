function [o] = orders()
    all_orders = IBMatlab('action','executions');
    if ~isempty(all_orders)
        tickers = transpose({all_orders.symbol});
        actn = transpose({all_orders.side});
        quantity = transpose({all_orders.shares});
        avgPx = transpose({all_orders.avgPrice});
        time = transpose({all_orders.time});
        [o] = [tickers, actn, quantity, avgPx, time];
    else
        [o] = [];
    end
end