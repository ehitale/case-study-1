for idx_1 = 1:9
    figure; 
    x = CNTY_COVID(idx == idx_1,:)';
    y = pdist(x);
    plot(y);
end