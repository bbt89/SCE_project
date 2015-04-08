% training a model
clear all

LAUGHTER = 1;
BREATHING = 2;
REJECT = 3;

% load source/AudioSamplesMFCC_IEMOCAP.mat
% load source/AudioSamplesMFCC_AVLaughterCycle.mat
% load source/AudioSamplesMFCC_IEMOCAPreject.mat
% 
% % normalization
% 
% [ AudioSamplesMFCC_IEMOCAP ] = AudioSamplesMFCCNormalization( [AudioSamplesMFCC_IEMOCAP;AudioSamplesMFCC_IEMOCAPreject] );
% [ AudioSamplesMFCC_AVLaughterCycle ] = AudioSamplesMFCCNormalization( AudioSamplesMFCC_AVLaughterCycle );
% 
% AffectDataSync=[AudioSamplesMFCC_IEMOCAP;AudioSamplesMFCC_AVLaughterCycle];

% loading normalized
load source/AudioSamplesMFCC_DBnorm2DBs.mat
AffectDataSync=AudioSamplesMFCC_DBnorm2DBs;
clear AudioSamplesMFCC_DBnorm2DBs

% label and feature extraction
LABEL=extractfield(AffectDataSync,'label')';
label = zeros(length(LABEL),1);
label(strcmp(LABEL,'Laughter')) = LAUGHTER;
label(strcmp(LABEL,'Breathing')) = BREATHING;
label(strcmp(LABEL,'REJECT')) = REJECT;


labelList = unique(label);
NClass = length(labelList);
datatemp=[]; data=[];
for i=1:length(AffectDataSync)
    data(i,:)=extract_stats(AffectDataSync(i).data);
end

nfoldCV = 3;
cRange=[-2 4 34];
gRange=[-12 1 -10];%gRange=[-13 1 -8];

[model, bestParam, grid ]= learn_on_trainingData(data, label, cRange, gRange, nfoldCV, 0);