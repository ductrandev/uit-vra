% compare query vector (for query images) with all vectors (representing
% for all image in dataset) and get ranked result using COSIN similarity.

function ranked_list =  get_ranked_result(query_vector, db_size)

    load('imgvectors.mat');
    ranked_list = zeros([2 db_size]);
    nRow = size(imgvectors,1);

    for i = 1:nRow
        u = query_vector;
        v = imgvectors(i,:);
        ranked_list(1, i) = i;
        
        % calculate COSIN similarity
        ranked_list(2, i) = dot(u,v)/(norm(u,2)*norm(v,2));
    end
end