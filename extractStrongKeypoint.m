function [strongKeypointVector, strongDescriptorVector] =  extractStrongKeypoint(folderName, seq, imgType, minimumIndex, keypointVector, descriptorVectors)
strongKeypointVector = cell(length(minimumIndex));
strongDescriptorVector = cell(length(minimumIndex));

for i=1:length(minimumIndex)
    depthFrame = imread(strcat(folderName,'/', seq,'/',imgType,'/', num2str(minimumIndex(i)),'.png'));
    depthFrame = depthFrame';
    keypoints = keypointVector{i};
    [n, numbKeypoints] = size(keypoints);
    
    count = 1;
    for j = 1:numbKeypoints
    x = round(keypoints(1, j));
    y = round(keypoints(2, j));
    z = depthFrame(x, y);
    radius = floor(keypoints(3, j));
        if(isLocalGeometryPlane(radius, x, y, z, depthFrame) == 1)
            strongKeypointVector{i}(:, count) = keypointVector{i}(:, j);
            strongDescriptorVector{i}(:, count) =  descriptorVectors{i}(:, j);
            count = count + 1;
        end      
    end
    
%     strongKeypointVector{i} = strongKeypoint;
%     strongDescriptorVector{i} = strongDescriptor;
    
end

end

function isRobust = isLocalGeometryPlane(radius, x, y, z, depthFrame)
threshold = 50;
isRobust = 1;
if z == 0
    isRobust = 0;
    return;
end
for deltax = 0:radius
    for deltay = 0:radius
        if(deltax + deltay <= radius)
            
            if(x + deltax <= 640 && y + deltay <= 480)
            neighOne = depthFrame(x + deltax, y + deltay);
                if(abs(neighOne - z) > threshold)
                    isRobust = 0;
                end
            end
            
            if(x + deltax <= 640 && y - deltay > 0)
            neighTwo = depthFrame(x + deltax, y - deltay);
                if(abs(neighTwo - z) > threshold)
                    isRobust = 0;
                end
            end
            
            if(x - deltax > 0 && y + deltay <= 480)
            neighThree = depthFrame(x - deltax, y + deltay);
                if(abs(neighThree - z) > threshold)
                    isRobust = 0;
                end
            end
            
            if(x - deltax > 0 && y - deltay > 0)
            neighFour = depthFrame(x - deltax, y - deltay);
                if(abs(neighFour - z) > threshold)
                    isRobust = 0;
                end
            end
            
        end
    end
end


end