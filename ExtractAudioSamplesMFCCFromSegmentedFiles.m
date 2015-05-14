function [ AudioSamplesMFCC, AffectBursts ] = ExtractAudioSamplesMFCCFromSegmentedFiles(path, MFCCnotPNCC)
%UNTÝTLED4 Summary of this function goes here
%   Detailed explanation goes here

files=dir(path);
files=files(3:end);

% for AVLaughterCycle (24th is not certain)
genders=['F','M','M','F','F','M','F','M','M','F','M','M','M','F','M','M','F','M','M','F','M','M','M','M'];

winms=750; %in ms
shiftms=250; %frame periodicity in ms

label='Laughter';

% Feature Extraction
idcount=1;
AudioSamplesMFCC = [];
for j  = 1:length(files)
    [y,fs] = wavread([path,files(j).name]);
    
    dataread=textscan(files(j).name,'%d_%d_%d.wav');
    AffectBursts(j).type='Laughter';
    AffectBursts(j).startTime=dataread{2};
    AffectBursts(j).endTime=dataread{3};
    AffectBursts(j).sesNumber=dataread{1};
    AffectBursts(j).gender=genders(dataread{1});
    AffectBursts(j).fileName=dataread{1};
    
    [ out ] = ExtractAudioSamplesFromOneSeq ( y, idcount, label, fs, winms, shiftms, MFCCnotPNCC );
    for i=1:length(out)
        out(i).sesNumber=dataread{1};
        out(i).gender=genders(dataread{1});
        out(i).fileName=dataread{1};
    end
    AudioSamplesMFCC=[AudioSamplesMFCC;out];
    
    idcount=idcount+1;
    disp(['done with the sample ', num2str(j), ' #wins in total: ' num2str(length(AudioSamplesMFCC))]);
end


end

