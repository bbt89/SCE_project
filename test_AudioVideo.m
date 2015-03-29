clc
clear all
close all

load EmotionEvents
videoPath = './FrenchDatasetVideos/';
audioPath = '';
featurePath = './textSource/';

SelectedEmotionEvents = EmotionEvents(strcmp(extractfield(EmotionEvents,'type'),'Laughter'));

% hf = figure;
% for i = 1:length(SelectedEmotionEvents)
% [mov,~] =  populateVideoandAudio(SelectedEmotionEvents(i),pathtoVideoDir);
% movie(hf,mov,1,30);
% drawnow;
% pause
% end

testfileName = '20150216_144639_00';

[timeStamp, final, finalSmoothed] = CreateLaughterStreamFromFaceProps(testfileName,featurePath,2);

