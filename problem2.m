function [W,J,A,q,d,b,z]=problem2(t,pr,X,c,fl,theta,z)
om=oomega(t);
n=length(theta);
W=zeros(n);
J=zeros(1,n);
d=0;
q=pr(om*t); %insurance prices
r=-X(om*t); %marketed space
xi_plus=c(om*t);
xi_minus=zeros(n,1);

if nargin==6
payoff=r'*theta;
rp=min(payoff,-fl);
if rp==payoff
    z=1;
else
    z=2;
end
I=eye(n);
A=[r';I;-I];
else
I=zeros(2*n,n);
A=[r';I];
if z==1
    payoff=r'*theta;
    rp=payoff;
else
    rp=0;
end
end
b=[rp;xi_plus;xi_minus];
