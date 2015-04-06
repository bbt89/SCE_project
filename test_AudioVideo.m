clc
clear all
close all

load EmotionEvents
videoPath = './FrenchDatasetVideos/';
audioPath = '';
featurePath = './textSource/';


files = dir([videoPath,'*-faceprops.csv']);

for i =1:length(files)
    testfileName = files(i).name(1:end-14);%'20150216_134553_00';
    SelectedEmotionEvents = EmotionEvents(strcmp(extractfield(EmotionEvents,'fileName'),'testfileName'));
    [timeStamp, final] = CreateStreamFromFaceProps(testfileName,videoPath);
    
    happinessLabel = final(:,1);
    mouthOpenedLabel = final(:,6);
    happinessLabel = happinessLabel==3;
    mouthOpenedLabel = mouthOpenedLabel==3;
    
    laughterStream =  happinessLabel & mouthOpenedLabel & ((final(:,4)==3)|(final(:,5)==3));
    laughterStreamA = DilationErosionFilter(laughterStream, 31,31);
    laughterStreamB = ErosionDilationFilter(laughterStreamA,31,31);
    
    bar(double(laughterStreamB));
    hold on;
    bar(double(laughterStreamA)/2,'r');
    hold off;
    ylim([0 2])
    pause
    %[timeStamp, final, finalSmoothed] = CreateLaughterStreamFromFaceProps(testfileName,featurePath,0);
    
    temp = conv(laughterStreamB,[1,-1],'same');
    startTimes = timeStamp(find(temp==1) + 1) ;
    endTimes = timeStamp(temp==-1);
    
    C = num2cell([startTimes,endTimes]);
    C(:,3) = repmat({'Laughter'},length(startTimes),1);
    fileID = fopen([videoPath,testfileName,'-auto.txt'],'w');
    formatSpec = '%f\t%f\t%s\n';
    
    [nrows,ncols] = size(C);
    for row = 1:nrows
        fprintf(fileID,formatSpec,C{row,:});
    end
    fclose(fileID);
end
%image(final')
% hf = figure;
% for i = 1:length(SelectedEmotionEvents)
% [mov,~] =  populateVideoandAudio(SelectedEmotionEvents(i),pathtoVideoDir);
% movie(hf,mov,1,30);
% drawnow;
% pause
% end



