function [ ] = f_batchConversion( PDMAnalyserPath, jimzMLConverterPath, pdmPath, rawFilePath, modality )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% umaldi case added by wz on 30 Sep 2019, 11:07


curPath = cd;

if strcmpi('desi',modality)
    
    cd(PDMAnalyserPath) %set directory to PDMAnalyser
    pdmsToProcess = dir([pdmPath '*.pdm']); %find all pdm's to convert
    for i = 1:size(pdmsToProcess) %go through all pdm's and create .pat files
        pdmName = [' "' pdmPath pdmsToProcess(i).name '"']; %create location name of pdm
        system(['PDMAnalyser' pdmName]); %call PDMAnalyser through the command line and convert
    end
    
    cd(jimzMLConverterPath) %set directory to the jimzMLConverter
    rawToProcess = dir([rawFilePath '*.raw']); %find all raw files to convert
    patToProcess = dir([pdmPath '*.pat']); %find all pat files to convert
    
    for i = 1:size(patToProcess)
        patName = [ pdmPath patToProcess(i).name ]; %create location name of pat
        f_updating_pat_file(patName)
        i
    end
    
    for i = 1:size(rawToProcess)
        patName = ['"' pdmPath patToProcess(i).name '"'] %create location name of pat
        rawName = ['"' rawFilePath rawToProcess(i).name '"'] %create loaction of RAW file
        system(['java -jar jimzMLConverter-2.1.0.jar imzML -p ' patName ' ' rawName]) %call imzML converter through command line
        i
    end
    
end


if strcmpi('umaldi',modality)    % wz: this is 'umaldi'
    datetime
    
    %cd(PDMAnalyserPath) %set directory to PDMAnalyser
    %cd(dataPath); % set umaldi raw data folder
    pdmsToProcess = dir([pdmPath filesep '*.txt']); %find all pdm's to convert
    for i=1:size(dir([pdmPath filesep '*.txt']),1) % wz: check and remove _HEADER.TXT entry
        if strcmpi(pdmsToProcess(i).name,'_HEADER.TXT')
            pdmsToProcess(i)=[];
        end
    end
    for i = 1:size(pdmsToProcess,1) %wz-txt-coord
        pdmName = [pdmPath filesep pdmsToProcess(i).name]; %create location name of pdm
        f_generateRasterCoords_fromMarkDataForNewSource([pdmName]);
    end
    
    cd(jimzMLConverterPath); %set directory to the jimzMLConverter
    rawToProcess = rawFilePath; %find all raw files to convert
    patToProcess = dir([pdmPath filesep '*_coords.txt']); %find all pat files to convert
  
    for i = 1:size(rawToProcess,1)
        patName = ['"' pdmPath filesep patToProcess(i).name '"']; %create location name of pat
        rawName = ['"' rawFilePath '"']; %create location of RAW file
        system(['java -jar jimzMLConverter-2.1.0.jar imzML -p ' patName ' ' rawName]) %call imzML converter through command line
        %i
    end
    
end



if strcmpi('maldi',modality) % wz: this is 'maldi'?
    
    cd(jimzMLConverterPath) %set directory to the imzMLConverter
    rawToProcess = dir([rawFilePath filesep '*.raw']); %find all raw files to convert
    patToProcess = dir([pdmPath filesep '*.pat']); %find all pat files to convert
    
    for i = 1:size(rawToProcess)
        patName = ['"' pdmPath filesep patToProcess(i).name '"'] %create location name of pat
        rawName = ['"' rawFilePath filesep rawToProcess(i).name '"'] %create loaction of RAW file
        system(['java -jar jimzMLConverter.jar imzML -p ' patName ' ' rawName]) %call imzML converter through command line
        i
    end
    
end

cd(curPath)

end
