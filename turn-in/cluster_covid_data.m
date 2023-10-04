load ("../COVIDbyCounty.mat")
k = 9; % for 9 divisions

random = randperm(225);
random_index = zeros(225, 1);

for a = 1:length(random_index)
    if random(a) <= 180
        random_index(a) = 1;
    end
end

labeledCNTY_COVID = cat(2, CNTY_COVID, random_index);
trainingCNTY_COVID = CNTY_COVID(random_index == 1, :);
testingCNTY_COVID = CNTY_COVID(random_index == 0, :);


[k_idx, C] = kmeans(trainingCNTY_COVID, k, "Replicates", 5); % this finds the kmeans  CNTY_COVID. Replication makes the kmeans look a whole lot better. 

for i = 1:9
    caseTrajectories = trainingCNTY_COVID(k_idx == i, :)'; % uses logical indexing on CNTY_COVID to find the clusters.

    figure;
    tiledlayout(3, 1)

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
save ("cluster_covid_data.mat")