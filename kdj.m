function [K, D, J] = kdj(high, low, close, window, k_window, d_window)
% Computes the KDJ indicator for a given set of price data
% Input:
%   high: vector of high prices
%   low: vector of low prices
%   close: vector of closing prices
%   window: look-back period for calculating the highest high and lowest low
%   k_window: look-back period for calculating the %K line
%   d_window: look-back period for calculating the %D line
% Output:
%   K: %K line
%   D: %D line
%   J: %J line

% Calculate highest high and lowest low over the past 'window' periods
highest_high = highest(high, window);
lowest_low = lowest(low, window);

% Calculate the %K line
K = 100 * (close - lowest_low) ./ (highest_high - lowest_low);

% Calculate the %D line
D = sma(K, d_window);

% Calculate the %J line
J = 3 * K - 2 * D;

end
