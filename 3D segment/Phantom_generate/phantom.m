%%
domain_size = [100 100 100];
[X,Y,Z] = meshgrid(1:1:domain_size(1),1:1:domain_size(2), 1:domain_size(3));
[x y z] = meshgrid(0:0.01:0.99,0:0.01:0.99,0:0.01:0.99);


%%
domain = zeros(domain_size);

%% Add object

domain(round_coords([15, 15, 15], 50, domain_size)) = 0.2;
domain(square_coords([-10,-10, -10] , [50, 80, 90], domain_size)) = 0.7;
F = -z + 0.7 - (x-0.5).*(x-.5) - (y-0.5).*(y-0.5);
domain(F<0) = 0.5;
%% Save it
directory_name = 'square_sin';
[status, msg, msgID] = mkdir(directory_name);


for i = 1:domain_size(3)
    img = squeeze(domain(:,:,i));
    imwrite(img, [directory_name '/im_' num2str(i-1) '.png']);
end

