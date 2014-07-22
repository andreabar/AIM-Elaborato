function [keypointVector, siftDescriptorVector] = getFrameKeypoint(folderName, seq, imgType, minimumIndex)
keypointVector = cell(length(minimumIndex));
siftDescriptorVector = cell(length(minimumIndex));

for i = 1:length(minimumIndex)
   frame = imread(strcat(folderName,'/', seq,'/',imgType,'/', num2str(minimumIndex(i)),'.png'));
   frame = single(rgb2gray(frame));
   [keypoints,descriptors] = vl_sift(frame);
   keypointVector{i} = keypoints;
   siftDescriptorVector{i} = descriptors;
end

end

