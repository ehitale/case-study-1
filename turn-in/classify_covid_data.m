load ("../COVIDbyCounty.mat")
load ("cluster_covid_data.mat")

for idx_1 = 1:9
    figure; 
    x = CNTY_COVID(k_idx == idx_1, :)';
    y = pdist(x);
    z = movmean(y, 80);
    plot(z);
end
