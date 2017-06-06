clear;
close all;

rotate = load('rotate.txt');
rotate_c = load('rotate_cache.txt');
average = load('average.txt');
average_c = load('average_cache.txt');

%%
s_rotate = cumsum(rotate);
s_rotate_c = cumsum(rotate_c);
s_average = cumsum(average);
s_average_c = cumsum(average_c);

%%
h = figure;
hold on;

plot(s_rotate, 'b-');
plot(s_rotate_c(1:25), 'b--');
plot(s_average, 'r-');
plot(s_average_c(1:25), 'r--');

legend('Rotation w/o cache', 'Rotation with cache', 'Averaging w/o cache', 'Averaging with cache');

xlabel('iteration');
ylabel('time [sec]');

hold off;
