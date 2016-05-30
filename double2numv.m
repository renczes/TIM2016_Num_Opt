%DOUBLE2NUMV  Double to bitwise representation 

% Written by Istvan Kollar
% $Id: double2numv.m,v 1.0 17-Apr-2016 $
% Copyright (c) 2016 by Istvan Kollar
% All rights reserved.


function nv=double2numv(x,b,M)


if nargin<2, b=[]; end; if isempty(b), b=22; end
if abs(rem(b,1))~=0, error('b is not integer'), end
if ((b<1)|(b>26)), error(sprintf('b = %.0f is not allowed',b)), end
if nargin<3, M=[]; end; if isempty(M), M=3; end
if abs(rem(M,1))~=0, error('M is not integer'), end
if ((M<1)|(M>10)), error(sprintf('M = %.0f is not allowed',M)), end

if size(x,1) == 1, x = x'; end

numbers = size(x);
numbers = numbers(1);

nv=zeros(numbers,M);
sig = zeros(numbers,1);
multiplyer = zeros(numbers,1);

xin=x;

idx = find(x ~= 0);

ch=floor(log2(abs(x(idx)))); x(idx)=x(idx)./2.^ch;
sig(idx)=sign(x(idx)); x(idx)=abs(x(idx));
for ii=1:M
	for jj=1:b
		idx2 = find(x>=1);
            nv(idx2,ii)=nv(idx2,ii)+2^(-(ii-1)*b-jj+1); x(idx2)=x(idx2)-1;
		
        x = x*2;
	end
end


if (sum(abs(x)) ~= 0), error('Remaining value'), end

sig2 = sig * ones(1,M);

multiplyer(idx) = 2.^ch;

multiplyer = multiplyer * ones(1,M);
nv=sig2.*nv.*multiplyer;

if numv2double(nv)~=xin, error('value changed'), end

