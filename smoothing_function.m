function [Y] = smoothing_function(X, m)
    N = length(X);

    Y = zeros(N, 1);
    Y(1) = X(1);

    alpha = 2/(m+1);

    for i = 2:N
        Y(i) = alpha * X(i) + (1-alpha)*Y(i-1);
    end
end