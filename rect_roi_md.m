folder = 'D:\77.2.628_MatronC01R01';
I = dir(fullfile(folder,'*.tif'));
iter = size(I);

dim_file = fullfile(folder,I(1).name);
roi_img = imread(dim_file);

imshow(uint8(roi_img));
rect = drawrectangle;
%disp(rect)
roi = getrect;

for f=1:iter
    filename = fullfile(folder,I(f).name);
    img = imread(filename);
    
    try
        rect2 = roi.getPositon;
        crop = imcrop(img,rect2);

    catch exception
        disp(I(f).name)
    end
end
