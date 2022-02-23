clc;
clear;
close all;

img = imread('cameraman.tif');
space1 = '                                             ';

%a
sobel_x_3x3 = [-1,0,1;-2,0,2;-1,0,1];
new_img = op(img, sobel_x_3x3);
y=@(x) (1-x);
neg = y(new_img);
print({img,new_img,neg},'A',['Original image',space1,'Sobel operator 3x3',space1,'Negative image']);

%b
sobel_x_5x5 = [0.25,0.5,1,0.5,0.25;0.5,1,2,1,0.5;0,0,0,0,0;-0.5,-1,-2,-1,-0.5;-0.25,-0.5,-1,-0.5,-0.25];
new_img = op(img, sobel_x_5x5);
neg = y(new_img);
print({img,new_img,neg},'B',['Original image',space1,'Sobel operator 5x5',space1,'Negative image']);

%с
img_blur = imgaussfilt(img,1.4,'FilterSize',5);
new_img = op(img_blur, sobel_x_3x3);
neg = y(new_img);
print({img,img_blur,new_img,neg},'C',['Original image',space1,'Gaussian operator',space1,'Sobel operator 3x3',space1,'Negative image']);

function new_img = op(img,sobel_x)
    N = size(sobel_x,1);

    [ROW,COL] = size(img);
    dimg = double(img);
    new_img = zeros(ROW,COL);

    sobel_y = rot90(sobel_x,3);
    for i = 1:ROW - N + 1
        for j = 1:COL - N + 1
            funBox = dimg(i:i+N-1,j:j+N-1);
            G_x = sobel_x.* funBox;
            G_x = abs(sum(G_x(:)));
            G_y = sobel_y .* funBox;
            G_y = abs(sum(G_y(:)));
            sobelxy  = sqrt(G_x^2 + G_y^2)/4;
            new_img(i+1,j+1) = sobelxy;
        end
    end
    new_img = new_img/255;
end

function print(imgs,letter,str)
    figure('Name',letter,'NumberTitle','off');
    montage(imgs,'Size',[1, size(imgs,2)])
    title(str);
end