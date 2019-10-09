function [Data, filename] = importData()
% Imports data from files and places it in a structure array

% Select .cvs files to be processed

[filename] = uigetfile('*.*',  'All Files (*.*)','MultiSelect','on');

% When a single file is selected the output will be a char instead of a cell 
% array & will need to be converted to a cell array

c = ischar(filename);
if c == 1
   filename = cellstr(filename);
end

%% Import data from selected file(s)

for idx = 1:length(filename)
    if length(filename) == 1
       D = importdata(filename{idx});
       Data = struct([]);
       Data{1} = D;
    else    
       Data{idx} = importdata(filename{idx});
    end
end

end

