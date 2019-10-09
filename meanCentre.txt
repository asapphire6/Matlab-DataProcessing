function [mcData] = meanCentre(rawData)
% This function mean centres a matrix down the columns (calculating the mean of
% every column and then subtracting the relevant mean from every value of the
% corresponding column).

mcData = zeros(size(rawData));

for idx = 1:size(rawData,2)
    columnMean = mean(rawData(:,idx));
    for i = 1:size(rawData,1)
       mcData(i,idx) = rawData(i,idx) - columnMean;
    end
end

end

