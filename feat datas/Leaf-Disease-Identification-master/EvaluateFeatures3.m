% Function to call and evaluate features
function [feat_disease] =  EvaluateFeatures3(org)
org=imresize(org,[256 256]);
org=rgb2gray(org);
%noisy= imnoise(org,'gaussian',0,0.001);%  % add noise of mean 0, variance 0.005
noisy=imnoise(org,'salt & pepper',0.02);
ns=medfilt2(noisy);
% start of calling normal shrink denoising algorithm

%ns_r = normal_shrink(noisy(:,:,1)); 
%ns_g = normal_shrink(noisy(:,:,2));
%ns_b = normal_shrink(noisy(:,:,3));
%ns_r= uint8(ns_r);
%ns_g= uint8(ns_g);
%ns_b= uint8(ns_b);
%ns = cat(3, ns_r, ns_g, ns_b);

% end of calling normal shrink denoising algorithm

% start of calling bilateral filter

ns2gray=adapthisteq(ns);
ns2gray = double(ns2gray);
B = imbilatfilt(ns2gray);
% end of calling bilateral filter

% kmeans clustering

 [k, class, img_vect]= kmeans(B, 5);
 for clust = 1:k
    cluster = reshape(class(1:length(img_vect),clust:clust), [256,256] );
    %subplot(1,k,clust), imshow(cluster,[]), title(['cluster ',num2str(clust)]);
 end
 
 clust=2;
 cluster = reshape(class(1:length(img_vect),clust:clust), [256,256] );
 h = mean2(cluster);
 
 clust = 3;
 cluster = reshape(class(1:length(img_vect),clust:clust), [256,256] );
 t = mean2(cluster);
 if(h<t)
     clust=3;
    cluster = reshape(class(1:length(img_vect),clust:clust), [256,256] );
   
 elseif(h>t)
     clust = 2;
     cluster = reshape(class(1:length(img_vect),clust:clust), [256,256] );
   
     
 end
 

I = cluster;
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
