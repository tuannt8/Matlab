%%
domain_size = [100 100 100];

%%
domain = zeros(domain_size);

%% Add object

% domain(round_coords([15, 15, 15], 50, domain_size)) = 0.2;
domain(square_coords([-10,-10, -10] , [50, 80, 90], domain_size)) = 0.7;

%% Save it
directory_name = 'square';
[status, msg, msgID] = mkdir(directory_name);


for i = 1:domain_size(3)
    img = squeeze(domain(:,:,i));
    imwrite(img, [directory_name '/im_' num2str(i-1) '.png']);
end

