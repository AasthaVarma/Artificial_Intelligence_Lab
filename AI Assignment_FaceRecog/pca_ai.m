%read all the images
rb = double(imread('1.jpg'));
gb = double(imread('2.jpg'));
bb = double(imread('3.jpg'));
ib = double(imread('4.jpg'));

%reshape it to 1d i.e (512*512, 1).
rb_ = reshape(rb(:, :, 1), 598*676, 1);
gb_ = reshape(gb(:, :, 1), 598*676, 1);
bb_ = reshape(bb(:, :, 1), 598*676, 1);
ib_ = reshape(ib(:, :, 1), 598*676, 1);

% build matrix of dimension (512*512) * 4
Image = [rb_, gb_, bb_, ib_];

[coeff, score, var] = pca(Image);

I = zeros(598, 676);

transformed = Image * coeff;

Ipc1 = reshape(transformed(:,1),size(I,1),size(I,2));
Ipc2 = reshape(transformed(:,2),size(I,1),size(I,2));
Ipc3 = reshape(transformed(:,3),size(I,1),size(I,2));
Ipc4 = reshape(transformed(:,4),size(I,1),size(I,2));

figure, imshow(Ipc1,[]);
figure, imshow(Ipc2,[]);
figure, imshow(Ipc3,[]);
figure, imshow(Ipc4,[])