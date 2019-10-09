function [ p ] = plotFTIR( x)
% Function to plot 1 FTIR spectrum at a time from Workspace variable

% Input a label for the data to be plotted to be added in the legend
prompt = 'Label the data:';
l = inputdlg(prompt);

% Select line colour from the list
lcolour = {'[0 0 0]', '[1 0 0 ]', '[0 0 1]', '[0.75 0 0.75]', '[0 0.5 0]', '[0 0.75 0.75]', '[1 0.84 0]', '[0 1 0]',...
        '[0.64 0.08 0.18]'}; 
clist = {'black', 'red', 'blue', 'purple', 'green', 'light blue', 'yellow', 'lime', 'maroon'};
cselection = listdlg('PromptString','Select line colour','SelectionMode','single','ListString',clist);

x1 = x(:,1);
x2 = x(:,2);
p = plot(x1, x2, 'DisplayName',l{:,:});
set(gca,'XDir','reverse');
set(p, 'LineWidth', 1, 'Color', lcolour{cselection});
xlim([399 4000]);
ylim([0 inf]);
xlabel('Wavenumber (cm^{-1})');
ylabel('Absorbance (a.u.)');
legend('-DynamicLegend','Location','northwest');
formatPlot(p);

% Add a title to the plot
button = questdlg('Would you like to add a title to the plot?');

    switch button
    case 'Yes'
        button = 1;
    case 'No'
        button = 0;
    case 'Cancel'
        button = 0;
    end 
 
if button == 1
 
    prompt2 = 'Enter plot title:';
    t = inputdlg(prompt2);
    set(gcf,'NumberTitle','off','Name', t{:,:});
    title(t);
else
    disp('Plotting Cancelled');
    clear
end


