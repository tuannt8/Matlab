% shows input images for test cases
figure
for i= 1:12
    image = load_test_case(i);
    I = imread(image);
    if size(I,3)==1
        I = repmat(I,[1 1 3]); % for visualizing gray together with rgb
    end
    subplot(4,3,i), imagesc(I), axis image
    title(['test case ',num2str(i)])
end
