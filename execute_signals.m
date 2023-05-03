function Execution(dollar, symbol,signals)



new_data = IBMatlab('action','query', 'symbol', symbol)
last = new_data.lastPrice;
bid1 = new_data.bidPrice;
ask1 = new_data.askPrice;

N = round(dollar / last, 0);

random_nums = randi(1, N);
normalized_nums = random_nums / sum(random_nums) * N;

orderId = IBMatlab('action', BuySell, 'symbol', symbol, 'quantity',
normalized_nums(i), 'type', 'MKT');

rand_time = rand() * 2 + 1;
pause(rand_time*0.5);

end