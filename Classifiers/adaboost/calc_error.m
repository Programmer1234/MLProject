function [ error ] = calc_error( labels_vec, predicted_labels_vec, weights_vec )
%CALC_ERROR.

error_vec = (labels_vec ~= predicted_labels_vec);
weighted_vec = error_vec .* weights_vec;

error = sum(weighted_vec);

end

