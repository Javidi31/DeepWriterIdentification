% Created on Mon May  6 17:19:20 2019
% Authors: Malihe Javidi. Email: m.javidi [at] qiet.ac.ir
% Authors: Mahdi Jampour. Email: jampour [at] icg.tugraz.at
clear; clc;

%%
%Parameter setting
blkSize    = [80, 240];
slidingDis = [20   20];
%Exctract Train Patches
src        = '\Datasets\DB_CERUG-EN_IMG\Train\';
dst        = '\Datasets\My_CERUG-EN_IMG\Train\';
srcDB      = dir(src);
desDB      = dir(dst);
threshold  = 0.05;

for i=1:size(srcDB,1)-2
	count1=1;
	srcFoldName = [src srcDB(i+2).name,'\image_', srcDB(i+2).name '.png'];
	desFoldName = srcDB(i+2).name;
	image    = imread(srcFoldName);
	countRet = extractPatch(image,blkSize,slidingDis,threshold,dst,...
        desFoldName,count1);
	count1 = countRet;
	disp(srcFoldName);
end

% Count no of patches for each subject
disp('Number of Min and Max: ');
sizeArr=zeros(size(srcDB,1)-2,1);
for i=1:size(srcDB,1)-2
    pathPFoldName=[dst srcDB(i+2).name,'\'];
    pathPFold = dir(pathPFoldName);
    sizeArr(i)=size(pathPFold,1)-2;
end
disp(min(sizeArr));
disp(max(sizeArr))


%Exctract Test Patches
src        = '\Datasets\DB_CERUG-EN_IMG\Test\';
dst        = '\Datasets\My_CERUG-EN_IMG\Test\';
srcDB      = dir(src);
desDB      = dir(dst);
for i=1:size(srcDB,1)-2
	count1=1;
	srcFoldName = [src srcDB(i+2).name,'\image_', srcDB(i+2).name '.png'];
	desFoldName = srcDB(i+2).name;
	image    = imread(srcFoldName);
	countRet = extractPatch(image,blkSize,slidingDis,threshold,dst,...
        desFoldName,count1);
	count1 = countRet;
	disp(srcFoldName);
end
    

% Count no of patches for each subject
disp('Number of Min and Max: ');
sizeArr=zeros(size(srcDB,1)-2,1);
for i=1:size(srcDB,1)-2
    pathPFoldName=[dst srcDB(i+2).name,'\'];
    pathPFold = dir(pathPFoldName);
    sizeArr(i)=size(pathPFold,1)-2;
end
disp(min(sizeArr));
disp(max(sizeArr))
