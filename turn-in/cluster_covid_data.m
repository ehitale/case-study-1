load ("../COVIDbyCounty.mat")

k = 9; % for 9 divisions
[idx, C] = kmeans(CNTY_COVID, k); % this finds the kmeans of a transposed CNTY_COVID. I needed to transpose CNTY_COVID because the variables in CNTY_COVID are rows, whereas kmeans considers columns to be variables.

for i = 1:9
    caseTrajectories = CNTY_COVID(idx == i, :)'; % uses logical indexing on CNTY_COVID transposed to find the divisions.
    
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



