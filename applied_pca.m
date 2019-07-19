
%Applying PCA linear combinations to other map sections
%{
folder ='D:\MAP\77.2.628_MatronC03R02'; 
I = dir(fullfile(folder,'*.tif'));
num_img = size(I);

dim_file = fullfile(folder,I(1).name);
img_1 = imread(dim_file);
unraveled = img_1(:);
x = size(unraveled);
num_pixel = x(1);
data = zeros(num_pixel,num);

for k = 1:num
    filename = fullfile(folder,I(k).name);
    img = imread(filename); 
    unravel = img(:);
    column = unravel(:);
    data(:, k) = column;
end

%{
debugging stuff
output_1 = zeros(num_pixel, 1);
col = mapping.M(:,1);
col = col.';    
for i = 1:num_pixel
    row = data(i,:);
    output_1(i) = dot(row, col);
end
%output_1 = uint8(min(255, output_1));
output_1 = reshape(output_1, size(img_1));
imwrite(output_1, fullfile('C:\Users\Student\Desktop\map_pca', 'uint8.tif'));
%}

%trying to recreate all PCA output images

tic 
for k = 1:dim
    int = num2str(k);
    filename = strcat('test__map0302_', int, '.tif');
    output = zeros(num_pixel, 1);
    col = mapping.M(:,k);
    col = col.';    
    for i = 1:num_pixel
        row = data(i,:);
        output(i) = dot(row, col);
    end
    output = reshape(output, size(img_1));
    imwrite(output, fullfile('C:\Users\Student\Desktop\map_pca', filename));
end
toc

