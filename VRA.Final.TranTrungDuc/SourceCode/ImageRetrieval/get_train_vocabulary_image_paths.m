% get paths of images which are used for building visual vocabulary
function [ train_image_paths ] = get_train_vocabulary_image_paths( data_path, number_of_random_images )
    files = dir(fullfile(data_path,'*.jpg'));
    num_files = numel(files);

    rand_image_index = randperm(num_files, number_of_random_images);
    train_image_paths = cell(number_of_random_images, 1);

    for i = 1 : length(rand_image_index)
        k = rand_image_index(i);
        image_file_path = fullfile(data_path, files(k).name);
        train_image_paths{i} = image_file_path;
    end
   
end

