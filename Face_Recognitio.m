
% (step 1)
%  To recognize the faces, we loaded the dataset first (step 1)
loaded_Image=load_database();

% using random function we generated a random index
random_Index=round(400*rand(1,1)); % rounds each element of X to the nearest integer. and since 400 images we write 400

% Using the sequence of random index, we loaded the image which will be recognized later
random_Image=loaded_Image(:,random_Index);

% Rest of the images are also loaded into a separate variable.
rest_of_the_images=loaded_Image(:,[1:random_Index-1 random_Index+1:end]);  % leaving the loaded image        

image_Signature=20;  

% An image whose data matrix has class unit8 (8 bit unsigned integers from 0 to 255 
white_Image=uint8(ones(1,size(rest_of_the_images,2))); % size returns the length of dimension and one return 1*dim matrix of ones 

%(step 2)
% After that, we calculated the mean of all of the images  
mean_value=uint8(mean(rest_of_the_images,2));

%(step 3)
% and subtracted the mean from them.(mean subtracted image)
mean_Removed=rest_of_the_images-uint8(single(mean_value)*single(white_Image));

%(step 4)
% Scatter Matrix
L=single(mean_Removed)'*single(mean_Removed);  % Convert a double-precision variable to single precision with the single function.
% Single-precision floating-point format (sometimes called FP32 or float32) is a computer number format, usually occupying 32 bits in computer memory; it represents a wide dynamic range of numeric values by using a floating radix point.

%(step 5 and 6)
% The eigenvectors were calculated on these images
[V,D]=eig(L); % [ V , D ] = eig( A ) returns diagonal matrix D of eigenvalues and matrix V whose columns are the corresponding right eigenvectors
V=single(mean_Removed)*V;
V=V(:,end:-1:end-(image_Signature-1));     % pick the eigenvalues corresponding to the 10 largest eigenvalues 
all_image_Signatire=zeros(size(rest_of_the_images,2),image_Signature); 

%(step 7)
% projected train matrix 
%Calculating the signature for each image

for i=1:size(rest_of_the_images,2);
    all_image_Signatire(i,:)=single(mean_Removed(:,i))'*V;  
end

subplot(121);
% displaying random image
imshow(reshape(random_Image,100,[])); % resized so 100
title('Looking for this Face','FontWeight','bold','Fontsize',16,'color','red');
subplot(122);

% Testing phase

p=random_Image-mean_value; %   subtracted the mean value from the image which we want to recognize
s=single(p)'*V;  % multiplied it with the eigenvector.
z=[];

% based on the difference between current image signatures with the signature we mentioned above, we have predicted the recognized face.
for i=1:size(rest_of_the_images,2)   %  returns the length of dimension
    z=[z,norm(all_image_Signatire(i,:)-s,2)];
    if(rem(i,20)==0),imshow(reshape(rest_of_the_images(:,i),100,[])),end ; % if it is same then show
    drawnow;
end

[a,i]=min(z);
subplot(122);
imshow(reshape(rest_of_the_images(:,i),100,[])); % resized
title('Recognition Completed','FontWeight','bold','Fontsize',16,'color','red');
