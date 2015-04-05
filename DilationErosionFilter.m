function [outputSignal2,outputSignal] = DilationErosionFilter(signal, paramDilate,paramErode)

step = (paramDilate-1)/2;

if length(signal) ~=size(signal,1)
    signal = signal';
end

signalPadded = [zeros(step,1);signal;zeros(step,1)];
outputSignal = zeros(size(signalPadded));
vv=find(signalPadded~=0);
for i = 1:length(vv)
    outputSignal(vv(i)-step:vv(i)+step) = ones(step*2+1,1);
end

outputSignal = outputSignal(step+1:end-step);

step = (paramErode-1)/2;
signalPadded = [zeros(step,1);outputSignal;zeros(step,1)];

outputSignal2 = zeros(size(signalPadded));

for i =step+1:length(signalPadded)-step
    outputSignal2(i) = sum(signalPadded(i-step:i+step))==length(i-step:i+step);
end


outputSignal2 = outputSignal2(step+1:end-step);

end
