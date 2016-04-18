function sum1 = sumprec(nums2sum, dim)

%    sumprec   pairwise summation of elements in a column or a raw of a
%              matrix
%
%       sum1 = sumprec(nums2sum, dim)
%
%       Input arguments:
%         nums2sum      - matrix containing the numbers to be summed 
%                       
%         dim           - Determines the type of the addition 
%                         dim = 1 : adds elements in a column
%                         dim = 2 : adds elements in a row
%                         In case a row or a column vector is given
%                          as input, the algorithm recognizes dim 
%                          automatically

% Written by Balázs Renczes
% $Id: sumprec.m,v 1.0 12-Oct-2015 17:42 $
% Copyright (c) 2016 by Balázs Renczes
% All rights reserved.




if nargin == 1
    
    if size(nums2sum,1) ==1, dim = 2; else dim =1; end
    
else
    if (dim ~=1 & dim ~= 2), error('Dimension should be 1 for row summation and 2 for column summation!'); end
    
end

input = nums2sum;


if dim == 1, a = size(nums2sum,1); else a = size(nums2sum,2); end

exponent_in = ceil(log2(a));
vector = input;

for i = 1:exponent_in
    
    if dim == 1
        if mod(a,2) ==0
            vector = vector(1:2:end,:) + vector(2:2:end,:);
        else
            vector = [vector(end,:); vector(1:2:end-2,:) + vector(2:2:end-1,:)];
        end
    else
        if mod(a,2) ==0
        vector = vector(:,1:2:end) + vector(:,2:2:end);
        else 
        vector = [vector(:,end) vector(:,1:2:end-2) + vector(:,2:2:end-1)];
        end
    end
    a = ceil(a/2);
end

sum1 = vector;

if (size(nums2sum,1)) == 1, sum1 = sum1'; end


end