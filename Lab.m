load("COVIDbyCounty.mat")

y = CNTY_CENSUS(:, divisions == 9);
sortrows(