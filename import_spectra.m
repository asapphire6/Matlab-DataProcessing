%% Import spectral data files into the workspace as a structure array

[filename] = uigetfile('*.*',  'All Files (*.*)','MultiSelect','on');

% When a single file is selected the output will be a char instead of a cell 
% array & will need to be converted to a cell array

c = ischar(filename);
if c == 1
   filename = cellstr(filename);
end

%% Create data labels

fname = cell(size(filename));   % create an empty cell array to hold the data labels

for i = 1:length(filename)
    f = char(filename(i));
    f1 = f(:, 1:length(f)-6);
    f2 = strrep(f1, ' ', '_');
    fname{i} = strrep(f2,'_-_','_');
end

%% Import data from selected file(s)

for idx = 1:length(filename)
    if length(filename) == 1
       Data = struct;
       Data.(fname{1}) = importdata(filename{1});
    else    
       Data.(fname{idx}) = (importdata(filename{idx}));
    end
end

clearvars idx filename clearvars i f f1 f2 c 