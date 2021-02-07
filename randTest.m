%Select Random Test Data

clear; clc;
src = 'Datasets\My_CERUG-EN_IMG\Test\';
des = 'Datasets\My_CERUG-EN_IMG\Test_rand\';

srcDB = dir(src);
maxNoTest = 500; 
for i=1:size(srcDB,1)-2
    scrFold  =  dir([src srcDB(i+2).name '\*.png']);
    imax     =  length(scrFold);
    index    =  randperm(imax, maxNoTest);
    desFold  =  srcDB(i+2).name;
    
    if(~exist([des desFold], 'dir'))
        mkdir([des desFold]);
    end
    
    for j=1:maxNoTest        
        fn1 = [src srcDB(i+2).name '\'  scrFold(index(j)).name];        
        if(j<10)
            fn2 = [des srcDB(i+2).name '\'  '000' num2str(j) '.png'];
        elseif (j<100)
            fn2 = [des srcDB(i+2).name '\'   '00' num2str(j) '.png'];
        else
            fn2 = [des srcDB(i+2).name '\'    '0' num2str(j) '.png'];
        end
        copyfile(fn1, fn2);
    end
    disp(desFold)
end