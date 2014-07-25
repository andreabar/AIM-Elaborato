clear
t = cputime;
folderName = 'DroppedObjects';
sequences = {'Seq1', 'Seq2', 'Seq3'};
imgType = {'RGB', 'depth'};
imgNumber = [358, 464, 529];
der = cmpFrames(folderName, sequences{1}, imgType{1}, imgNumber(1));
threshold = calculateThreshold(der);
lowMotionIndex = lowMotionFrames(der, threshold);
minimumIndex = getMinimumIndexPerRegion(lowMotionIndex, der);
[keypointFrames, descriptorsFrames] = getFrameKeypoint(folderName, sequences{1}, imgType{1}, minimumIndex);
minimumIndex
e = cputime - t
[keypointVector, descriptorsVector] = getFrameKeypoint(folderName, sequences{1}, imgType{1}, minimumIndex);
[strongKeypointVector, strongDescriptorsVector] = extractStrongKeypoint(folderName, sequences{1}, imgType{2}, minimumIndex, keypointVector, descriptorsVector);
