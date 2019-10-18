
% update on 30 Sep 2019, 11:07, wz

PDMAnalyserPath = 'D:\PDMAnalyser\'; % only needed for 'desi' or 'maldi'
imzMLConverterPath = 'X:\Weiwei\jimzMLconverter\';
dataPath = 'X:\Beatson\Intracolonic tumour study\Pos DESI Data\'; 
addpath(genpath('X:\2019_Scripts for Data Processing\conversion\'));

%% Conversion

modality = 'desi'; % option= 'maldi' or 'desi' or 'umaldi'

%wz. Change '*.raw' to any wildcard patterns to capture the raw data 
%    sub-folders
%    Examples: for umaldi, '*.raw'
%              for desi,   '*slide*'  
rawfolder=dir([dataPath filesep '*.raw']);

%wz
cd(dataPath);

for i=1:size(rawfolder,1)
    pdmPath=dataPath;
    rawFilePath=pdmPath;
    %wz, when modality=umaldi, pdmPath will be the directory of individual 
    %    raw file subfolder which contains both raw data files (i.e. DAT, 
    %    IDX, STS, INF etc.) 

    f_batchConversion( PDMAnalyserPath, imzMLConverterPath, pdmPath, rawFilePath, modality );
    i
end
