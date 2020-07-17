rb = double(imread('1.jpg'));
gb = double(imread('2.jpg'));
bb = double(imread('3.jpg'));
ib = double(imread('4.jpg'));

rb_ = reshape(rb(:, :, 1), 598*676, 1);
gb_ = reshape(gb(:, :, 1), 598*676, 1);
bb_ = reshape(bb(:, :, 1), 598*676, 1);
ib_ = reshape(ib(:, :, 1), 598*676, 1);

Image = [rb_, gb_, bb_, ib_];

[coeff, score, var] = pca(Image);

val = sum(coeff(1, 1:3));
trans=[];
k = 1;
%{
for i=1:598
   for j=1:676
      trans(k, 1) = Image(k, 1)*val+255*.4746;
      trans(k, 2) = Image(k, 2)*val+255*.4746;
      trans(k, 3) = Image(k, 3)*val+255*.4746;
      trans(k, 4) = Image(k, 4)*val+255*.4746;
      k = k+1;
   end
end

trans = (Image * val)- 255*0.5257;
Ipc = reshape(trans(:,4),598, 676);
imshow(Ipc);
%}

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