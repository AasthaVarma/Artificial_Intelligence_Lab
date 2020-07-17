
%{
%----My implementation---
for i=1:7
    a='D:\Computer_Science\LABS\Artificial_Intelligence\LAB6\orl_faces\s10\';
    a = strcat(a, int2str(i), '.pgm');
    img=imread(a);
    figure, imshow(img) 
end
%}
datapath = 'D:\Computer_Science\LABS\Artificial_Intelligence\LAB6\orl_faces\s10\';
% -------------Training---------------
% 1. Generate the face database.
face_db = [];
for i=1:6
   a = strcat(datapath, int2str(i), '.pgm');
   I = imread(a);
   temp = reshape(I', size(I, 1)*size(I, 2), 1);
   face_db = [face_db temp];
end

% 2. Mean Calculation
M = mean(face_db, 2);

% 3. Do mean 0
new_face_db = [];
for i = 1:6
    temp = double(face_db(:, i)) - M;
    new_face_db = [new_face_db temp];
end

% 4. Calculate Co-variance matrix
cov = new_face_db' * new_face_db;

% 5. Eigen values and corresponding vector.
[vec, val] = eig(cov);

% 6. Best direction using Kaiser's law.
best_eig = [];
for i=1:size(vec, 2)
   if(val(i,i) > 1) 
       best_eig = [best_eig vec(:, i)];
   end
end

% 7. Generate eigen faces.
eigen_faces = best_eig' * new_face_db';

% 8. Generate signature of each face.
sig_face = [];
for i=1:size(eigen_faces, 1)
    temp = eigen_faces * new_face_db(:, i);
    sig_face = [sig_face  temp]; 
end


% --------------Testing---------------
% 1. Take a test image.
num = 7;
a = strcat(datapath, int2str(num), '.pgm');
test_img = imread(a);
figure, imshow(test_img);
title('Test Image');
[r, c] = size(test_img);
I = reshape(test_img, r*c, 1);

% 2. Do mean 0
I_new = double(I) - M;

% 3. Project this mean aligned face to eigenface.
proj_test = eigen_faces * I_new;

% 4. Calculate eucildean distance between 
%    proj_test and all the faces in sig_face.
euc_dist = [];
for i = 1:size(sig_face, 2)
    temp = norm(proj_test-sig_face(:, i))^2;
    euc_dist = [euc_dist temp]; 
end

% 5. pick min euc distance image and output that
%    indexed face.

[min_euc_val, min_euc_idx] = min(euc_dist);
path = strcat(datapath, int2str(min_euc_idx), '.pgm');
figure, imshow(path);
title('Recognized Image!');
