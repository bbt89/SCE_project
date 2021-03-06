function [timeStamp, final, finalSmoothed] = CreateLaughterStreamFromFaceProps(testfileName,featurePath,filterSizePred)

features = GrabFeaturesforSingleFile(testfileName,featurePath,'faceProps');
time= features(:,1);
time = time./10000000;
ind = round(time*30);

timeStamp = (0:1/30:time(end))';
happinessLabel = zeros(size(timeStamp));
happinessLabel(ind) = features(:,2);

mouthOpenedLabel = zeros(size(timeStamp));
mouthOpenedLabel(ind) = features(:,7);

happinessLabel = happinessLabel==3;
mouthOpenedLabel = mouthOpenedLabel==3;

A =  zeros(size(timeStamp));
A(ind) = features(:,5);

B =  zeros(size(timeStamp));
B(ind) = features(:,6);


final =  happinessLabel & mouthOpenedLabel & ((A==3)|(B==3));

%filterSizePred=2;
predict_label_temp=[final(1:filterSizePred);final;final(end-(filterSizePred+1):end)];
finalSmoothed = zeros(size(final));

for i =1:length(final)
    finalSmoothed(i) = median(predict_label_temp(i:i+2*filterSizePred,1));
end

end