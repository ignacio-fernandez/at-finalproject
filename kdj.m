function signal = kdj(bar)
n = 9;
m1 = 3;
m2 = 3;

K = 50;
D = 50;

i = length(bar.close);
if i >= n
    HH = max(bar.high(i-n+1:i));
    LL = min(bar.low(i-n+1:i));
    RSV = (bar.close(i) - LL) / (HH - LL) * 100;
else
    RSV = 0;
end

K = (m1 * K + RSV) / (m1 + 1);
D = (m2 * D + K) / (m2 + 1);
J = 3 * K - 2 * D;

if K < 40 && D < 40 || K < 40 && J < 40 || D < 40 && J < 40
    signal = 1;
elseif K > 60 && D > 60 || K > 60 && J > 60 || D > 60 && J > 60
    signal = -1;
else
    signal = 0;
end
end
