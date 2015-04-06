function [ inSamples ] = AudioSamplesMFCCNormalization( inSamples )
%UNTÝTLED Summary of this function goes here
%   Detailed explanation goes here
total=[];
for i=1:length(inSamples)
    total=[total;inSamples(i).data];
end
m=mean(total);
v=var(total);

for i=1:length(inSamples)
    meanNorm=inSamples(i).data-repmat(m,size(inSamples(i).data,1),1);
    inSamples(i).data=meanNorm./repmat(v,size(meanNorm,1),1);
end

end

