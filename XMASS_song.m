function XMASS_song(c_DIR,c_unDIR,c_extra,T,F)
% compare 2 songs. Normalizing intensities of the inputted images.


if nargin < 5
   F = [];
end
if nargin < 4
   T = [];
end
if nargin < 3
   c_extra = [];
end


GT2 = mean(c_DIR,3);
GT1 = mean(c_unDIR,3);

if exist('c_extra') ==1;
    GT3 = mean(c_extra,3);
end

    
    

% Scrap XMASS song

[optimizer, metric] = imregconfig('multimodal')

optimizer.InitialRadius = 0.009;
optimizer.Epsilon = 1.5e-4;
optimizer.GrowthFactor = 1.01;
optimizer.MaximumIterations = 300;

GT1 = imregister(GT1, GT2, 'affine', optimizer, metric);
if exist('c_extra') ==1;
    GT3 = imregister(GT3, GT2, 'affine', optimizer, metric);
end
% Llim = 0.01;
% Hlim = 0.1;

Llim = 0.005;
Hlim = 0.40;
% for i = 1:3;
%
%     im(:,:,i) = mat2gray(G1{i}); %sleepless
%     im2(:,:,i) = mat2gray(G{i+1});  % with sleep
% end;





% AVG_1 = (G{1} + G{2} + G{3} + G{4})/4;
% AVG_2 = (G1{1} + G1{2} + G1{3} + G1{4}+ G1{5}+ G1{6})/6;

if exist('c_extra') ==1;
im1(:,:,1)=  mat2gray(GT1);
im1(:,:,2)=  mat2gray(GT2);
im1(:,:,3)=  mat2gray(GT3);
else
im1(:,:,1)=  mat2gray(GT1);
im1(:,:,2)=  mat2gray(GT2);
im1(:,:,3)=  mat2gray(GT1);
end

% im1(:,:,1) = imhistmatch(im1(:,:,1),im1(:,:,3));
% im1(:,:,2) = imhistmatch(im1(:,:,2),im1(:,:,3));
% im1(:,:,3) = imhistmatch(im1(:,:,3),im1(:,:,3));


% im2(:,:,1)=  mat2gray(G{2});
% im2(:,:,2)=  mat2gray(G1{5});
% im2(:,:,3)=  mat2gray(G1{5});
%
% im3(:,:,1)=  mat2gray(AVG_1);
% im3(:,:,2)=  mat2gray(AVG_2);
% im3(:,:,3)=  mat2gray(AVG_2);





RGB1 = imadjust(im1,[Llim Llim Llim; Hlim Hlim Hlim],[]);
% RGB2 = imadjust(im2,[Llim Llim Llim; Hlim Hlim Hlim],[]);
% RGB3 = imadjust(im3,[Llim Llim Llim; Hlim Hlim Hlim],[]);
%




figure();
% subplot(3,1,1);
try
image(T,F,flipdim(RGB1,1)); %ylim([700, 1000]);

catch
image(flipdim(RGB1,1)); %ylim([700, 1000]);
end

title('Day02, (directed = green)')
% legend('tit','tat');
% axis off;

% subplot(3,1,2);
% figure();
% imagesc(flipdim((GT2)-(GT1),1)); %ylim([700, 1000]);
% caxis([-50 50])
% colormap(fireice)
% colorbar
% axis off
% title('baseleine to interrupt')






% subplot(3,1,3);
% image(flipdim(RGB3,1)); ylim([700, 1000]);
% title('interrupt  to interrupt')

% figure();
% for i = 1:4;
% subplot(4,1,i)
% image(flipdim(G{i},1)); ylim([700, 1000]);
% end;
%
% figure();
% for i = 1:6;
% subplot(6,1,i)
% image(flipdim(G1{i},1)); ylim([700, 1000]);
% end;
