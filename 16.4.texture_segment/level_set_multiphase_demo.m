% Version similar to: "Dictionary Based Image Segmentation" by
% Anders Bjorhom Dahl and Vedrana Andersen Dahl,
% 19th Scandinavian Conference on Image Analysis (SCIA) 2015
% Author: vand@dtu.dk

clear, close all
addpath texture_functions level_set_functions auxiliary_functions

%% SETTINGS
% loading image and initialization settings
test_case = 1; % chose one of 12 test cases, see with show_test_cases
[input_image,centers,radii,patch_size] = load_test_case(test_case,true);
% M used here is 3, 5, 9 or 15: larger works better for textured images

% dictionary settings
nToClust = 20000; % nr random patches for building the dictionary tree
branching_factor = 6; % branching factor for dictionary tree
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


%% level set initialization
[r,c,l] = size(im_double);
mask = zeros(r,c,numel(radii)); % one level set for each phase
for i=1:numel(radii) 
    mask(:,:,i+1) = initial_mask([r,c],radii(i),centers(i,:));
end
mask(:,:,1) = ones(r,c) - sum(mask,3);% background

phi = mask2sdf(mask);
gaussian_filter = fspecial('gaussian', [6*round(sigma)+1,1], sigma);...
    % gaussian filter for regularization of the level set curve

fig1 = figure; ax11 = subplot(121); 
show_contour(im,phi), title('initialization')
%% ITERATE, VARIANT FROM SCIA 2015
tic;
fig2 = figure;
for i = 1:nr_step
    in = reshape(phi<0,[size(phi,1)*size(phi,2),size(phi,3)]); ...
        % current segmentation
    DictProb = T1*in;    
    % carefull area normalization
    alpha = sum(in); % area for each class
    alpha(alpha==0) = eps; % preventing division with 0
    DictProb = DictProb*diag(1./alpha);  % dividing with area 
    sDictProb = sum(DictProb,2); % sum of probs for each dict pixel
        sDictProb(sDictProb==0) = eps; % preventing division with 0
    DictProb = spdiags(1./sDictProb(:),0,size(sDictProb,1),...
        size(sDictProb,1))*DictProb;  % each pixel sums to 1
    %DictProb = diag(1./sDictProb)*DictProb; % each pixel sums to 1
    P = reshape(T2*DictProb,size(phi)); % probabilities
    P_relative = relative_probability(P); % relative (multilable) probabilities
    phi = phi + w*(0.5-P_relative); % updating
    % regularizing
    for j = 1:size(phi,3)
        phi(:,:,j) = filter2(gaussian_filter,filter2(gaussian_filter',phi(:,:,j)));
    end
    phi = phi/(1+a); % normalizing division (scaling phi)
    % cla, show_multiphase_phi(phi) % alternative visualization
    cla, show_contour(im,phi,2)
    title(['iter ',num2str(i),'/',num2str(nr_step)]), drawnow
end
toc;
figure(fig1), ax12 = subplot(122);
show_contour(im,phi), title('resulting curves'), linkaxes([ax11;ax12])
fig3 = figure; show_multiphase_phi(phi)