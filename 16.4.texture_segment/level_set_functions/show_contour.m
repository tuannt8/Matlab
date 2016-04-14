function show_contour(I,phi,lw)
% Visualization of the zero level set
% Input: background image I, level set function phi, optional line width lw
% Author: vand@dtu.dk


if nargin < 3
    lw = 2-(size(phi,3)>2);
end

% should handle all our test cases
cla
if size(I,3)==1
    imagesc(I), colormap gray
elseif size(I,3)==3
    image(I)
else
    imagesc(mean(I,3)), colormap gray
end

axis image, hold on
col = 'gmcbrykw';
for i=1:size(phi,3)
    contour(phi(:,:,i),[0 0],col(mod(i-1,8)+1),'LineWidth',lw)
end

end
