%% Script for calculating an average spectrum from repeat FTIR measurements.

% Select sample files

[filename] = uigetfile('*.*', 'All Files (*.*)','MultiSelect','on');
c = length(filename);

if c == 1
   filename = cellstr(filename);
end
%% Import sample data into a matrix

for idx = 1:length(filename)
    Data{idx} = importdata(filename{idx});
    Spectra(:,idx) = Data{idx}(:,2);
end

Wavenumbers = Data{1,1}(:,1);

%% Create file name labels

f = char(filename{length(filename)});
f1 = f(:, 1:length(f)-6);
fname = strrep(f1, ' ', '_');
fname = strrep(fname,'_-_','_');
fname = strrep(fname,'-','_');
filename = sprintf('Avrg%d_%s',c , fname);

%% Calculate average spectra, standard deviation and relative standard 
% deviation from the repeat measurements

AvrgSpectrum = [Wavenumbers, mean(Spectra,2)];
eval(sprintf('%s = AvrgSpectrum;', filename));
eval(sprintf('SD5_%s = std(Spectra,0,2);', fname));
eval(sprintf('RSD5_%s = (SD5_%s.*100)./%s(:,2);', fname, fname, filename));

clearvars c Data f f1 idx Spectra Wavenumbers

%% Save variables as a .mat file & Avrg Spectrum as a .txt file

filename1 = strcat(filename, '.txt');
save(filename1, 'AvrgSpectrum', '-ascii')  
save(filename)
fprintf('%s - Done', fname)
clearvars 
