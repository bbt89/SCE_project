function [ features ] = PopulateFeatures( EmotionEvents, flag)
%populateFeatures Summary of this function goes here
%   flag --> 0: face, 1: body

featTextPath='textSource/';
relativeTimetoMsecFactor=1/10000;

sampleNum=length(EmotionEvents);
allFiles=extractfield(EmotionEvents,'fileName');
uniqueFiles=unique(allFiles);
features{sampleNum}=[];
if(flag) 
    nCols = 175; %body
    extension='-body';
else
    nCols = 20; %face
    extension='-face';
end

format = '%s'; %['%d' repmat(',%f', [1 nCols])];
count=1;
for i = 1:length(uniqueFiles)
    %currentFile=cell2mat(uniqueFiles(i));
    currentFile=uniqueFiles{i};
    fidv = fopen([featTextPath currentFile extension '.csv'],'r');
    data = textscan(fidv,format,'Delimiter',',');
    temp=str2double(data{:});
    data=reshape(temp,nCols+1,length(temp)/(nCols+1))';
    timeArray=data(:,1)*relativeTimetoMsecFactor;
    
    mask=strcmp(allFiles,currentFile);
    currentFileEvents=EmotionEvents(mask);
    
    for j=1:length(currentFileEvents)
        sT=currentFileEvents(j).startTime;
        eT=currentFileEvents(j).endTime;
        timeMask=(timeArray > sT) & (timeArray < eT);
        features{count}=data(timeMask,2:end);
        disp(['done with ', num2str(count)]);
        count=count+1;
    end
    
    fclose(fidv);
end


end

