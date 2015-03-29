function [mov, audio]  = PopulateVideoandAudio(EmotionEvent,pathtoVideoDir)

xyloObj = VideoReader([pathtoVideoDir,EmotionEvent.fileName,'.mp4']);

fps = xyloObj.FrameRate;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

startFrame = EmotionEvent.startTime/1000*fps;
endFrame = EmotionEvent.endTime/1000*fps;

TotalFrames = floor(endFrame-startFrame);  

mov = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);
for k = 0 : TotalFrames
     mov(k+1).cdata = read(xyloObj,startFrame+k);
     %tempVid(:,:,:,k+1)= mov(k+1).cdata;
end

audio = [];
