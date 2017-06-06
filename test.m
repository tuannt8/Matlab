I = imread('test1.JPG');
I = imresize(I, 0.08);
I = I(:,:,1);

%%
close all;
[~, threshold] = edge(I, 'sobel');
fudgeFactor = 0.7;
BWs = edge(I,'sobel', threshold * fudgeFactor);
figure, image(~BWs*256), title('binary gradient mask');

ss = size(BWs);
set(gca,'xtick',[0:1:ss(1)]);
set(gca,'ytick',[0:1:ss(2)]);
grid on;
colormap gray
% %%
% close all;
% fun = @(block_struct) ...
%    std2(block_struct.data) * ones(size(block_struct.data));
% I2 = blockproc(I,[32 32],fun);
% figure;
% imshow(I);
% figure;
% 
% % I2 = imresize(I2, 0.1);
% imshow(I2,[]);

%%
close all;
I = imread('mun.png');
figure;
image(I); colormap gray; axis image;
ss = size(I);
set(gca,'xtick',0:10:ss(2));
set(gca,'ytick',0:10:ss(1));
grid on;
grid minor;

xlabel = cell(ss(2),1);
for i = 1:ss(2)
    xlabel(i) = {num2str(i*0.4)};
end
ylabel = cell(ss(1),1);
for i = 1:ss(1)
    ylabel(i) = {num2str(i*0.4)};
end
set(gca,'xticklabel',cellstr(xlabel));
set(gca,'yticklabel',cellstr(ylabel));

% grid minor;
% hold;
% i = 1;
% while i < ss(1)
%     plot([0,ss(2)], [i i], 'b');
%     i = i+10;
% end
% 
% i = 1;
% while i < ss(2)
%     plot([i i ], [0,ss(1)], 'b');
%     i = i+10;
% end