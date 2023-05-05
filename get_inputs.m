function [tickers, dollars] = get_inputs(T)
    tickers = transpose(string(cell2mat(T(1:end, 1))));
    dollars = transpose(cell2mat(T(1:end, 2)));
end