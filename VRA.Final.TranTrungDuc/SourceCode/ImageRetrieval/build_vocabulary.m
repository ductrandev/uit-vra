
% build visual vocabualry using SIFT features and k-Means clustering.
function vocab = build_vocabulary( image_paths, vocab_size )
images = cellfun(@imread, image_paths, 'UniformOutput', false);

[~, all_SIFT_features] = vl_dsift(single(rgb2gray(images{1})),'fast', 'step', 50);

for i = 2:(size(images,1))
    [~, SIFT_features] = vl_dsift(single(rgb2gray(images{i})),'fast', 'step', 50);
    all_SIFT_features = cat(2, all_SIFT_features, SIFT_features);
end

[vocab, ~] = vl_kmeans(single(all_SIFT_features), vocab_size);


end
