clc
clear all

A = textscan(fileread('Annotation.txt'),'%s\t%f\t%f\t%s\t%s','Delimiter','\t');
B  =cell(142,5);

for i =1:length(A);
    if iscell(A{1,i})
    B(:,i) =  A{1,i};
    else
    B(:,i) =  num2cell(A{1,i});

    end
end

EmotionEvents = cell2struct(B',{'label','startTime','endTime','description','fileName'});

for i=1:length(EmotiveEvents)
    EmotionEvents(i).fileName = EmotionEvents(i).fileName(1:end-4); 

end


