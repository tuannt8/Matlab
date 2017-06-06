center = [50, 50; 150, 100];
radius = [30, 40];

move = [-3; 3];


%% Movie
img = zeros(200,200);
writerObj = VideoWriter('out.mp4', 'MPEG-4'); % Name it.
writerObj.FrameRate = 2; % How many frames per second.
open(writerObj); 

for m=1:20

center(:,1) = center(:,1) - move;
    
    
for i = 1:200
    for j = 1:200
        dist = 1;
        inside = 1;
        for k = 1:length(radius)
            dd = sqrt((i-center(k,1))^2 + (j-center(k,2))^2);
            dist = dist* (dd - radius(k));
            if dd < radius(k)
                inside = -1;
            end
        end
        img(i,j) = (abs(dist)^( 1./length(radius)))*inside;
    end
end

img(img<0) = -img(img<0)/min(img(:));
img(img>0) = img(img>0)/max(img(:));

clf;
[X,Y] = meshgrid(1:200,1:200);

set( gca , 'Visible' , 'off' );
set(gca,'position',[0 0 1 1],'units','normalized')

% imagesc(img);colormap parula;
% surf(X,Y,img);
hold on;
contour(X,Y,img,[0,0], 'r-', 'LineWidth',2);

set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(gca,'YDir','reverse');
axis square;
hold off;

ax = gca;
ax.Units = 'pixels';
pos = ax.Position;
ii = (pos(3)-pos(4))/2;
rect = [ii, 0, pos(3)-2*ii, pos(4)];


frame = getframe(gcf, rect);
writeVideo(writerObj, frame);

pause(0.2);
end
close(writerObj);
%% Write image
for m = 1:20
    center(:,1) = center(:,1) - move;
    
    
for i = 1:200
    for j = 1:200
        dist = 1;
        inside = 1;
        for k = 1:length(radius)
            dd = sqrt((i-center(k,1))^2 + (j-center(k,2))^2);
            dist = dist* (dd - radius(k));
            if dd < radius(k)
                inside = -1;
            end
        end
        img(i,j) = (abs(dist)^( 1./length(radius)))*inside;
    end
end

img(img<0) = 0;
img(img>0) = 1;

imwrite(img, ['im_' num2str(m) '.png']);
end
