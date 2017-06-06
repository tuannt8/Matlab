over_head = [12.4 12.4 12.6 12.7];
pal_time = [68 42 35 32 ];

normal = 76*ones(size(over_head));

color_over_head = 90;

%% 

close all;

h = figure;
set(h, 'Position', [300 300 300 200])

% subplot(2,1,2);
hold on;

h = area([over_head; pal_time]');
ld = legend([h(2), h(1)], {'Parallel edge removal', 'Over head to get color'});


plot(normal, 'k-o', 'LineWidth', 1.3);
text(2, 90, 'Serial edge removal');


% subplot(2,1,1);
plot(pal_time + color_over_head, 'b*-');
text(2, 148, 'Parallel w/o cached color');

xlabel('Number of threads');
ylabel('Computation time in 1 iteration [ms]');

set(gca, 'XTick', [1 2 3 4]);

ylim([0 160]);
hold off;
