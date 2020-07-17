function [recognized_img]= facerecognewME(datapath,testpath)
DELTA=[];
Face_Db=[];
projectimg=[];
for j=1:6
    a=strcat(datapath,'\',int2str(j),'.pgm');
    img=imread(a);
    [r c]=size(img);
    temp=reshape(img',r*c,1);
    Face_Db=[Face_Db double(temp)];
end
M=mean(Face_Db,2);
for i=1:size(M,2)
    temp=double(Face_Db(:,i))-M(i);
    DELTA=[DELTA temp];
end
C=DELTA'*DELTA;
[V, LAMBDA]=eig(C);
r=size(V,2);
F=[];
for i=1:r
    if(LAMBDA(i,i)>1)
        F=[F V(:,i)];
    end
end
eigenfaces=F'*DELTA';
% projected image vector matrix
for i=1:size(DELTA,2)
    temp=eigenfaces*DELTA(:,i);
    projectimg = [projectimg temp];
end 
test_image = imread(testpath);
test_image = test_image(:,:,1);
[r, c] = size(test_image);
I1 = reshape(test_image',r*c,1); % creating (MxN)x1 image vector from the 2D image
I2 = double(I1)-M; % mean subtracted vector
projtestimg = eigenfaces*I2; % projection of test image onto the facespace 
euclide_dist = [ ];
p=size(projectimg,2);
for i=1 : p
    temp = (norm(projtestimg-projectimg(:,i)))^2;
    euclide_dist = [euclide_dist temp];
end
[euclide_dist_min recognized_index] = min(euclide_dist);
recognized_img = strcat('\',int2str(recognized_index),'.pgm');  
end

        
        
        
    