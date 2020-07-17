xRiver = [139 151 156 166 161 169 167 175 170 175 171 180 168 159 163 168 164 159 169 166 159 166 167 177 212 200 209 196 221 147 166 178 182 183 187];
yRiver = [4 11 19 33 31 62 92 88 79 97 104 108 118 137 126 112 136 148 152 161 153 178 194 221 296 264 283 265 303 507 479 444 425 409 386];

xNonRiver = [20 25 52 60 96 111 63 117 128 125 135 127 137 122 132 121 119 143 135 139 139 26 21 12 141 146 124 13 102,49];
yNonRiver = [20 9 9 16 20 16 44 55 65 63 62 131 125 158 168 181 205 223 215 210 208 227 220 231 220 190 245 216 222,213];

RBand = imread('band1.gif');
GBand = imread('band2.gif');
BBand = imread('band3.gif');
IBand = imread('band4.gif');

rBandRiver = [];    rBandNonRiver = [];
gBandRiver = [];    gBandNonRiver = [];
bBandRiver = [];    bBandNonRiver = [];
iBandRiver = [];    iBandNonRiver = [];

for i=1:size(xRiver, 2)
   rBandRiver = [rBandRiver RBand(xRiver(i), yRiver(i))];
   gBandRiver = [gBandRiver GBand(xRiver(i), yRiver(i))];
   bBandRiver = [bBandRiver BBand(xRiver(i), yRiver(i))];
   iBandRiver = [iBandRiver IBand(xRiver(i), yRiver(i))];
end

for i=1:size(xNonRiver, 2)
   rBandNonRiver = [rBandNonRiver, RBand(xNonRiver(i), yNonRiver(i))];
   gBandNonRiver = [gBandNonRiver, GBand(xNonRiver(i), yNonRiver(i))];
   bBandNonRiver = [bBandNonRiver, BBand(xNonRiver(i), yNonRiver(i))];
   iBandNonRiver = [iBandNonRiver, IBand(xNonRiver(i), yNonRiver(i))];
end


mean_River = [mean(rBandRiver) mean(gBandRiver) mean(bBandRiver) mean(iBandRiver)];

mean_NonRiver = [mean(rBandNonRiver) mean(gBandNonRiver) mean(bBandNonRiver) mean(iBandNonRiver)];

River_RGBI = [rBandRiver; gBandRiver; bBandRiver; iBandRiver]';
NonRiver_RGBI = [rBandNonRiver; gBandNonRiver; bBandNonRiver; iBandNonRiver]';

cov_River = cov(single(River_RGBI));
cov_NonRiver = cov(single(NonRiver_RGBI));

inv_cov_River = inv(cov_River);
inv_cov_NonRiver = inv(cov_NonRiver);

det_cov_River = det(cov_River);
det_cov_NonRiver = det(cov_NonRiver);

out_image = zeros(512);
P1 = 0.7; P2=0.3;
for i=1:512
   for j=1:512
       test_point = double([RBand(i, j) GBand(i, j) BBand(i, j) IBand(i, j)]);
       
       River_class = -0.5*((test_point - mean_River) * inv_cov_River * (test_point - mean_River)');
       NonRiver_class = -0.5*((test_point - mean_NonRiver) * inv_cov_NonRiver * (test_point - mean_NonRiver)');
       
       p1 = -(0.5)*(1/sqrt(det_cov_River))*exp(River_class);
       p2 = -(0.5)*(1/sqrt(det_cov_NonRiver))*exp(NonRiver_class);
       
       if(P1*p1 >= P2*p2)
           out_image(i, j) = 255;
       else 
           out_image(i, j) = 0;
       end
   end
end
imshow(out_image);