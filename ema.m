function [Y] = ema(X, m)
    Y = smoothing_function(moving_avg(X, m), m);
end