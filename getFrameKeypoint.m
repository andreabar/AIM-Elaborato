function [keypointVector, siftDescriptorVector] = getFrameKeypoint(folderName, seq, imgType, minimumIndex)
keypointVector = cell(length(minimumIndex));
siftDescriptorVector = cell(length(minimumIndex));

for i = 1:length(minimumIndex)
   rgbFrame = imread(strcat(folderName,'/', seq,'/',imgType,'/', num2str(minimumIndex(i)),'.png'));
   rgbFrame = single(rgb2gray(rgbFrame));
   [keypoints,descriptors] = vl_sift(rgbFrame);
   keypointVector{i} = keypoints;
   siftDescriptorVector{i} = descriptors;
end


end

