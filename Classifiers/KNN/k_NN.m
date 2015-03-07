function [ k_nearest_neigbours_indices_matrix ] = k_NN( train_set, test_set, k)
% K_NN.
% Receives train_set, and test_set.
% Returns a matrix in which for each sample in the train_set, corresponds a
% column in the matrix, in which reside the K samples from the 
% training set, that are the closest to the sample from the train_set.
% (The samples themselved are not returned in that matrix, but thier index in the train_set)

% Calculate the distance of each vector in the test_set, against all of
% the vectors in the training_set using Euclidean distance.
% If the training_set dimensions are of mx X n, and the test_set dimensions
% are of my X n then the dimensions of D are of mx X my.
% D[i,j] = the Euclidean distance of the i'th row in the training set, and
% the j'th row in the test_set.
% D[:, j] = Is a column of all the distances of the training set from the
% j'th vector in the test_set.

SNP_dist_func = @(XI,XJ)( sum( repmat(XI, size(XJ,1), 1) ~= XJ, 2) );

D = pdist2(train_set, test_set , SNP_dist_func);
[~ , permutation] = sort(D);

k_nearest_neigbours_indices_matrix = permutation(1:k, :);
end