function [lowMotionFrames, lowMotionIndex, lowDer] = lowMotionFrames(frameVector, der, threshold)
[m, p, k, n] = size(frameVector);
count = 1;
for i = 1:n-1
    if der(1, i) <= threshold
        lowMotionIndex(count) = i;
        count = count + 1;
    end
end
lowMotionFrames = zeros(m, p, k, count - 1);
lowDer = zeros(1, count - 1);
for j = 1:count - 1
    lowMotionFrames(:, :, :, j) = frameVector(:, :, :, lowMotionIndex(1, j));
    lowDer(1, j) = der(1, lowMotionIndex(1, j));
end

end

