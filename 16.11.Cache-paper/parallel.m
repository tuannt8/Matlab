over_head = [12.2 12.4 14.6 12.7];
pal_time = [66.3 36 27.3 24.5 ];

normal = 69*ones(size(over_head));

color_over_head = 451;

%% 

close all;

h = figure;
set(h, 'Position', [300 300 300 200])


hold on;

% ylim([0 510]);
% breakyaxis([85 455]);





h = area([over_head; pal_time]');
ld = legend([h(2), h(1)], {'Parallel smooth', 'Over head for coloring with mesh-cache'});


plot(normal, 'k-o', 'LineWidth', 1.3);
text(2, 77, 'Serial smooth');

% 
% plot(over_head + pal_time + 430, 'b*-');
% text(2, 485, 'Parallel smooth w/o cached color');

xlabel('Number of threads');
ylabel('Computation time in 1 iteration [ms]');

set(gca, 'XTick', [1 2 3 4]);


% breakyaxis([85 455]);



hold off;

