clc
clear all
close all

load EmotionEvents
pathtoVideoDir = './FrenchDatasetVideos/';
 
SelectedEmotionEvents = EmotionEvents(strcmp(extractfield(EmotionEvents,'label'),'Laughter'));
hf = figure;

for i = 1:length(SelectedEmotionEvents)
%[v,mov] =  populateVideoandAudio(SelectedEmotionEvents(i),pathtoVideoDir);

movie(hf,mov,1,30);
drawnow;
pause
end