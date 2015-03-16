function [ feat ] = populateFeatures( EmotionEvents, flag)
%populateFeatures Summary of this function goes here
%   flag --> 0: face, 1: body

featTextPath='textSource/';
relativeTimetoMsecFactor=1/10000;

sampleNum=length(EmotionEvents);
allFiles=extractfield(EmotionEvents,'fileName');
uniqueFiles=unique(allFiles);
if(flag) 
    nCols = 60; %body
    extension='_body';
else
    nCols = 60; %face
    extension='_face';
end

format = ['%d' repmat('%f', [1 nCols])];

for i = 1:length(uniqueFiles)
    fidv = fopen([featTextPath,uniqueFiles(i),extension,'.txt'],'r');
    data = textscan(fidv,format,'Delimiter','\n');
    
    find(allFiles,uniqueFiles(i));
    
    
    fclose(fidv);
    
    %disp(['done with ', num2str(i)]);
    
end

save Dataset/visseq.mat visseq

end

