function [bar2] = convert(bar, n)
    
    O=bar.open;
    H=bar.high;
    L=bar.low;
    C=bar.close;
    
    m = n/5;
    last = length(O);
    size = (last - mod(last,m))/m;

    O2 = zeros(1,size);
    H2 = zeros(1,size);
    L2 = zeros(1,size);
    C2 = zeros(1,size);

    ic = last;
    jc = size;
    while jc > 0
        O2(jc) = O(ic-m+1);
        H2(jc) = max(H(ic-m+1:ic));
        L2(jc) = min(L(ic-m+1:ic));
        C2(jc) = C(ic);

        ic = ic - m;
        jc = jc - 1;
    end

    [bar2] = struct('open',O2,'high',H2,'low',L2,'close',C2);
    
end