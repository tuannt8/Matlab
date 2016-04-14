function show_phi(phi)
% Visualization of the level set function phi
% Author: vand@dtu.dk


imagesc(phi,[min(phi(:)),max(phi(:))]), axis image, hold on
colormap(blue_white_red(0,256,[min(phi(:)),max(phi(:))]))
contour(phi,[0 0],'g','LineWidth',2)

end

