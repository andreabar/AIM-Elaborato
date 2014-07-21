function regionMinimums = staticFramePerRegion(lowMotionFrames, lowMotionIndex, lowDer)
[m, p, k, n] = size(lowMotionFrames);
startRegion = 1;
region = 1;
regionFrames = zeros(m, p, k, n, 2);
regionDer = zeros(n, 2);
for i = 1 : n-1
    currentIndex = lowMotionIndex(i);
    nextIndex = lowMotionIndex(i + 1);
    if nextIndex - currentIndex > 30
        count = 1;
        for j = startRegion:i
            regionFrames(:, :, :, count, region) = lowMotionFrames(:, :, :, j);
            regionDer(count, region) = lowDer(j);
            count = count + 1;
        end
        for o = count:n
            regionDer(o, region) = NaN;
        end
        region = region + 1;
        startRegion = i + 1;
    end        
end

count = 1;
for j = startRegion:i+1
    regionFrames(:, :, :, count, region) = lowMotionFrames(:, :, :, j);
    regionDer(count, region) = lowDer(j);
    count = count + 1;
end

for o = count:n
    regionDer(o, region) = NaN;
end


regionMinimums = zeros(m, p, k, region);


for l = 1:region
    minValue = min(regionDer(:, l))
    minIndex = find(regionDer(:, l) == minValue);
    minFrame = regionFrames(:, :, :, minIndex, l);
    regionMinimums(:, :, :, l) = minFrame;
end

end
    