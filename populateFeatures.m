function [ feat ] = populateFeatures( EmotionEvents, extension)
%populateFeatures Summary of this function goes here
%   extension --> e.g. '_face', '_body' etc.

featTextPath='';
relativeTimetoMsecFactor=1/10000;

sampleNum=length(EmotionEvents);
files=unique(extractfield(EmotionEvents,'fileName'));


for i = 1:sampleNum
    fidv = fopen(['../Session',Samples(i).fileName(5),'/dialog/MOCAP_rotated/',Samples(i).fileName,'.txt'],'r');
    startFrame = round(Vfs*(Samples(i).startTime)/1000);
    if startFrame < 1
        startFrame = 1;
    end
    endFrame = round(Vfs*Samples(i).endTime/1000);
    
    [~]=textscan(fidv,'%d %f %s',startFrame,'Delimiter','\n','Headerlines',2);
    visseq(i).data=textscan(fidv,'%d %f %s',endFrame-startFrame,'Delimiter','\n');
    fclose(fidv);
    
    %disp(['done with ', num2str(i)]);
    
end

save Dataset/visseq.mat visseq

end

