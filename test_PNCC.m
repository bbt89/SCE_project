clc
close all
clear all

load('./SampleDataset/sample.mat');


MFCCs = ExtractMFCC(sample,16000);
PNCCs = ExtractPNCC(sample);


figure;
imagesc(MFCCs');
figure;
imagesc(PNCCs');



