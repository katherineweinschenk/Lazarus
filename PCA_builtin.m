% Built-in PCA Matlab function


folder ='D:\MAP\77.2.628_MatronC02R02'; 
I = dir(fullfile(folder,'*.tif'));
iter = size(I);

dim_file = fullfile(folder,I(1).name);
img_1 = imread(dim_file);
unraveled = img_1(:);
x = size(unraveled);
%data = zeros(x(1),iter(1));
num = 7;
data = zeros(x(1),num);

for k = 1:num
    filename = fullfile(folder,I(k).name);
    img = imread(filename); 
    unravel = img(:);
    column = unravel(:);
    %disp(column);
    data(:, k) = column;
end

coeff = pca(data);
bpca = coeff(:, 1);
bpca = reshape(bpca, size(img_1));
%pc = pca_data(:, 1);
%pc = reshape(pc, size(img_1));
% pc16 = uint8(bpca);
% pc16 = bitshift(pc16,4);
imshow(bpca)
