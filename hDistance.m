function H = hDistance(mat1, mat2)
% HDISTANCE Compute the Hellinger distance between two distributions.
%
% H = HDISTANCE(mat1, mat2) estimates the Hellinger distance between the
% empirical distributions of mat1 and mat2 using a shared histogram with
% 200 bins spanning the joint data range.
%
% Input
%   mat1, mat2 : Vectors or arrays of numeric values (Inf values are excluded)
%
% Output
%   H : Hellinger distance in [0, 1]; 0 = identical distributions,
%       1 = completely non-overlapping distributions

nbin = 200;
min_bin = min( min(mat1(~isinf(mat1))), min(mat2(~isinf(mat2))) );
max_bin = max( max(mat1(~isinf(mat1))), max(mat2(~isinf(mat2))) );
bin_step = (max_bin - min_bin) / nbin;

bin = min_bin:bin_step:max_bin;

mat1_pdf = histcounts(mat1, bin);
mat2_pdf = histcounts(mat2, bin);

H = sqrt(sum( ( sqrt(mat2_pdf/sum(mat2_pdf)) ...
    - sqrt(mat1_pdf/sum(mat1_pdf)) ).^2) ) ./ sqrt(2);
end