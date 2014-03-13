function saveSkeletonImage( skeleton, outputFile )
%skeleton - 20x3 matrix of joint coordinates
%outputFile - file to save skeleton visualization to

fig = figure('visible','off');
Fplot3Dskel(skeleton);
disp(['Saving skeleton visualization to ', outputFile]);
print(fig, '-dpng', outputFile);
close(fig);

end

