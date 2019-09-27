clc
clear all

I = imread('lena.JPG');
figure(1)
imshow(I);

G = rgb2gray(I); 

figure(2)
imshow (G);

figure(3)
imhist(G);

% [rows columns depth]=size(G)