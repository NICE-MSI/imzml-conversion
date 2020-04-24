
% update on 22 April 2020, tm

PDMAnalyserPath = 'X:\PDMAnalyser\'; % only needed for 'desi' or 'maldi'
jimzMLConverterPath = 'C:\Users\tm6\jimzMLConverter\';

dataPath = 'C:\Users\tm6\Documents\HCP Anywhere\CRUK Data processing study\CassetteDosed\rawdata2convert\'; 
%addpath(genpath('C:\Users\tm6\Documents\GitHub\imzml-conversion\'));

raw_path = dir([ dataPath '*16h*.raw']); % find all raw files to convert
pdm_path = dir([ dataPath '*16h*.pdm']); % find all related pdm files to convert

cd(PDMAnalyserPath) % set directory to PDMAnalyser
for i = 1:size(raw_path,1)   
    system(['PDMAnalyser "' dataPath pdm_path(i).name '"']); % call PDMAnalyser through the command line and convert
end

pat_path = dir([ dataPath '*16h*.pat']); % find all related pat files to convert
   
cd(jimzMLConverterPath) % set directory to the jimzMLConverter
for i = 1:size(raw_path,1)
    % f_updating_pat_file([dataPath pat_path(i).name])
    system(['java -jar jimzMLConverter.jar imzML -p ' ['"' dataPath pat_path(i).name '"'] ' ' ['"' dataPath raw_path(i).name '"']]) %call imzML converter through command line
end