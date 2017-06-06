l1 = [1.8 0.3 0.06 1.7];
l2 = [78.3 74 73.1 75.5];
l3 = [99.9 99.9 13.9 12.6];

close all;

data = [l1;l2;l3];
data_plot = data;
data_plot(:,1) = data(:,2); % rotation w/o
data_plot(:,2) = data(:,3); % rotation w
data_plot(:,3) = data(:,1); % average w/o
data_plot(:,4) = data(:,4); % average w

figure;
b = bar(data_plot);
b(1).FaceColor = [0.0 0.0 1.0];
b(2).FaceColor = [0.6 0.6 1.0];
b(3).FaceColor = [1.0 0.0 0.0];
b(4).FaceColor = [1.0 0.6 0.6];

legend('Rotation w/o cache',  'Rotation with cache', 'Average w/o cache', 'Average with cache');
set(gca,'XTickLabel',{'CPU cache level 1' 'Level 2' 'Level 3'});