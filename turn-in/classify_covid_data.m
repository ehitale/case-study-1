load ("../COVIDbyCounty.mat")
load ("cluster_covid_data.mat")

% testingCNTY_COVID = CNTY_COVID(random_index == 0, :);

pairDist = zeros(45, 9);
sPD = zeros(45, 9);
sPDI = zeros(45, 9);

actualTrainingDivisions = CNTY_CENSUS.DIVISION(labeledCNTY_COVID(:,157)==1);
actualTestingDivisions = CNTY_CENSUS.DIVISION(labeledCNTY_COVID(:,157)==0);
trainingCNTY_CENSUS = CNTY_CENSUS(random_index==1, :);

divisionNames = unique(sortrows(CNTY_CENSUS, "DIVISION").DIVNAME, "stable");
divisionMode = zeros(9, 1);
clusterLabels = strings(9, 1);

validModes = [1, 2, 3, 4, 5, 6, 7, 8, 9];

for i = 1:9
    clusterDivisions = trainingCNTY_CENSUS.DIVISION(k_idx == i);
    divisionMode(i) = mode(clusterDivisions);

    for j = 1:9
        if i ~= j
            while divisionMode(j) == divisionMode(i)
                clusterDivisions = clusterDivisions(clusterDivisions ~= divisionMode(i));
                divisionMode(i) = mode(clusterDivisions); %still bugs, but made lots of progress.
            end
        end
    end
end

[memberArray, member_index] = ismember(validModes, divisionMode);
divisionMode(isnan(divisionMode)) = validModes(member_index == 0);

for i = 1:9
    clusterLabels(i) = divisionNames(divisionMode(i));
end

for i = 1:size(testingCNTY_COVID, 1) % 1:45
    % figure; 
    testCounty = testingCNTY_COVID(i, :);

    for j = 1:size(C, 1) % 1:9
        testCombo = cat(1, testCounty, C(j, :)); % some example county on top of a centroid ('s case trajectory)
        pairDist(i, j) = pdist(testCombo); % finds the euclidean distance between the example county and the centoid.

        [sPD(i, :), sPDI(i, :)] = sort(pairDist(i, :)); % sorts the euclidean distances and returns them sorted by ascending and their respective indices.
    end 

end
% in this case, cluster 1 is division 2, cluster 2 is division 1, cluster 3 is division 7, so on and so forth.
% figure(1);
% nexttile;
% 
% plot(1:0.01:10);

% for i = 1:size(testingCNTY_COVID, 1) % 1:45
%     fprintf("%d is the closest cluster for county %d\n", sPDI(i, 1), i)
%     % fprintf("", something that returns the actual division of each case trajecory)
% 
%     % if the two are the same, yay! else, nay!
% end

% alpha = [1, 2, 3];
% beta = [7, 2, 3];
% alphabeta = cat(1, alpha, beta);
% pdist(alphabeta); % this will return '6', because the euclidean distance
% between alpha and beta is 6.
