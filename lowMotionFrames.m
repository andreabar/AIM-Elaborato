function [lowMotionIndex] = lowMotionFrames(der, threshold)
count = 1;
for i = 1:length(der)
    if der(i) <= threshold
        lowMotionIndex(count) = i;
        count = count + 1;
    end
end
% lowDer = zeros(1, count - 1);
% for j = 1:count - 1
%     lowMotionIndex(j)
% end

end

