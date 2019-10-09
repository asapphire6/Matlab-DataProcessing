function [spectrum_BC] = baselineCorrection(spectrum)
% function to correct baseline of an FTIR spectrum by the average intensity
% at the 2200-2000 cm-1 region by subtracting it from the whole spectrum

for i = 1: length(spectrum)
    if spectrum(i,1) >= 2000 && spectrum(i,1) <= 2200
       correctionValues = spectrum(i,2);
    end
end

baselineCorrection = mean(correctionValues);

spectrum_BC = zeros(length(spectrum),2);
spectrum_BC(:,1) = spectrum(:,1);

for i = 1:length(spectrum)
    spectrum_BC(i,2) = spectrum(i,2) - baselineCorrection;
end

end

