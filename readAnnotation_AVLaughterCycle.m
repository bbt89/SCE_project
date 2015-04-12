clear all;clc;close all;
annoPath='D:\JOKER\Databases\AVLaughterCycle\annotation1\';
AVLaughterCycleAnno=[];
data={};
for i=1:24
    [dataArray] = importAVLaughterCycleAnno([annoPath num2str(i) '.anno']);
    data={};
    %A=[startTime,endTime,type];
    data(:,1)=num2cell(dataArray{:,1});
    data(:,2)=num2cell(dataArray{:,2});
    data(:,3)=dataArray{:,3};
    data(:,4)=num2cell(repmat(1,size(data,1),1));
    B=cell2struct(data,{'startTime','endTime','type','fileName'},2);
    AVLaughterCycleAnno=[AVLaughterCycleAnno;B];
end