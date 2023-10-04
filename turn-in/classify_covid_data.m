load ("../COVIDbyCounty.mat")
load ("cluster_covid_data.mat")

pairDist = zeros(45, k);
sPD = zeros(45, k);
sPDI = zeros(45, k);

actualTrainingDivisions = CNTY_CENSUS.DIVISION(random_index==1);
actualTestingDivisions = CNTY_CENSUS.DIVISION(random_index==0);
trainingCNTY_CENSUS = CNTY_CENSUS(random_index==1, :);
testingCNTY_CENSUS = CNTY_CENSUS(random_index==0, :);

divisionNames = unique(sortrows(CNTY_CENSUS, "DIVISION").DIVNAME, "stable");
divisionMode = zeros(50, 1);
clusterLabels = strings(50, 1);

% I have the divisions of the training data, from 1 to 9. I have the
% cluster assignments for the training data, from 1 to 50. I need to assign
% meanings to those 50 cluster assignments, and then go from those meaning
% to divisions. 

for i = 1:50
    % fprintf("Cluster %d\n", i);
    divisionMode(i) = mode(trainingCNTY_CENSUS.DIVISION(k_idx == i));
    clusterLabels(i) = divisionNames(divisionMode(i));
end % this code gives me the division each cluster appears to match best. e.g. cluster 18 is full of counties from Florida, i.e. the South Atlantic division so it has the South Atlantic Division name. 

for i = 1:size(testingCNTY_COVID, 1) % 1:45
    testCounty = testingCNTY_COVID(i, :);

    for j = 1:size(C, 1) % 1:50
        testCombo = cat(1, testCounty, C(j, :)); % some example county on top of a centroid ('s case trajectory)
        pairDist(i, j) = pdist(testCombo); % finds the euclidean distance between the example county and the centoid. maybe change to norm(x1 -x2)?

        [sPD(i, :), sPDI(i, :)] = sort(pairDist(i, :)); % sorts the euclidean distances and returns them sorted by ascending and their respective indices.
    end 

end

%comparision time!!! I need to associate a group of clusters with their
%respective divisions, remember that more than one cluster can have the
%same division. Consider group.
score = 0;

for i = 1:45
    assumedDivision = divisionMode(sPDI(i, 1)); % cluster 47 is associated with division 8, so the assumed divison is 8. 
    if assumedDivision == (actualTestingDivisions(i))
        score = score + 1;
    end
end

percentage = (score / 45) * 100; 
