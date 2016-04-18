function phases =  phase_eval_prec(f_rel,timevect,mode)

%    phase_eval_prec   Evaluates the the phases for cosine and sine
%                      functions with increased precision
%                      between -pi and pi
%
%       phases=phase_eval_prec(f_rel,timevect,mode)
%
%       Input arguments:
%         f_rel         - relative frequency of the input signal 
%                       (equals to f_signal / f_sampling)
%         timevect:     - ordinal number of the time instant. 
%                       Instantaneous phase vector can be given as: 
%                       2*pi*f_rel*timevect    
%         
%       Optional parameters:
%         mode  - single or double precision representation can be chosen
%               (default value: double)
%
%       Output arguments:
%         phases - phase values between -pi an pi, evaluated with enhanced
%                precision

% Written by Balázs Renczes
% $Id: phase_eval_prec.m,v 1.0 11-Sept-2015 14:26 $
% Copyright (c) 2016 by Balázs Renczes
% All rights reserved.


if nargin == 2, mode = 'double'; end

if size(timevect,2)>1, timevect = timevect'; end

if strcmp('single', mode) == 1
    
    b = 11;
    M = 3;
    f = single( double2numv(f_rel, b, M));
    
    if max(timevect) > 2^b
        times = single(double2numv(timevect,b,2));
    else
        times = single(timevect);
    end
    
end

if strcmp('double', mode) == 1
    
    b = 22;
    M = 3;
    f = double2numv(f_rel, b, M);
    
     if max(timevect) > 2^b
        times = double2numv(timevect,b,2);
    else
        times = timevect;
     end
end

   phases = conv2(f(1,:), times);

if size(f,1) > 1
    phases2 = conv2(f(2,:), times);
end

phases(:,1:2) = rem(phases(:,1:2),1);

index = find(phases(:,1)+phases(:,2)>0.5);
phases (index,1) = phases(index,1) - 1;


if size(f,1) > 1
phases2(:,1:2) = rem(phases2(:,1:2),1);
end

phases = sum(phases,2);

if size(f,1) > 1
phases2 = sum(phases2,2);
end

if size(f,1) > 1
phases = phases + phases2;
end

phases = 2*pi*phases;

end