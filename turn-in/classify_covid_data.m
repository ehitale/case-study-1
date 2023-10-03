load ("../COVIDbyCounty.mat")
load ("cluster_covid_data.mat")

% testingCNTY_COVID = CNTY_COVID(random_index == 0, :);

pairDist = zeros(45, 9);
sPD = zeros(45, 9);
sPDI = zeros(45, 9);

actualDivisions = strings(45, 1);

for i = 1:45 
    for j = 1:225
        if labeledCNTY_COVID(j, end) == 0 
            actualDivisions(i) = CNTY_CENSUS{j, 3}; % not quite working
        end
    end
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

for i = 1:size(testingCNTY_COVID, 1) % 1:45
    fprintf("%d is the closest cluster for county %d\n", sPDI(i, 1), i)
    % fprintf("", something that returns the actual division of each case trajecory)

    % if the two are the same, yay! else, nay!
end

% alpha = [1, 2, 3];
% beta = [7, 2, 3];
% alphabeta = cat(1, alpha, beta);
% pdist(alphabeta); % this will return '6', because the euclidean distance
% between alpha and beta is 6.
