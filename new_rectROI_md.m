folder = 'D:\77.2.628_MatronC01R01';
I = dir(fullfile(folder,'*.tif'));
iter = size(I);

dim_file = fullfile(folder,I(1).name);
roi_img = imread(dim_file);

matlab.graphics.internal.setPrintPreferences('DefaultPaperPositionMode','manual');
set(groot,'defaultFigurePaperPositionMode','manual');

imshow(uint8(roi_img));
%rect = drawrectangle;
rect = imrect;
pos = getPosition(rect);
%disp(pos)


outputFolder = 'D:\Output_roi_md';
num = 0;

for f=1:iter
    filename = fullfile(folder,I(f).name);
    img = imread(filename);
    
    %position = wait(pos);
    x = pos(1);
    y = pos(2);
    w = pos(3);
    h = pos(4);
    
    %warndlg('This is a warning','Template Matching','modal');
    %disp( 'finished' );
    
    
    try
        %rect2 = roi.getPositon;
        crop = imcrop(img,[x,y,x+w,y+h]);

        baseFileName = sprintf('rectROI_%d.tif', num);
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
