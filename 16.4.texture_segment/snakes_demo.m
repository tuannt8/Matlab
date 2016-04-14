% Version similar to: "Dictionary snakes"  by
% Anders Bjorholm Dahl and Vedrana Andersen Dahl
% 22nd International Conference on Pattern Recognition (ICPR) 2014
% Author: vand@dtu.dk

clear, close all
addpath texture_functions snakes_functions auxiliary_functions

%% SETTINGS
% loading image and initialization settings
test_case = 1; % chose one of 12 test cases, see with show_test_cases
[input_image,center,radius,patch_size] = load_test_case(test_case);
% M used here is 3, 5, 9 or 15: larger works better for textured images

% dictionary settings
nToClust = 5000; % nr random patches for building the dictionary tree
branching_factor = 5; % branching factor for dictionary tree
number_layers = 4; % nr. layers in dictionary tree
    % branching_factor and number_layers relate to dictionary size
normalize = true; % normalization makes texture invariant to global intensity changes

% curve evolution settings
nr_step = 150; % nr. evolution steps
step_size = 1; % evolution speed
alpha = 3; % curve elasticity
beta = 1; % curve stifness
nr_points = 500; % number of points in a snake

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

% snakes initialization
S = make_circular_snake(center, radius, nr_points);
S = keep_snake_inside(S,[r,c]);
B = regularization_matrix(nr_points,alpha,beta);

fig1 = figure; ax11 = subplot(121);
imagesc(im), axis image, hold on, plot(S(:,2),S(:,1),'g','LineWidth',2)
title('initialization')

%% EVOLUTION, VARIANT SIMILAR TO ICPR 2014
fig2 = figure;
for i = 1:nr_step    
    in = poly2mask(S(:,2),S(:,1),r,c); 
    DictProb = T1*in(:);
    alpha = sum(in(:))/sum(~in(:)); % area(in)/area(out)
    DictProb = DictProb./(DictProb+alpha*(1-DictProb)); % area normalization
    P = reshape(T2*DictProb,size(A)); % probabilities
    P_snake = P(sub2ind([r,c],round(S(:,1)),round(S(:,2)))); 
    %F = 5*(P_snake-0.5); % alternative snake force
    F = log(P_snake./(1-P_snake)); % log snake force
    F(P_snake<eps) = log(eps); % avoiding log(0)
    F(1-P_snake<eps) = log(1/eps); % avoiding log(1/0)    
    N = snake_normals(S); 
    S = S + step_size*F*[1,1].*N; % moving the snake according to the force
    S = B*S; % curve smoothing
    S = remove_crossings(S);
    S = place_points_equidistantly(S);
    S = keep_snake_inside(S,[r,c]);
    cla, imagesc(im), axis image, hold on, 
    %cla, imagesc(P-0.5,[-0.5,0.5]), colormap(blue_white_red), axis image, hold on, 
        plot(S([1:end,1],2),S([1:end,1],1),'g','LineWidth',2)
    title(['iter ',num2str(i),'/',num2str(nr_step)]), drawnow
end
figure(fig1), ax12 = subplot(122); imagesc(P-0.5,[-0.5,0.5]), colormap(blue_white_red)
axis image, hold on, plot(S([1:end,1],2),S([1:end,1],1),'g','LineWidth',2)
title('resulting curve and probabilities')
linkaxes([ax11;ax12])