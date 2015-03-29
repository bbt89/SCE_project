function features = GrabFeaturesforSingleFiles(fileName,path,tag)
features = csvread([path,'/',fileName,'-',tag,'.txt']);

end
