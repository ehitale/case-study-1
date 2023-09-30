load ("../COVIDbyCounty.mat")

k = 9;
[idx, C] = kmeans(CNTY_COVID', k);


for i = 1:9
    figure;
    caseTrajectories = CNTY_COVID(idx == i, :)';
    plot(caseTrajectories);
    xlabel("week");
    ylabel("cases per 100k");
end



