
function output_value = load_database();  % creating a function 
persistent loaded;  % Persistent variables are similar to global variables like static 
persistent numeric_Image;  
if(isempty(loaded))  % If it is empty only then we will load the dataset.
    all_Images = zeros(8600,40);  % We have 40 images. Each of them have 92 x 112 = 10304 pixels. That is why we have to take 10304 zeros for 40 times but since we resized we have to change
    for i=1:40        % for folders from 1 to 40 like s1,s2 ....
        cd(strcat('s',num2str(i))); % The “ strcat ” function ignores trailing whitespace characters in character vectors.
        for j=1:10 % for images
            image_Container = imread(strcat(num2str(j),'.pgm')); %  reading the images of pgm extention
            image_Container=imresize(image_Container,[100 86]); % resized image to 80 percent
            all_Images(:,(i-1)*10+j)=reshape(image_Container,size(image_Container,1)*size(image_Container,2),1); %   used ‘reshape’ function to convert the images into single column matrix.
            all_Images(:,(i-1)*10+j)=all_Images(:,(i-1)*10+j)+50; % increasing brightness
        end
        display('Loading Database');
        cd ..
    end
    numeric_Image = uint8(all_Images);
end
loaded = 1;
output_value = numeric_Image;

