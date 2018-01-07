%% Testing the filter function.

line = [12, 32, 23, 9, 12, 49, 95, 95];

weights = [-12, 0, 140, 256, 140, 0, -12];

interpFilter(line, weights)
true = [10, 12, 22, 32, 29, 23, 15, 9, 8, 12, 28, 49, 74, 95, 97, 95];
