clc
clear all
close all

load EmotionEvents
videoPath = './FrenchDatasetVideos/';
audioPath = '';
featurePath = './textSource/';

testfileName = '20150216_153807_00';

SelectedEmotionEvents = EmotionEvents(strcmp(extractfield(EmotionEvents,'fileName'),'testfileName'));
[timeStamp, final, finalSmoothed] = CreateLaughterStreamFromFaceProps(testfileName,featurePath,0);
%[timeStamp, final] = CreateStreamFromFaceProps(testfileName,featurePath);

temp = conv(finalSmoothed,[1,-1],'same');
startTimes = timeStamp(find(temp==1) + 1) ;
endTimes = timeStamp(temp==-1);

C = num2cell([startTimes,endTimes]);
C(:,3) = repmat({'Laughter'},length(startTimes),1);
fileID = fopen('auto.txt','w');
formatSpec = '%f\t%f\t%s\n';

[nrows,ncols] = size(C);
for row = 1:nrows
    fprintf(fileID,formatSpec,C{row,:});
end
fclose(fileID);

%image(final')
% hf = figure;
% for i = 1:length(SelectedEmotionEvents)
% [mov,~] =  populateVideoandAudio(SelectedEmotionEvents(i),pathtoVideoDir);
% movie(hf,mov,1,30);
% drawnow;
% pause
% end



