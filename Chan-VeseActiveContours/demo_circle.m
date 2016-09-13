%% Read image
close all;
clear;
    
I = imread('data/cir_g.png');
I = double(I(:,:,1))/255;

% H = fspecial('disk', 3);
% I = imfilter(I,H,'replicate');
% I = imnoise(I,'gaussian',0.02,0.02);

%% 

seg = chenvese(I, 'large', 400,0.04);