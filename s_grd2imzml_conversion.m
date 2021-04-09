
cd('C:\Users\tm6\Documents\GitHub\jimzMLConverter\target\')

% TOF data

P = dir('X:\Teresa\BEIS biofilms project sims data\neg ToF data\*properties*');
G = dir('X:\Teresa\BEIS biofilms project sims data\neg ToF data\*grd*');

for fi = 1:size(P,1)
    
    system(['java -jar jimzMLConverter-2.1.0.jar imzML -p "', P(fi).folder, filesep, P(fi).name, '" "', G(fi).folder, filesep, G(fi).name, '"'])
    
end