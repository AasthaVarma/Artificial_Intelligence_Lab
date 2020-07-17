I = double(imread('4.jpg'));
X = reshape(I,size(I,1)*size(I,2),3);
coeff = pca(X);
Itransformed = X*coeff;
Ipc1 = reshape(Itransformed(:,1),size(I,1),size(I,2));
Ipc2 = reshape(Itransformed(:,2),size(I,1),size(I,2));
Ipc3 = reshape(Itransformed(:,3),size(I,1),size(I,2));
%Ipc4 = reshape(Itransformed(:,4), size(I,1), size(I,2));
figure, imshow(Ipc1,[]);
figure, imshow(Ipc2,[]);
figure, imshow(Ipc3,[])

%{
I = double(imread('1.jpg'));
X = reshape(I,size(I,1)*size(I,2),3);
coeff = pca(X);
Itransformed = X*coeff;
Ipc1 = reshape(Itransformed(:,1),size(I,1),size(I,2));

I = double(imread('2.jpg'));
X = reshape(I,size(I,1)*size(I,2),3);
coeff = pca(X);
Itransformed = X*coeff;
Ipc2 = reshape(Itransformed(:,1),size(I,1),size(I,2));

I = double(imread('3.jpg'));
X = reshape(I,size(I,1)*size(I,2),3);
coeff = pca(X);
Itransformed = X*coeff;
Ipc3 = reshape(Itransformed(:,1),size(I,1),size(I,2));

I = double(imread('4.jpg'));
X = reshape(I,size(I,1)*size(I,2),3);
coeff = pca(X);
Itransformed = X*coeff;
Ipc4 = reshape(Itransformed(:,1),size(I,1),size(I,2));

figure, imshow(Ipc1,[]);
figure, imshow(Ipc2,[]);
figure, imshow(Ipc3,[])
figure, imshow(Ipc4,[])
%}