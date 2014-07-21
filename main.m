clear functions;
[frameVector, der] = cmpFrames('DroppedObjects', 'Seq2', 'RGB', 464);
threshold = calculateThreshold(der);
[lowMotionFrames, lowMotionIndex, lowDer] = lowMotionFrames(frameVector, der, threshold);
regionMinimums = staticFramePerRegion(lowMotionFrames, lowMotionIndex, lowDer);