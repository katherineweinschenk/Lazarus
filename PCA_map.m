
global mapping;
global pca_data;
global num;
global dim;
global data;

%choose folder of images
folder ='D:\MAP\77.2.628_MatronC02R02'; 
I = dir(fullfile(folder,'*.tif'));

%find total number of images in the folder
num_img = size(I);

%find image size
dim_file = fullfile(folder,I(1).name);
img_1 = imread(dim_file);
unraveled = img_1(:);
x = size(unraveled);

%choose number of images to reduce
num = 8;

%initialize data matrix
data = zeros(x(1),num); 

%iterate through the folder to add data into the matrix
for k = 1:num
    filename = fullfile(folder,I(k).name);
    img = imread(filename); 
    unravel = img(:);
    column = unravel(:);
    %disp(column);
    data(:, k) = column;
end

%preform PCA and choose output folder
dim = num-1;
tic
[pca_data, mapping] = compute_mapping(data, 'PCA', dim);
output_folder = 'C:\Users\Student\Desktop\trash';

%reshape images and save them
for j = 1:dim
    pc = pca_data(:, j);
    pc = reshape(pc, size(img_1));
    F = strcat('pc_', num2str(j), '.tif');
    imwrite(pc, fullfile(output_folder, F));
end
toc