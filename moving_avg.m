function [Y] = moving_avg(X, m)
    T = length(X);
    Y = zeros(T-m+1, 1);
    for s = T:-1:m
        Y(s-m+1) = sum(X(s-m+1:s)) / m;
    end
end