function output=ZNN(t,x,gamma,p,m,dp,dm,fl,theta)
[~,~,A,q,~,b,z]=problem2(t,p,m,fl,theta); n=length(m(t));
[~,~,dA,dq,~,db]=problem2(t,dp,dm,fl,theta,z);
lenb=length(b); KK=n+lenb; GG=KK+lenb;
X=x(1:n); K=x(n+1:KK); G=x(KK+1:GG);

E1=q+A'*K; dE1=-dq-dA'*K;
E2=A*X-b+G.*G; dE2=-dA*X+db;
E3=K.*G; dE3=zeros(lenb,1);

M=[zeros(n), A', zeros(n,lenb);...
    A, zeros(lenb), 2*diag(G);...
    zeros(lenb,n), diag(G), diag(K)];

Z=[E1;E2;E3]; dZ=[dE1;dE2;dE3];
output=pinv(M'*M)*M'*(-gamma*Z+dZ);