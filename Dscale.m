%Script for checking the conditioning of system matrix D

% $Id: dscale.m,v 1.0 17-Apr-2016 $
% All rights reserved.


A=1200;   %Parameters of matrix D
B=1650;
C=2048;
f=1/64;
N=50000;
K=sqrt(A^2+B^2);
lambda=K*N*pi;  %Scaling factor
D1=[cos(2*pi*f*[1:N]'),sin(2*pi*f*[1:N]'),ones(N,1),2*pi*[1:N]'.*(-A*sin(2*pi*f*[1:N]')+B*cos(2*pi*f*[1:N]'))];  %original matrix
D2=[cos(2*pi*f*[1:N]'),sin(2*pi*f*[1:N]'),ones(N,1),1/lambda*2*pi*[1:N]'.*(-A*sin(2*pi*f*[1:N]')+B*cos(2*pi*f*[1:N]'))];  %scaled matrix
condD1=cond(D1);condD2=cond(D2);

%Check whether the optimal scaling was found

lv=lambda/5:lambda/30:5*lambda;
c=zeros(size(lv)); ii=0; cmin=inf; lmin=inf; cm=c; cminm=inf; lminm=inf;
for la=lv
    ii=ii+1;

    D2=[cos(2*pi*f*[1:N]'),sin(2*pi*f*[1:N]'),ones(N,1),1/la*2*pi*[1:N]'.*(-A*sin(2*pi*f*[1:N]')+B*cos(2*pi*f*[1:N]'))];
    c(ii)=cond(D2);
    if c(ii)<cmin, cmin=c(ii); lmin=la; end

end

%lambdamod denotes a multiplication factor that is needed to get the
%optimal scaling factor
figure(1), plot(lv,c), title('Cond(D2)'), xlabel(sprintf('cmin=%.3g, lambdamod=%.3g',cmin,lmin/lambda)), shg

