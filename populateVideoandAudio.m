clc
clear all
close all

load EmotionEvents

EmotionEvent = EmotionEvents(1);

pathtoVideoFile = 'C:\Users\Shabbir\Documents\GitHub\SCE_project\FrenchDatasetVideos\';



%function [audio, video]  = populateVideoandAudio(EmotionEvent,pathtoVideoFile)
videoFReader = vision.VideoFileReader([pathtoVideoFile,EmotionEvent.fileName,'.mp4']);
videoPlayer = vision.VideoPlayer;

startFrame = EmotionEvent.startTime/1000*30;
endFrame = EmotionEvent.endTime/1000*30;


for i = 1:startFrame-1
[videoFrame] = step(videoFReader);
end

k = 1;
while k < endFrame - startFrame
  [videoFrame] = step(videoFReader);
  step(videoPlayer, videoFrame);
  k = k+1;
end

release(videoPlayer);
release(videoFReader);
