function f_updating_pat_file(patName)

fileID = fopen(patName);
formatSpec = '%s';
N = 1;

lazersize = 0;
lineunits = 0;
new_pat_file = string([]);
k = 0;

while ~feof(fileID)
    k = k + 1;
    C = textscan(fileID,formatSpec,N,'Delimiter','\t');
    
    if ~isempty(C{1})
        
        new_pat_file(k,1) = string(C{1,1}{1});
        
        if strcmpi(C{1,1}{1},'<LaserSize Units="mm">')
            lazersize = 1;
        end
                
        if strcmpi(C{1,1}{1}(1:3),'<X>') && lazersize
            step_char = C{1,1}{1};
            step_double = double(string(step_char(4:end-4)));
        end
        
        if strcmpi(C{1,1}{1},'<Line Units="mm">')
            lineunits = 1;
        end
        
        if strcmpi(C{1,1}{1}(1:4),'<X2>') && lineunits
            x2_char = C{1,1}{1};
            x2 = double(string(x2_char(5:end-5)));
            x2 = x2 - step_double;
            x2_char = string([ x2_char(1:4) char(string(x2)) x2_char(end-4:end) ]);
            new_pat_file(k,1) = x2_char;
        end
        
    end
    
end

fclose(fileID);

pat_row = strcat(repmat('%s\t',1,size(new_pat_file,2)-1),'%s\n');

fileID = fopen(patName,'w');
fprintf(fileID,pat_row, new_pat_file');
fclose(fileID);