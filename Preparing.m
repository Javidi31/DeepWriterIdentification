% Created on Mon May 6 2019
% Authors: Malihe Javidi. Email: m.javidi [at] qiet.ac.ir
% Authors: Mahdi Jampour. Email: jampour [at] icg.tugraz.at
clear; clc;


src = '\Datasets\DB_CERUG-EN_IMG\Org_train\';
dst = '\Datasets\DB_CERUG-EN_IMG\Train\';

Folders = dir(src);

% exception 47, 78, 82, 84, 93, 95
for i=3:length(Folders)                      
   Files = dir([src Folders(i).name]);
   
   img = 255*uint8(ones(520,1));
   for j=3:length(Files)
        fn = [src Folders(i).name '\' Files(j).name];
        im = imread(fn);
        if(size(im,3)>1)
            im = rgb2gray(im);
        end
	% For some folders threshold should be changed to 192
        im(im>64)=255;      
        [r,c] = size(im);
        img(:, end+1:end+c+5) = 255;
        img(1:r, end-c-5+1:end-5) = im;
        disp(fn);
   end
   
   mkdir([dst Folders(i).name]);
   imwrite(img, [dst Folders(i).name '\image_' Folders(i).name '.png']);
end

