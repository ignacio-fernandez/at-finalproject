function PL = total_pnl(portfolio)
    unrealizedPnL = cell2mat(portfolio(:,5));
    realizedPnL = cell2mat(portfolio(:,6));
    PL = sum(unrealizedPnL + realizedPnL);
end
