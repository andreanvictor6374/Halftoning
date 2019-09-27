clc;clear all;

%Read an imput image and convert to gray scale image
I = imread('lena.JPG');
G = rgb2gray(I);
GG=double(G);
%Bayer-5 Dither Array
Bayer_5=[.513 .272 .724 .483 .543 .302 .694 .453;
       .151 .755 .091 .966 .181 .758 .121 .936;
       .634 .392 .574 .332 .664 .423 .604 .362;
       .060 .875 .211 .815 .030 .906 .241 .845;
       .543 .302 .694 .453 .513 .272 .724 .483;
       .181 .758 .121 .936 .151 .755 .091 .966;
       .664 .423 .604 .362 .634 .392 .574 .332;
       .030 .906 .241 .845 .060 .875 .211 .815]*255;

%Classical-4 Dither Array
Classical_4 = [.567 .635 .608 .514 .424 .365 .392 .486;
               .847 .878 .910 .698 .153 .122 .090 .302;
               .820 .969 .941 .667 .180 .031 .059 .333;
               .725 .788 .757 .545 .275 .212 .243 .455;
               .424 .365 .392 .486 .567 .635 .608 .514;
               .153 .122 .090 .302 .847 .878 .910 .698;
               .180 .031 .059 .333 .820 .969 .941 .667;
               .275 .212 .243 .455 .725 .788 .757 .545]*255;

%Round the values in order to obtain integer value
Bayer_5 = round(Bayer_5);
Classical_4 = round(Classical_4);

%to get the size of the image ( number of row and column of the image)%
[row col] = size(G);
% extension of Dither Array, so it can have the same size as the image
bayer5_extension=repmat(Bayer_5,row/8,col/8);
classical4_extension=repmat(Classical_4,row/8,col/8);

% ordered dithering process using Bayer-5 Dither Array            
 for R=1:row
     for C=1:col
            if G(R,C) > bayer5_extension(R,C)
                Bayer5_Image(R,C) = 255; 
            else 
                Bayer5_Image(R,C) = 0;
            end
     end
 end
% ordered dithering process using Classical-4 Dither Array
  for R=1:row
     for C=1:col
            if G(R,C) > classical4_extension(R,C)
                Classical4_Image(R,C) = 255; 
            else 
                Classical4_Image(R,C) = 0;
            end
     end
 end
 
%Show the result
figure
imshow(G);
title('Gray Scale Image')

figure 
imshow(Bayer5_Image);
title('Ordered Dithering-Halftone Image by using Bayer-5 Dither Array')

figure 
imshow(Classical4_Image);
title('Ordered Dithering-Halftone Image by using Classical-4 Dither Array')
A1=imgaussfilt(Classical4_Image);
A2=imgaussfilt(Bayer5_Image);
A3=imgaussfilt(GG);
psnr_classical= MyPsnr(A1,A3);
psnr_bayer= Mpsnr(A2,A3);
%err=immse(Bayer5_Image,GG);
%ssimmm=ssim(A1,A3);

%G = double(G); 
%G = uint8(G); 

