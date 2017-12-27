%% Testing the filter function.
% Did not get any good result

line = [10, 12, 20, 30, 35, 15, 19, 11, 11, 19, 26, 45, 80, 90, 92, 90];
filter1 = [-29, 0, 88, 38, 88, 0, -29];

result = imfilter(line, filter1);
decimated_hor = downsample(result,2)


true = [12, 32, 23, 9, 12, 49, 95, 95];
