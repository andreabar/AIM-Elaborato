function [planarKeyPoints, planarDescriptors] = getRobustKeypoints(image, keypointVector, descriptorsVector, index)
    %calcola i keypoints robusti su di un singolo frame
    count = 1;
    for i = 1: length(keypointVector{index})
        isFlat = isLocalPlane(keypointVector{index}(:,i), image);         
        if isFlat
            planarKeyPoints(:, count) = keypointVector{index}(:,i); 
            planarDescriptors(:, count) = descriptorsVector{index}(:, i);
            count = count + 1;  
        end

    end
%     AllkeyPoint = length(keypointVector{1});
%     RobustKey = length(planarKeyPoints);
end