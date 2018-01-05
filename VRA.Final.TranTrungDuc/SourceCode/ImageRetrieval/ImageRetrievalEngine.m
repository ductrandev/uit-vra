% class Engine to perform all necessary Image Retrieval Task.
classdef ImageRetrievalEngine    
    properties
        data_path;
        vl_feat_toolbox;
        vocab_size;
        db_size;
    end
    
    methods
      
      function obj = ImageRetrievalEngine(vl_feat_path, dt_path, vc_size, db_sz)
            if  ischar(vl_feat_path)&& ischar(dt_path) && isnumeric(vc_size) && isnumeric(db_sz)
                
               obj.vl_feat_toolbox = vl_feat_path;
               obj.data_path = dt_path;
               obj.vocab_size = vc_size;
               obj.db_size = db_sz;
               
               run(obj.vl_feat_toolbox);
            else
               error('Incorrect config values')
            end
      end
      
      function build_visual_vocabulary(obj, number_of_random_images)
          
        train_vocab_image_paths = get_train_vocabulary_image_paths(obj.data_path, number_of_random_images);

        %build visual vocabulary
        if ~exist('vocab.mat', 'file')
            fprintf('No existing visual word vocabulary found. Computing one from training images\n')
            vocab = build_vocabulary(train_vocab_image_paths, obj.vocab_size);
            save('vocab.mat', 'vocab')
        end
        
      end
      
      function build_db_images_vectors(obj)
        dataset_image_paths = get_dataset_image_paths(obj.data_path);
        %build image vectors
        if ~exist('imgvectors.mat', 'file')
            [imgvectors, vocab_frequencies_in_DB] = build_vectors_for_images_in_dataset(dataset_image_paths);
            save('imgvectors.mat', 'imgvectors');
            save('vocab_frequency.mat', 'vocab_frequencies_in_DB');
        end
        
      end
      
      function descending_ranked_list = get_ranked_result_for_query (obj, path_of_query_image)
        
        query_vector = get_query_vector(path_of_query_image, obj.db_size);

        %get ranked list result
        ranked_list =  get_ranked_result(query_vector, obj.db_size);

        [~,I]=sort(ranked_list(2,:), 'descend');
        descending_ranked_list = ranked_list(:,I);
        
      end

    end
    
end

