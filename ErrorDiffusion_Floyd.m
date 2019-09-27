% Matlab Implementation of Error diffusion using Floyd's and Steinberg's...
clc
clear all 

%Read the image and change to gray scale image
I = imread('yerim.JPG');
G = rgb2gray(I);

%Declare some variables
T = 128 % Thresholding

%Apply Zeropadding to matrix
OLD = Zeropadding_Floyd(G);


%Get the value of row and column of image then assign to variable 'row',
%'col'
[row col] = size(OLD);
NEW = zeros(size(OLD));

 for R=2: (row-1)
     for C=2 : (col-1)
            if (OLD(R,C) < T)
                 NEW(R,C) = 0; 
            else 
                 NEW(R,C) = 255;
            end;
            error = OLD(R,C) - NEW(R,C);
            
            OLD(R,C+1) = round(((7/16* error) + OLD(R,C+1)));
             
            OLD(R+1,C-1) = round(OLD(R+1,C-1) + (3/16 *error));
            OLD(R+1,C) = round(OLD(R+1,C) + (5/16 *error));  
            OLD(R+1,C+1) = round(OLD(R+1,C+1) + (1/16 *error));
     end
 end
 
%De-Padding Image
NEW = DePadding_Floyd(NEW);
 
%Show the desired image
figure
imshow(G);
title('Gray Scale Image')

%Show the halftoning image
figure
imshow(NEW);
title('Error diffusion using Floyd and Steinberg');


