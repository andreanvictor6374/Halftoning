clc; clear all;

%Read an imput image and convert to gray scale image
I = imread('yerim.jpg');
G = rgb2gray(I);


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
%to attain the size of the image ( number of row and column of the image)%
[row col] = size(G);


%to attain total block of Dither Array along 'column' and 'row'%
num_R=floor(row/8);
num_C=floor(col/8);
%a process to determine whether an image has extra column or row which is
%not fit with the Dither Array
k=1;
l=1;
if mod(row,8)==0
 k=0;  
end
if mod(col,8)==0 
l=0;
end
% ordered dithering process using Bayer-5 Dither Array
diff_C=0;
diff_R=0;
for r=1:num_R+k
    if r>num_R
        diff_R=8-mod(row,8); 
    end 
    for c=1:num_C+l    
        if c>num_C
            diff_C=8-mod(col,8);
        end 
            r1=0;
         for R=(r*8)-7:8*r-diff_R
             r1=r1+1;
             c1=0;
             for C=(c*8)-7:8*c-diff_C
             c1=c1+1;
                    if G(R,C) > Bayer_5(r1,c1)
                        Bayer5_Image(R,C) = 255; 
                    else 
                        Bayer5_Image(R,C) = 0;
                    end
             end
         end 
    end
end
% ordered dithering process using Classical-4 Dither Array
diff_C=0;
diff_R=0;
for r=1:num_R+k
    if r>num_R
        diff_R=8-mod(row,8); 
    end 
    for c=1:num_C+l    
        if c>num_C
            diff_C=8-mod(col,8);
        end 
            r1=0;
         for R=(r*8)-7:8*r-diff_R
             r1=r1+1;
             c1=0;
             for C=(c*8)-7:8*c-diff_C
             c1=c1+1;
                    if G(R,C) > Classical_4(r1,c1)
                        Classical4_Image(R,C) = 255; 
                    else 
                        Classical4_Image(R,C) = 0;
                    end
             end
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