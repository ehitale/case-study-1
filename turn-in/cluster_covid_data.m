load ("../COVIDbyCounty.mat")

[idx, C] = kmeans(CNTY_COVID, 9);
plot(C)