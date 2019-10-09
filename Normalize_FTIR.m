%% Normalize FTIR spectra

%% Select .txt or .dpt files to be normalized
 
[filename] = uigetfile('*.*',  'All Files (*.*)','MultiSelect','on');

% If a single file is selected the output will be a char instead of a cell 
% array & will need to be converted to a cell array

c = ischar(filename);
if c == 1
   filename = cellstr(filename);
end

clearvars c 

%% Import data from selected file(s)

for idx = 1:length(filename)
    if length(filename) == 1
       D = importdata(filename{idx});
       OriginalData = struct([]);
       OriginalData{1} = D;
    else    
       OriginalData{idx} = importdata(filename{idx});
    end
end

clearvars idx
%% Store the labelled data in a structure array:

for i = 1:length(filename)
    f = char(filename(i));
    f1 = f(:, 1:length(f)-4);
    fname = strrep(f1, ' ', '_');
    fname = strrep(fname,'_-_','_');
    Data.(fname) = OriginalData{i};
    filename{i} = fname; 
end

clearvars i f1 f OriginalData
%% Find the peaks in the spectra 

Peaks = zeros(1:length(filename));
wavenumbers = zeros(1:length(filename));

for i3 = 1:length(filename)
    [Peaks(i3),locs] = findpeaks(Data.(filename{i3})(:,2),'MinPeakProminence',.0000002); % the min height of the peak could be user specified
    wavenumbers(i3) = Data.(filename{i3})(:,1);
end    

clearvars i3 locs
%% show a dialogue window with the list of peaks to be selected, where
% output is a single wavenumber location of the peak to divide by in the 
% Spectrumvalue variable
Selection = zeros(1,length(filename));
button = 1;

% if the spectra are different lengths etc. the location of the peak may
% vary slightly so it has to be selected from a list for each spectrum individually

while button == 1
    
    [fselection,ok] = listdlg('PromptString','Select spectrum to normalize:',...
    'SelectionMode','single',...
    'ListString',filename);
    plist = eval(sprintf('int2str(Peaks(1,%d).%s(:,1))',fselection,filename{fselection(:,:)}));
    [Selection(:,fselection)] = listdlg('PromptString','Select peak to normalize by:','SelectionMode','single','ListString',plist);
    message = sprintf('%s Spectrum Normalized',filename{fselection});
    disp(message(:,:));
    questr = 'Would you like to select another spectrum?';
    button = questdlg(questr);
    
    switch button
    case 'Yes'
        button = 1;
    case 'No'
        break;
    case 'Cancel'
        break;
    end
end

clearvars button fselection lname ok plist questr message
%% use the Selection variable(s) as an index to select the relevant peak
% intensity values from the Peaklist variable and save them to a new
% variable Speaks

for idx2 = 1:length(filename)
    idx3 = Selection(idx2);
    SPeaks(1,idx2) = Spectrumvalue(idx3,idx2);
    peaklocs(idx2) = round(wnumvalue(Selection(idx2),idx2));
end

clearvars idx2 idx3 Selection Spectrumvalue wnumvalue list Peaks
%% Divide each spectrum from the structure Data by the peak value from the
% variable SPeaks & place into another structure called Normalized

for i = 1:length(filename)
    filename2{i} = sprintf('%s_Norm%d', filename{i}, peaklocs(1,i));
    Normalized.(filename2{i}) = [Data.(filename{i})(:,1), bsxfun(@rdivide,Data.(filename{i})(:,2),SPeaks(1,i))];
end

clearvars i SPeaks peaklocs filename2 filename

%% (Optional) Save the Workspace variables

questr = 'Would you like to save the variables?';
    button = questdlg(questr);
      
    switch button
    case 'Yes'
        button = 1;
    case 'No'
        button = 0;
    case 'Cancel'
        button = 0;
    end 

if button == 1
   prompt = 'Save file as:';
   f = inputdlg(prompt);
   clearvars button questr prompt
   save(f{:})
   disp('Workspace variables saved')
end
% in the future ask the user to select the folder/location to save the
% files

clearvars f button questr
