% clc
% clear all
% close all
% 
% load EmotionEvents
% 
% EmotionEvent = EmotionEvents(1);
% 
% pathtoVideoFile = 'C:\Users\Shabbir\Documents\GitHub\SCE_project\FrenchDatasetVideos\';

function [tempVid, audio]  = populateVideoandAudio(EmotionEvent,pathtoVideoDir)
xyloObj = VideoReader([pathtoVideoDir,EmotionEvent.fileName,'.mp4']);
fps = xyloObj.FrameRate;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

startFrame = EmotionEvent.startTime/1000*fps;
endFrame = EmotionEvent.endTime/1000*fps;

TotalFrames = floor(endFrame-startFrame);  
tempVid = zeros(vidHeight,vidWidth,3,TotalFrames+1);

for k = 0 : TotalFrames
    tempVid(:,:,:,k+1) = read(xyloObj,startFrame+k);
end

audio = [];
