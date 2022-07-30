function [p,m,dp,dm]=dataprep(X,s)
% PI prices

[tot1,tot2]=size(X);
P=zeros(tot1-s,tot2);
for i=1:tot1-s
    r=X(i:s+i-1,:);
    P(i,:)=2+1e3*var(r./max(r));
end


dP=zeros(tot1-s,tot2); dX=zeros(tot1-s,tot2);
for i=1:tot1-s
    if i~=tot1-s
        dX(i,:)=X(i+1,:)-X(i,:); dP(i,:)=P(i+1,:)-P(i,:);
    else
        dX(i,:)=dX(i-1,:); dP(i,:)=dP(i-1,:);
    end
end
m=@(x)linots(X(s+1:end,:),x)'; p=@(x)linots(P,x)';
dm=@(x)linots(dX,x)'; dp=@(x)linots(dP,x)';

%p=@(x)pchinots(P,x)'; m=@(x)pchinots(X(s+1:end,:),x)';
%dp=@(x)pchinots(dP,x)'; dm=@(x)pchinots(dX,x)';
%spl1 = sp(P); p = @(x)splinots(P,spl1,x)'; spl = sp(X(s+1:end,:)); m = @(x)splinots(X(s+1:end,:),spl,x)';
%dspl1 = sp(dP); dp = @(x)splinots(dP,dspl1,x)'; dspl = sp(dX); dm = @(x)splinots(dX,dspl,x)';