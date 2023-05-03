function [signal] = kdj(bar_data, n, m1)
% Inputs:
%   - bar_data: 4-D array of bar data (open, high, low, close)
%   - n: look-back period for calculating K line
%   - m1: smoothing period for calculating D line
%   - m2: smoothing period for calculating J line
% Outputs:
%   - K: array of K line values
%   - D: array of D line values
%   - J: array of J line values
%   - signal: array of trading signals (0 = no signal, 1 = buy, -1 = sell)

% Calculate RSV values
highest_high = max(bar_data(:, 2), [], 2);
lowest_low = min(bar_data(:, 3), [], 2);
RSV = (bar_data(:, 4) - lowest_low) ./ (highest_high - lowest_low) * 100;

% Calculate K line
K = sma(RSV, n, 1);

% Calculate D line
D = sma(K, m1, 1);

% Calculate J line
J = 3 * K - 2 * D;

% Generate trading signals
signal = zeros(size(J));
signal(K < 20 & D < 20) = 1; % buy signal
signal(K > 80 & D > 80) = -1; % sell signal
end

function out = sma(x, n, dim)
% Simple moving average function
persistent weights
if isempty(weights) || length(weights) ~= n
    weights = ones(n, 1) / n;
end
out = convn(x, weights, 'same');
if dim == 1
    out(1:n-1,:) = NaN;
else
    out(:,1:n-1) = NaN;
end
end


