function [fname] = removeFileExt(filename)
% This function removes the .* file extention as well as any whitespace
% and/or hyphens from filenames
% filename could be a char array of a single name or a cell array of
% multiple names
% the function will return an object of the same type

if ischar(filename) == 1
    fname = filename(:, 1:length(filename)-4);
    fname = formatFileName(fname);
else
    fname = cell(1,length(filename));
    for i = 1:length(filename)
       f = char(filename(i));
       f = formatFileName(f);
       fname{i} = f(:, 1:length(f)-4); 
    end
end

end

