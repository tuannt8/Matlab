function show_multiphase_phi(phi)
% visualization of multiple level set functions
% Author: vand@dtu.dk


I = size(phi,3);
p = [1 2 2 2 3 3 3 3 3];
q = [1 1 2 2 2 2 3 3 3];
if I<10
    p = p(I);
    q = q(I);
else
    p = ceil(sqrt(I));
    q = p;
end    

ax = zeros(I,1); 
for i=1:I
    ax(i) = subplot(p,q,i);
    cla, imagesc(phi(:,:,i),[min(phi(:)),max(phi(:))]), axis image, hold on
    colormap(blue_white_red(0,256,[min(phi(:)),max(phi(:))]))
    contour(phi(:,:,i),[0 0],'g'), title(['phi ',num2str(i)])
end
linkaxes(ax)
end


