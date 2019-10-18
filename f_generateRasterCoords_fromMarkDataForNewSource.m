function [ ] = f_generateRasterCoords_fromMarkDataForNewSource(rasterFile)

fid = fopen(rasterFile);

data = str2num(fread(fid, Inf, '*char')');
lines = data(9:end);

fclose(fid);

outputFile = [rasterFile(1:end-4) '_coords.txt'];

fid = fopen(outputFile, 'w');

for i = 1:lines(1)
    fprintf(fid, '-1 -1 -1\n');
end

x = 1;
y = 1;

numScans = uint32(data(7));
offset = uint32(data(8));
curLoc = lines(1);

for x = 1:offset
        fprintf(fid, '-1 -1 -1\n');
    end

for y = 1:length(lines)
    curLoc = lines(y);
    
    
    
    for x = 1:numScans
        fprintf(fid, '%d %d 1\n', x, y);
    end
    
    curLoc = curLoc + numScans;
    
    if(y < length(lines))
        for x = curLoc:lines(y+1)-1
            fprintf(fid, '-1 -1 -1\n');
        end
    end
end

fclose(fid);
disp(['Image is ' num2str(x) ' by ' num2str(y) ' pixels'])

end
