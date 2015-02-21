function [train_data, train_labels, test_data, test_labels] = parse_input(extracted_train, extracted_test)

train_data = extracted_train;
train_data(:, 101, :) = [];
train_labels = squeeze(extracted_train(:, 101, :));

test_data = extracted_test;
test_data(:, 101, :) = [];
test_labels = squeeze(extracted_test(:, 101, :));

% Sanity check that we didn't make a mistake extracting the data
assert (min(min(test_labels)) == max(max(test_labels)));
assert (min(min(test_labels)) == -1);

end

