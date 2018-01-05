function displayResult(dataset_image_paths, descending_ranked_list )
    
    number_of_result = size(descending_ranked_list, 2);
     %read images in a cell array
    imgs = cell(number_of_result,1);
    for i = 1:number_of_result
        imgs{i} = imread( dataset_image_paths{descending_ranked_list(1,i)});
    end

    number_rows = round(number_of_result/2);
    %show them in subplots
    figure('Name', 'KET QUA TIM KIEM');
    for i=1:number_of_result
        subplot(number_rows,3,i);
        h = imshow(imgs{i}, 'InitialMag',100, 'Border','tight');
        
        similarityValue = ['Similarity: ',num2str(descending_ranked_list(2,i))];
        title(similarityValue);
        
        imagePath = dataset_image_paths{descending_ranked_list(1,i)};
        set(h, 'ButtonDownFcn',{@callback,i,imagePath,similarityValue})
    end

    %mouse-click callback function
    function callback(~,~,idx, imagePath, similarityValue)
        %show selected image in a new figure
        figure(2), imshow(imgs{idx})
        titleForImage = [imagePath, '; ', similarityValue];
        title(titleForImage)
    end

end

