% Function to call and evaluate features
function [feat_disease] =  EvaluateFeatures2(org)
org=imresize(org,[256,256]);
gray=rgb2gray(org);
%imshow(gray);

I_eq= adapthisteq(gray);
%imshow(I_eq);

bw= imbinarize(I_eq, graythresh(I_eq));

%imshow(bw);

bw3 = imopen(bw, ones(3,3));
bw4 = bwareaopen(bw3, 20);
bw4_perim = bwperim(bw4);
overlay1 = imoverlay(I_eq, bw4_perim, [.3 1 .3]);
%imshow(overlay1);


mask_em = imregionalmax(~bw4); %fgm
mask_em = imclose(mask_em, ones(3,3));
mask_em = imerode(mask_em, ones(3,3));
mask_em = bwareaopen(mask_em, 30);

I = mask_em;
I=double(I);
I = reshape(I.',1,[]);
e=entropy(I);

m1=mean2(I);

s=std2(I);

v=mean2(var(I));

k=kurtosis(I);
sk=skewness(I);

gg=graycomatrix(I);
stats = graycoprops(gg,'Contrast Correlation Energy Homogeneity');
contrast=stats.Contrast;
core=stats.Correlation;
energy=stats.Energy;
homo=stats.Homogeneity;
RMS=mean2(rms(I));

a = sum(I(:));
smoothness = 1-(1/(1+a));

% Inverse Difference Movement
m = size(I,1);
n = size(I,2);
in_diff = 0;
for i = 1:m
    for j = 1:n
        temp = I(i,j)./(1+(i-j).^2);
        in_diff = in_diff+temp;
    end
end
IDM = in_diff;

feat_disease=[];
    
feat_disease = [e,m1,s,v,k,sk,contrast,core,energy,homo,RMS,smoothness,IDM];

end
