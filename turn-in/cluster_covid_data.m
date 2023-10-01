load ("../COVIDbyCounty.mat")
save ("cluster_covid_data.mat")

k = 9; % for 9 divisions
[idx, C] = kmeans(CNTY_COVID, k, "Replicates", 5); % this finds the kmeans  CNTY_COVID. I needed to transpose CNTY_COVID because the variables in CNTY_COVID are rows, whereas kmeans considers columns to be variables. Replication makes the kmeans look a whole lot better. 

for i = 1:9
    caseTrajectories = CNTY_COVID(idx == i, :)'; % uses logical indexing on CNTY_COVID to find the divisions.
    
    figure;
    tiledlayout(2, 1)

    nexttile;
    plot(C(i, :));
    title(['Centroid ', num2str(i)]);
    xlabel("week");
    ylabel("cases per 100k");

    nexttile;
    plot(caseTrajectories);
    title(['Cluster ', num2str(i)]);
    xlabel("week");
    ylabel("cases per 100k");
end



