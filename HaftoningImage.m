clc
clear all 

%Read the image and change to gray scale image
I = imread('lena.JPG');
G = rgb2gray(I);

%Create bayer array 
bayer=[.513 .272 .724 .483 .543 .302 .694 .453;
 .151 .755 .091 .966 .181 .758 .121 .936;
.634 .392 .574 .332 .664 .423 .604 .362;
.060 .875 .211 .815 .030 .906 .241 .845;
.543 .302 .694 .453 .513 .272 .724 .483;
.181 .758 .121 .936 .151 .755 .091 .966;
.664 .423 .604 .362 .634 .392 .574 .332;
.030 .906 .241 .845 .060 .875 .211 .815]*255;

%Classical-4 Dither Array
classical = [.567 .635 .608 .514 .424 .365 .392 .486;
.847 .878 .910 .698 .153 .122 .090 .302;
.820 .969 .941 .667 .180 .031 .059 .333;
.725 .788 .757 .545 .275 .212 .243 .455;
.424 .365 .392 .486 .567 .635 .608 .514;
.153 .122 .090 .302 .847 .878 .910 .698;
.180 .031 .059 .333 .820 .969 .941 .667;
.275 .212 .243 .455 .725 .788 .757 .545]*255;



%Round the values
bayer = round(bayer);
classical = round(classical);

%Get the value of row and column of image then assign to variable 'row',
%'col'
[row col] = size(G);

mask_bayer=repmat(bayer,row/8,col/8);

mask_classical=repmat(classical,row/8,col/8);

            
 for R=1:row
     for C=1:col
            if G(R,C) > mask_bayer(R,C)
                Bayer_Image(R,C) = 255; 
            else 
                Bayer_Image(R,C) = 0;
            end
     end
 end
 
  for R=1:row
     for C=1:col
            if G(R,C) > mask_classical(R,C)
                Class_Image(R,C) = 255; 
            else 
                Class_Image(R,C) = 0;
            end
     end
 end
 
 
%Show the desired image
figure
imshow(G);
title('Gray Scale Image')

figure 
imshow(Bayer_Image);
title('Ordered Dithering | Halftone Image by using Bayer-5 Dither Array')

figure 
imshow(Class_Image);
title('Ordered Dithering | Halftone Image by using Classical-4 Dither Array')