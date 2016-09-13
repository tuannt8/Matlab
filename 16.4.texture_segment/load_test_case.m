function [image,center,radius,patch_size] = load_test_case(test_case,multiphase)
% Loads one of test cases for defomable texture segmentation. 
% Returns input image and settings for circular curve initialization.
% If multiphase is true returns multiple curves, otherwise only first.

switch test_case
    case 1        
        image = 'test_images/134052.jpg';
        center = [150,200; 250,350];
        radius = [50,50];
        patch_size = 3;
    case 2
        image = 'test_images/124084.jpg';
        center = [150,200; 180,300; 285,185];
        radius = [50,20,20];
        patch_size = 5;
    case 3
        image = 'test_images/12003.jpg';
        center = [150,200; 175,350; 225,465];
        radius = [50,20,20];
        patch_size = 9;
    case 4
        image = 'test_images/108073.jpg';
        center = [150,200; 250,210];
        radius = [50,20];
        patch_size = 5;
    case 6
        image = 'test_images/164074.jpg';
        center = [220,150; 280,410; 250,25];
        radius = [70,20,20];
        patch_size = 5;
    case 5
        image = 'test_images/105053.jpg';
        center = [170,170; 280,250];
        radius = [20,30];
        patch_size = 5; 
    case 7
        image = 'test_images/test_A1.png';
        center = [250,250; 375,375; 120,120 ; 120,70; 475, 465; 475, 495];
        radius = [50,50,20,20,20,20];
        patch_size = 11; 
    case 8
        image = 'test_images/test_A2.png';
        center = [250,250; 375,375; 120,120];
        radius = [50,50,100];
        patch_size = 9; 
    case 9
        image = 'test_images/test_B1.png';
        center = [250,250; 550,250];
        radius = [50,50];
        patch_size = 9; 
    case 10
        image = 'test_images/test_B2.png';
        center = [250,250; 550,250];
        radius = [50,50];
        patch_size = 9; 
    case 11
        image = 'test_images/test_C.png';
        center = [250,250; 550,250; 350,300];
        radius = [50,50,20];
        patch_size = 15; 
    case 12
        image = 'test_images/randen15.png';
        center = [128,32; 128,128; 128,225; 32,128];
        radius = [30,30,30,30];
        patch_size = 15; 
    case 13
        image = 'test_images/Tuan/58060.jpg';
        center = [193, 152];
        radius = [30];
        patch_size = 5; 
    case 14
        image = 'test_images/Tuan/69020.jpg';
        center = [131, 253];
        radius = [30];
        patch_size = 5; 
    case 15
        image = 'test_images/Tuan/134035.jpg';
        center = [197, 188];
        radius = [30];
        patch_size = 3; 
    case 16
        image = 'test_images/Tuan/253027.jpg';
        center = [197, 188];
        radius = [30];
        patch_size = 15;         
end

if nargin<2 || ~multiphase
    center = center(1,:);
    radius = radius(1);
end