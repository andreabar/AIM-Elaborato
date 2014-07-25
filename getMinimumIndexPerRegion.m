function minimumIndex = getMinimumIndexPerRegion(lowMotionIndex, der)
startRegion = lowMotionIndex(1);
endRegion = lowMotionIndex(length(lowMotionIndex));
count = 1;
for i = 1 : length(lowMotionIndex) - 1
     currentIndex = lowMotionIndex(i);
     nextIndex = lowMotionIndex(i + 1);
     if nextIndex - currentIndex > 30
         minValue = min(der(startRegion:currentIndex));         
         minimumIndex(count) = (startRegion-1) + find(der(startRegion:currentIndex) == minValue);
         startRegion = nextIndex;
         count = count + 1;
     end
end

if count > length(minimumIndex)
     minValue = min(der(startRegion:endRegion));   
     minimumIndex(count) = (startRegion-1) + find(der(startRegion:endRegion) == minValue);    
end


minimumIndex = zeros(1, region);

for l = 1:region
    minValue = min(regionDer(:, l));
    minIndex = find(der(:) == minValue);
    minimumIndex(l) = minIndex;
end

end
