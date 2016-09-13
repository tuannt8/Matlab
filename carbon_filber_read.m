%%
addpath('../Large_data/Filber');

fname = 'LargeFOV-x0.4-stitching_LFOV-50kV-VE_recon_6-x-stitched-crop.txm.tif';
info = imfinfo(fname);
num_images = numel(info);

%%
k1 = 1500;
k2 = 3500;
average = im2double(imread(fname, k1, 'Info', info));
for k = k1+1:k2
    A = im2double(imread(fname, k, 'Info', info));
    average = average + A;
    disp(['read ' num2str(k)]);
end

average = average/(k2 - k1 + 1);
average(average < 0.43) = 0.43;
average = imadjust(average);
%%
imagesc(average); colormap gray; axis image;