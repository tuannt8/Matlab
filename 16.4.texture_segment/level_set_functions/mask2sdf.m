function phi=mask2sdf(mask)
% Mask to signed distance field

phi = zeros(size(mask));
for p=1:size(mask,3)
    phi(:,:,p) = bwdist(mask(:,:,p))-bwdist(~mask(:,:,p))+mask(:,:,p)-0.5;
end