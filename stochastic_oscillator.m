function [k, d] = stochastic_oscillator(highs, lows, closes, window_size, smooth_factor)
% Inputs:
% highs: vector of high prices
% lows: vector of low prices
% closes: vector of closing prices
% window_size: size of the window for computing the %K and %D lines
% smooth_factor: smoothing factor for the %D line
% Outputs:
% k: vector of %K line values
% d: vector of %D line values

% Compute the highest high and lowest low within the window
high_window = highs(end-window_size+1:end);
low_window = lows(end-window_size+1:end);
highest_high = max(high_window);
lowest_low = min(low_window);

% Compute %K line
k = 100 * (closes(end) - lowest_low) / (highest_high - lowest_low);

% Smooth %K line with an exponential moving average
alpha = 2 / (smooth_factor + 1);
k_smoothed = alpha * k + (1 - alpha) * k(1);

% Compute %D line
d = smooth(k_smoothed, smooth_factor, 'exponential');
end
