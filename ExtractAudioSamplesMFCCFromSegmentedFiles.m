function [ AudioSamplesMFCC ] = ExtractAudioSamplesMFCCFromSegmentedFiles(path)
%UNTÝTLED4 Summary of this function goes here
%   Detailed explanation goes here

files=dir(path);
files=files(3:end);


winms=750; %in ms
shiftms=250; %frame periodicity in ms

% Feature Extraction
idcount=1;
AudioSamplesMFCC = [];
for j  = 1:length(files)
    [y,fs] = wavread([path,files(j).name]);
    winSize  = winms/1000*fs;
    winShift = shiftms/1000*fs;
    
    i =0;
    while winSize+ winShift*i < length(y)
        
        MFCCs = ExtractMFCC(y(1+winShift*i:winSize+winShift*i),fs);
        AudioSamplesMFCC(end+1,:).data = MFCCs;%extract_stats(MFCCs);
        
        AudioSamplesMFCC(end,:).id = idcount;
        AudioSamplesMFCC(end,:).label = 'Laughter';
        i  =i + 1;
    end
    idcount=idcount+1;
    disp(['done with the sample ', num2str(j), ' #wins in total: ' num2str(length(AudioSamplesMFCC))]);
end


end

