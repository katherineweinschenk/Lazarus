folder = 'D:\77.2.628_MatronC01R01';
I = dir(fullfile(folder,'*.tif'));
iter = size(I);

dim_file = fullfile(folder,I(1).name);
roi_img = imread(dim_file);

matlab.graphics.internal.setPrintPreferences('DefaultPaperPositionMode','manual');
set(groot,'defaultFigurePaperPositionMode','manual');

imshow(uint8(roi_img));
roi = imfreehand;
pos = getPosition(roi);
disp(pos)

maskedImage = roi.createMask();

burnedImage = roi_img;
burnedImage(maskedImage) = 255;

blackMaskedImage = roi_img;
blackMaskedImage(~maskedImage) = 0;

insideMasked = roi_img;
insideMasked(maskedImage) = 0;

x = pos(:, 2); 
y = pos(:, 1);

topLine = min(x);
bottomLine = max(x);
leftColumn = min(y);
rightColumn = max(y);
width = bottomLine - topLine + 1;
height = rightColumn - leftColumn + 1;

outputFolder = 'D:\Polygon_ROI';
num = 0;

for f=1:iter
    filename = fullfile(folder,I(f).name);
    img = imread(filename);
    
    %position = wait(pos);
    
    try
        %rect2 = roi.getPositon;
        crop = imcrop(img, [topLine, leftColumn, width, height]);

        baseFileName = sprintf('freehandROI_%d.tif', num);
        %fullInputFileName = fullfile(folder, baseFileName);
        fullOutputFileName = fullfile(outputFolder, baseFileName);
        %fprintf(1, 'Now copying file #%d of %d: %s to %s\n',f, iter, fullInputFileName, fullOutputFileName);
        %[filepath,name,ext] = fileparts(images(f).name) ;
        imwrite(uint8(crop),fullOutputFileName);
        
        num = num + 1;
    catch exception
        disp(I(f).name)
    end
end
