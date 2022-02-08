clear;
x_min = 0;
x_max = 255;
x = x_min:1:x_max;

L1=imread('cameraman.tif'); figure, imshow(L1);

%1
a = 80;
b = 200;
y1=@(x) (x-a)/(b-a).*(x>=a & x<=b);
figure, plot(x,y1(x),'LineWidth',2); grid on; set(gcf,'Color',[1 1 1]);
axis([x_min x_max 0 1.1]);

L11=y1(double(L1)); figure, imshow(L11);

%2
s2=imread('saturn2.gif'); figure, imshow(s2);
s2m = medfilt2(s2); figure, imshow(s2m);

s3=imread('saturn3.gif'); figure, imshow(s3);
s3m = medfilt2(s3, [5,5]); figure, imshow(s3m);

%3
y3 = @(x) 4/x_max^2*x.*(x_max-x);
figure, plot(x,y3(x),'LineWidth',2); grid on; set(gcf,'Color',[1 1 1]);

L31=y3(double(L1)); figure, imshow(L31);