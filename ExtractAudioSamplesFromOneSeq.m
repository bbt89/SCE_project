function [ out ] = ExtractAudioSamplesFromOneSeq ( y , idcount, label,fs, winms, shiftms, MFCCnotPNCC ) 
%UNTÝTLED4 Summary of this function goes here
%   Detailed explanation goes here

winSize  = winms/1000*fs;
winShift = shiftms/1000*fs;

% Feature Extraction
out = [];
i =0;

if(MFCCnotPNCC)
    while winSize+ winShift*i < length(y)

        MFCCs = ExtractMFCC(y(1+winShift*i:winSize+winShift*i),fs);
        out(end+1,:).data = MFCCs;%extract_stats(MFCCs);
        out(end,:).id = idcount;
        out(end,:).label = label;
        i  =i + 1;
    end
else
    if (fs~=16000)
     y = resample(y,16000,fs);
     winSize  = winms/1000*16000;
     winShift = shiftms/1000*16000;
    end
    while winSize+ winShift*i < length(y)
        
        PNCCs = ExtractPNCC(y(1+winShift*i:winSize+winShift*i));
        out(end+1,:).data = PNCCs;
        out(end,:).id = idcount;
        out(end,:).label = label;
        i  =i + 1;
    end
end

end

