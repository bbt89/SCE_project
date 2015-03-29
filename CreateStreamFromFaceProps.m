function [timeStamp, final] = CreateStreamFromFaceProps(testfileName,featurePath)

features = GrabFeaturesforSingleFile(testfileName,featurePath,'faceProps');
time= features(:,1);
time = time./10000000;
ind = round(time*30);
timeStamp = (0:1/30:time(end))';
final = zeros(size(timeStamp,1), size(features,2)-1);

for i =1:size(features,2)-1
final(ind,i) = features(:,i+1);
end

end