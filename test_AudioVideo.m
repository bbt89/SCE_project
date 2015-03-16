clc
clear all
close all

load EmotionEvents
pathtoVideoDir = './FrenchDatasetVideos/';
 
[v,a] =  populateVideoandAudio(EmotionEvents(1),pathtoVideoDir);
