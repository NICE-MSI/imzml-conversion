
% update on 06 Oct 2020, tm

PDMAnalyserPath = 'X:\PDMAnalyser\'; % only needed for 'desi' or 'maldi'
jimzMLConverterPath = 'C:\Users\tm6\Documents\GitHub\jimzMLConverter\target\';

dataPath = 'X:\Chelsea\Kidney uMALDI\'; 

raw_path = dir([ dataPath '*.raw']); % find all raw files to convert
pdm_path = dir([ dataPath '*.pdm']); % find all related pdm files to convert

cd(PDMAnalyserPath) % set directory to PDMAnalyser
for i = 1:size(raw_path,1)   
    system(['PDMAnalyser "' dataPath pdm_path(i).name '"']); % call PDMAnalyser through the command line and convert
end

pat_path = dir([ dataPath '*.pat']); % find all related pat files to convert
   
cd(jimzMLConverterPath) % set directory to the jimzMLConverter
for i =  1:size(raw_path,1)
    system(['java -jar jimzMLConverter-2.1.0.jar imzML -p ' ['"' dataPath pat_path(i).name '"'] ' ' ['"' dataPath raw_path(i).name '"']]) %call imzML converter through command line
end