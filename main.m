clear functions;
[frameVector, der] = cmpFrames('DroppedObjects', 'Seq1', 'RGB', 358);
threshold = calculateThreshold(der);
[lowMotionFrames, lowMotionIndex, lowDer] = lowMotionFrames(frameVector, der, threshold);
regionMinimums = staticFramePerRegion(lowMotionFrames, lowMotionIndex, lowDer);