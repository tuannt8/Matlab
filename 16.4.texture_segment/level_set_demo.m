% Version similar to: "Dictionary Based Image Segmentation" by
% Anders Bjorhom Dahl and Vedrana Andersen Dahl,
% 19th Scandinavian Conference on Image Analysis (SCIA) 2015
% Author: vand@dtu.dk

clear, close all
addpath texture_functions level_set_functions auxiliary_functions

%% SETTINGS
% loading image and initialization settings
test_case = 2; % chose one of 12 test cases, see with show_test_cases
[input_image,center,radius,patch_size] = load_test_case(test_case);
% M used here is 3, 5, 9 or 15: larger works better for textured images

% dictionary settings
nToClust = 5000; % nr random patches for building the dictionary tree
branching_factor = 5; % branching factor for dictionary tree
number_layers = 4; % nr. layers in dictionary tree
    % branching_factor and number_layers relate to dictionary size
normalize = true; % normalization makes texture invariant to global intensity changes

% curve evolution settings
sigma = 1; % sigma for regularization using gaussian smoothing
nr_step = 100; % nr. evolution steps 
w = 20; % evolution speed
a = 0.05; % division factor for scaling phi

%% PRE-PROCESSING
% texture
im = imread(input_image);
im_double = double(im);
if size(im,3)==1 % just for equal visualization of rgb and gray test cases
    im = repmat(im,[1,1,3]);
end
% building dictionary
tree = build_km_tree(im_double,patch_size,branching_factor,...
    nToClust,number_layers,normalize);
% dictionary assignment
A = search_km_tree(im_double,tree,branching_factor,normalize);
% texture representation
[T1,T2] = transition_matrix(biadjacency_matrix(A,patch_size));
[r,c,l] = size(im_double);

% level set initialization
mask = initial_mask([r,c],radius,center);
phi = mask2sdf(mask);
gaussian_filter = fspecial('gaussian', [6*round(sigma)+1,1], sigma);...
    % gaussian filter for regularization of the level set curve

fig1 = figure; ax11 = subplot(121);
show_contour(im,phi), title('initialization')
%% EVOLUTION, VARIANT FROM SCIA 2015
fig2 = figure;
for i = 1:nr_step
    in = phi<0; % current segmentation
    DictProb = T1*in(:);
    alpha = sum(in(:))/sum(~in(:)); % area(in)/area(out)
    DictProb = DictProb./(DictProb+alpha*(1-DictProb)); % area normalization
    P = reshape(T2*DictProb,size(A)); % probabilities
    phi = phi + w*(0.5-P); % updating
    phi = filter2(gaussian_filter,filter2(gaussian_filter',phi)); % regularizing
    phi = phi/(1+a); % normalizing division (scaling phi)
    % phi = 50*phi/max(abs(phi(:))); % alternative to division
    % cla, show_phi(phi) % alternative visualization
    cla, show_contour(im,phi)
    title(['iter ',num2str(i),'/',num2str(nr_step)]), drawnow
end
figure(fig1), ax12 = subplot(122);
show_phi(phi), title('resulting curve and phi')
linkaxes([ax11;ax12])
