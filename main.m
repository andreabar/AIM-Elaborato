clear functions;
der = cmpFrames('DroppedObjects', 'Seq1', 'RGB', 358);
threshold = calculateThreshold(der);
lowMotionIndex = lowMotionFrames(der, threshold);
minimumIndex = getMinimumIndexPerRegion(lowMotionIndex, der);