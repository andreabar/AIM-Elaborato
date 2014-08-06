function [planarKeyPoints] = getRobustKeypoints(image,keypointVector)
    %calcola i keypoints robusti su di un singolo frame
    count = 1;
    for i = 1: length(keypointVector{1})
        isFlat = isLocalPlane(keypointVector{1}(:,i), image);         
        if isFlat
            planarKeyPoints{count} = keypointVector{1}(:,i); 
            count = count + 1;  
        end

    end
    AllkeyPoint = length(keypointVector{1})
    RobustKey = length(planarKeyPoints)
end