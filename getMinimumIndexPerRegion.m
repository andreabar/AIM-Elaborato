function minimumIndex = getMinimumIndexPerRegion(lowMotionIndex, der)
regionDer = zeros(length(der), 2);
startRegion = 1;
region = 1;
for i = 1 : length(lowMotionIndex) - 1
    currentIndex = lowMotionIndex(i);
    nextIndex = lowMotionIndex(i + 1);
    if nextIndex - currentIndex > 30
        count = 1;
        for j = startRegion:i
            regionDer(count, region) = der(lowMotionIndex(j));
            count = count + 1;
        end
        for m=count:length(der)
            regionDer(m, region) = NaN;
        end
        region = region + 1;
        startRegion = i + 1;
    end        
end

count = 1;
for j = startRegion:i
    regionDer(count, region) = der(lowMotionIndex(j));
    count = count + 1;
end

for m = count:length(der)
    regionDer(m, region) = NaN;
end

minimumIndex = zeros(1, region);

for l = 1:region
    minValue = min(regionDer(:, l));
    minIndex = find(der(:) == minValue)
    minimumIndex(l) = minIndex;
end

end
    