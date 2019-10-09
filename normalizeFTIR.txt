function [spectrum_Norm] = normalizeFTIR(spectrum, peakLocation)
% Function to normalize a spectrum by the intensity of a selected peak

% Find peaks in the spectrum

[peaks,locs] = findpeaks(spectrum(:,2),'MinPeakProminence',.0000002);

% Find the peak nearest to the user-entered value

[~, index] = min(abs(spectrum(locs,1)-peakLocation));
normValue = peaks(index);

% Normalize the spectrum by dividing each absorbance value by the intensity
% value of the matched peak
spectrum_Norm = zeros(length(spectrum),2);
spectrum_Norm(:,1) = spectrum(:,1);

for i = 1:length(spectrum)
    spectrum_Norm(i,2) = spectrum(i,2) / normValue;
end

