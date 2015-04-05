function [outputSignal2,outputSignal] = ErosionDilationFilter(signal,paramErode,paramDilate)

if length(signal) ~=size(signal,1)
    signal = signal';
end

step = (paramErode-1)/2;
signalPadded = [zeros(step,1);signal;zeros(step,1)];

outputSignal = zeros(size(signalPadded));

for i =step+1:length(signalPadded)-step
    outputSignal(i) = sum(signalPadded(i-step:i+step))==length(i-step:i+step);
end


outputSignal = outputSignal(step+1:end-step);


step = (paramDilate-1)/2;

signalPadded = [zeros(step,1);outputSignal;zeros(step,1)];
outputSignal2 = zeros(size(signalPadded));
vv=find(signalPadded~=0);
for i = 1:length(vv)
    outputSignal2(vv(i)-step:vv(i)+step) = ones(step*2+1,1);
end

outputSignal2 = outputSignal2(step+1:end-step);
end