%
% This demo package was made by Chanwoo Kim
%
% Nov. 17, 2010
%


clear all
close all

% Original speech spectrogram

figure


fid = fopen('sb01_Clean.sph', 'rb');
subplot(4, 1, 1)
fseek(fid, 1024, 'bof');
x = fread(fid, 'int16');
fclose(fid);
specgram(x, 512, 16000, hamming(80));
title('speech spectrogram (clean)')

fid = fopen('sb01_White_05dB.sph', 'rb');
subplot(4, 1, 2)
fseek(fid, 1024, 'bof');
x = fread(fid, 'int16');
fclose(fid);
specgram(x, 512, 16000, hamming(80));
title('speech spectrogram (white 5-dB)')

fid = fopen('sb01_Music_05dB.sph', 'rb');
subplot(4, 1, 3)
fseek(fid, 1024, 'bof');
x = fread(fid, 'int16');
fclose(fid);
specgram(x, 512, 16000, hamming(80));
title('speech spectrogram (music 5-dB)')

fid = fopen('sb01_Street_05dB.sph', 'rb');
subplot(4, 1, 4)
fseek(fid, 1024, 'bof');
x = fread(fid, 'int16');
fclose(fid);
specgram(x, 512, 16000, hamming(80));
title('speech spectrogram (street 5-dB)')


%
%
%Using log-nonlineartiy + Gammatone weighting 
%
% In our recognition experiment, it was doing still better than MFCC
%
figure
subplot(4, 1, 1)
aadDCT = PNCC_IEEETranForDemo('out_Clean_LOG.feat', 'sb01_Clean.sph'      , 0, 0);
%
% Using imagesc is NOT a good way to see the spectrogram, since it
% automatically scales the range.
%
% Instead of doing this,adjustment is made for clean, and for noise
% the same scale is used to see the effects of noise objectively
%

aadSpec       = idct(aadDCT, 40);
dMean = mean(aadSpec(:));
dStd  = std(aadSpec(:));

dShift = 35 - dMean;
dScale = 10 / dStd;


image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('Log Nonlinearity + Gammatone weighting (clean)')
subplot(4, 1, 2)
aadDCT = PNCC_IEEETranForDemo('out_White05_LOG.feat', 'sb01_White_05dB.sph' , 0, 0);
image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('Log Nonlinearity + Gammatone weighting (white 5-dB)')
subplot(4, 1, 3)
aadDCT = PNCC_IEEETranForDemo('out_Music05_LOG.feat', 'sb01_Music_05dB.sph' , 0, 0);
image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('Log Nonlinearity + Gammatone weighting (music 5-dB)')
subplot(4, 1, 4)
aadDCT = PNCC_IEEETranForDemo('out_Street05_LOG.feat', 'sb01_Street_05dB.sph', 0, 0);
image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('Log Nonlinearity + Gammatone weighting (street 5-dB)')



%
%
%PNCC
%
%
figure
subplot(4, 1, 1)
aadDCT = PNCC_IEEETranForDemo('out_Clean_PNCC.feat', 'sb01_Clean.sph'      , 1, 1);

%
% Using imagesc is NOT a good way to see the spectrogram, since it
% automatically scales the range.
%
% Instead of doing this,adjustment is made for clean, and for noise
% the same scale is used to see the effects of noise objectively
%

aadSpec       = idct(aadDCT, 40);
dMean = mean(aadSpec(:));
dStd  = std(aadSpec(:));

dShift = 35 - dMean;
dScale = 10 / dStd;

image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('PNCC (clean)')
subplot(4, 1, 2)
aadDCT = PNCC_IEEETranForDemo('out_White05_PNCC.feat', 'sb01_White_05dB.sph' , 1, 1);
image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('PNCC (white 5-dB)')
subplot(4, 1, 3)
aadDCT = PNCC_IEEETranForDemo('out_Music05_PNCC.feat', 'sb01_Music_05dB.sph' , 1, 1);
image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('PNCC (music 5-dB)')
subplot(4, 1, 4)
aadDCT = PNCC_IEEETranForDemo('out_Street05_PNCC.feat', 'sb01_Street_05dB.sph', 1, 1);
image(dScale * idct(aadDCT, 40) + dShift); axis xy;
xlabel('Frame index')
ylabel('Channel frequency index')
title('PNCC (street 5-dB)')

if ispc == 1
   !del *.feat 
end

if isunix == 1
    !rm -f *.feat
end


