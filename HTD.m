function HTD()
    clear; clc;
	
    MyPath = '\Datasets\My_CERUG-EN_IMG\Train\';
    Folder = dir(MyPath);
    
    k=0;
    Data1 = [];
	numClass = 105;		% Attention *
    for i=1:numClass         
        disp(i);
        Files = dir([MyPath Folder(i+2).name '\']);
        sampleNo = length(Files)-2; %size(Files, 

        for j=1:sampleNo
            fprintf('.')
            img = imread([MyPath Folder(i+2).name '\' Files(j+2).name]);
            k=k+1;
            Data1(k, :) = ThickFeat(img);
        end
        fprintf('\n')
        save('\HTDDescriptor\Data_CERUG_Tr.mat' , 'Data1');     % Attention *
    end
    MaxTot = max(max(Data1));
    Data1 = Data1./MaxTot;
    save('\HTDDescriptor\Data_CERUG_Tr.mat' , 'Data1');         % Attention *
	
	
	MyPath = '\Datasets\My_CERUG-EN_IMG\Te_Rand\';
    Folder = dir(MyPath);
    
    k=0;
    Data1 = [];
	numClass = 105;		% Attention *
    for i=1:numClass         
        disp(i);
        Files = dir([MyPath Folder(i+2).name '\']);
        sampleNo = length(Files)-2; %size(Files, 

        for j=1:sampleNo
            fprintf('.')
            img = imread([MyPath Folder(i+2).name '\' Files(j+2).name]);
            k=k+1;
            Data1(k, :) = ThickFeat(img);
        end
        fprintf('\n')
        save('\HTDDescriptor\Data_CERUG_Te.mat' , 'Data1');     % Attention *
    end    
    MaxTot = max(max(Data1));
    Data1 = Data1./MaxTot;
    save('\HTDDescriptor\Data_CERUG_Te.mat' , 'Data1');         % Attention *
end


function Feat2 = ThickFeat(img)
    [R,C,Z] = size(img);
    if(Z==3)
        img = rgb2gray(img);
    end
    img  = double(imbinarize(img));
    Feat = zeros(1, 10);
    Feat2 = zeros(1, 9);

    for k=1:10
        s  = k+1;
        Ns = 0;

        for i=1:R-s
            for j=1:C-s
                mask = img(i:i+s-1, j:j+s-1);            

                % Meaning all pixels must be 0 
                if(sum(sum(mask)) == 0)
                    Ns = Ns+1;
                end            
            end
        end
        Feat(1, k) = (Ns);
    end
    Feat = Feat./(sum(sum(img==0)));

    % Compute differential to decrease sensitivity
    for i=1:9
        Feat2(1, i)=Feat(1, i)-Feat(1, i+1);
    end
end
