function [W,J,A,q,d,b,z]=problem2(t,pr,X,fl,theta,z)
om=oomega(t);
n=length(theta);
W=zeros(n);
J=zeros(1,n);
d=0;
q=pr(om*t); %insurance prices
r=-X(om*t); %marketed space

if nargin==5
payoff=r'*theta;
rp=min(payoff,-fl);
if rp==payoff
    z=1;
else
    z=2;
end
xi_plus=payoff./r;
xi_minus=zeros(n,1);
I=eye(n);
A=[r';I;-I];
b=[rp;xi_plus;xi_minus];
else
I=zeros(2*n,n);
A=[r';I];
if z==1
    payoff=r'*theta;
    rp=payoff;
else
    rp=0;
end
xi=zeros(2*n,1);
b=[rp;xi];
end
