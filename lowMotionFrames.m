function [lowMotionFrames, lowMotionIndex, lowDer] = lowMotionFrames(frameVector, der, threshold)
[m, p, k, n] = size(frameVector);
count = 1;
lowMotionFrames = zeros(m,p,k,n);
for i = 1:n-1
    if der(i) <= threshold
        lowMotionIndex(count) = i;
        count = count + 1;
        lowMotionFrames(:, :, :, i) = frameVector(:,:,:,i);
    end
end
lowDer = zeros(1, count - 1);
for j = 1:count - 1
    lowDer(j) = der(lowMotionIndex(j));
end

end

