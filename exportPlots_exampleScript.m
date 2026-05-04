pdfFile = 'AllFigures.pdf';

% Delete old PDF if it exists (important to avoid appending to old file)
if isfile(pdfFile)
    delete(pdfFile);
end

% === Your plotting code ===
for k = 1:5
    figure;
    plot(rand(10,1));
    title(['Figure ', num2str(k)]);
    
    % Export and append to PDF
    exportgraphics(gcf, pdfFile, 'Append', true);
end