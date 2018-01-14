function Recognition004_Digits()
    imgTrainAll = loadMNISTImages('./train-images.idx3-ubyte');
    lblTrainAll = loadMNISTLabels('./train-labels.idx1-ubyte');
    imgTestAll = loadMNISTImages('./t10k-images.idx3-ubyte');
    lblTestAll = loadMNISTLabels('./t10k-labels.idx1-ubyte');
    
    nTrainImages = size(imgTrainAll,2);
    nNumber = randi([1 nTrainImages]); 
    figure;
    img = imgTrainAll(:,nNumber);
    img2D = reshape(img,28,28);
    strLabelImage = num2str(lblTrainAll(nNumber));
    strLabelImage = [strLabelImage,' (',num2str(nNumber),')'];
    imshow(img2D);
    title(strLabelImage);
    
    nTestImgs = size(imgTestAll,2);
    nNumberTest = randi([1 nTestImgs]); 
    figure;
    imgTest = imgTestAll(:,nNumberTest);
    img2D = reshape(imgTest,28,28);
    strLabelImageTest = num2str(lblTestAll(nNumberTest));
    strLabelImageTest = [strLabelImageTest,' (',num2str(nNumberTest),')'];
    imshow(img2D);
    title(strLabelImageTest);
end

