clear
folderName = 'DroppedObjects';
sequences = {'Seq1', 'Seq2', 'Seq3'};
imgType = {'RGB', 'depth'};
imgNumber = [358, 464, 529];

% der = cmpFrames(folderName, sequences{1}, imgType{1}, imgNumber(1));
% threshold = calculateThreshold(der);
% lowMotionIndex = lowMotionFrames(der, threshold);
% minimumIndex = getMinimumIndexPerRegion(lowMotionIndex, der);
minimumIndex = [112, 294];
[keypointVector, descriptorsVector] = getFrameKeypoint(folderName, sequences{1}, imgType{1}, minimumIndex);


for i = 1:length(minimumIndex)-1
    im1 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i)),'.png'));
    im2 = imread(strcat(folderName,'/', sequences{1},'/',imgType{2},'/',num2str(minimumIndex(i + 1)),'.png'));    
    
    %keypointVector{1}(1:2,1) = Rot*keypointVector{1}(1:2,1)' + repmat(Trans,1,length(keypointVector{1}(1:2,1)'));
    [planarKeyPoints1, planarDescriptors1] = getRobustKeypoints(im1,keypointVector, descriptorsVector, i);
    [planarKeyPoints2, planarDescriptors2] = getRobustKeypoints(im2,keypointVector, descriptorsVector, i + 1);
    [H, matches] = ransacMatching(planarKeyPoints1, planarDescriptors1, planarKeyPoints2, planarDescriptors2);
 
    [X1, X2] = getPoints(planarKeyPoints1, planarKeyPoints2);
    
     X1translated = X1 * H;
    [R, T] = icp(X2', X1translated');
    X1aligned = R*X1translated' + repmat(T,1,length(X1translated'));
    X1aligned = X1aligned';
    
    im2RGB = imread(strcat(folderName,'/', sequences{1},'/',imgType{1},'/',num2str(minimumIndex(2)),'.png'));
    im1RGB = imread(strcat(folderName,'/', sequences{1},'/',imgType{1},'/',num2str(minimumIndex(1)),'.png'));

 % PLOT dei keypoint del secondo frame che non hanno corrispondenze con
 % quelli del primo (tra questi ci sono quelli di tazzina e uomo, ma ce ne
 % sono molti altri).
%       imagesc(im2RGB);
%       hold on;
%       differences =  planarKeyPoints2;
%       differences(:,matches(2,:)) = [];
%       plot(planarKeyPoints2(1,:),planarKeyPoints2(2,:),'o');
  
%  PLOT dei keypoint matchati   
    figure;
          imagesc(im2RGB);
          hold on;
     plot(X1aligned(:,1), X1aligned(:,2),'o');
    hold on;
    plot(X2(:,1),X2(:,2),'r+'); 
  
end



