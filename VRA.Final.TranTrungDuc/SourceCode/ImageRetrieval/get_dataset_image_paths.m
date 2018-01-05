% get paths of all the images in dataset
function [ dataset_image_paths ] = get_dataset_image_paths( data_path )
    files = dir(fullfile(data_path,'*.jpg'));
    num_files = numel(files);
    dataset_image_paths = cell(num_files, 1);
    
    for i = 1 : num_files
        image_file_path = fullfile(data_path, files(i).name);
        dataset_image_paths{i} = image_file_path;
    end
   
end
