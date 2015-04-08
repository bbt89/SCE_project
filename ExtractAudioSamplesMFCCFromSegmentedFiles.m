function [ AudioSamplesMFCC ] = ExtractAudioSamplesMFCCFromSegmentedFiles(path, MFCCnotPNCC)
%UNTÝTLED4 Summary of this function goes here
%   Detailed explanation goes here

files=dir(path);
files=files(3:end);


winms=750; %in ms
shiftms=250; %frame periodicity in ms

label='Laughter';

% Feature Extraction
idcount=1;
AudioSamplesMFCC = [];
for j  = 1:length(files)
    [y,fs] = wavread([path,files(j).name]);
    
    [ out ] = ExtractAudioSamplesFromOneSeq ( y, idcount, label, fs, winms, shiftms, MFCCnotPNCC );
    AudioSamplesMFCC=[AudioSamplesMFCC;out];
    
    idcount=idcount+1;
    disp(['done with the sample ', num2str(j), ' #wins in total: ' num2str(length(AudioSamplesMFCC))]);
end


end

