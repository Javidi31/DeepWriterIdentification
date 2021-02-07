% Created on Mon May  6 17:19:20 2019
% Authors: Malihe Javidi. Email: m.javidi [at] qiet.ac.ir
% Authors: Mahdi Jampour. Email: jampour [at] icg.tugraz.at
function [count] = extractPatch(I,blkSize,slidingDis,threshold,path,FoldName,count)

if(~exist([path FoldName], 'dir'))
    mkdir([path FoldName])
end

[R,C] = size(I);
if(R<blkSize(1) || C<blkSize(2))
    return;
end

% take blocks in distances of 'slidingDix', but always take the first and last one (in each row and column).
idxMat = zeros(size(I)-blkSize+1);
idxMat([1:slidingDis(1):end-1,end],[1:slidingDis(2):end-1,end]) = 1; 
idx = find(idxMat);
[rows,cols] = ind2sub(size(idxMat),idx);
for i = 1:length(idx)
    Patch = I(rows(i):rows(i)+blkSize(1)-1,cols(i):cols(i)+blkSize(2)-1);
    
    a = sum(sum(255-Patch( 1: 3,:)));
    b = sum(sum(255-Patch(29:31,:)));
    c = sum(sum(255-Patch(58:60,:)));
    d = sum(sum(255-Patch));
    e = 255*threshold*blkSize(1)*blkSize(2);
    
    if(b>a && b>c && d>e)
        % Resize -> because we grabe patch with 
        % size [80 240] instead of [60 180]
        Patch =imresize(Patch, 0.75);
        if(count<10)
            imwrite(Patch,[path FoldName '\000' num2str(count) '.png']);   
        elseif(count<100)
            imwrite(Patch,[path FoldName  '\00' num2str(count) '.png']);   
        elseif(count<1000)
            imwrite(Patch,[path FoldName   '\0' num2str(count) '.png']);  
        else
            imwrite(Patch,[path FoldName        num2str(count) '.png']);   
        end
        count=count+1;        
    end
end