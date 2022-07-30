function output=Poweromega(y,s_minus,s_plus)
k=size(y,1);
output=zeros(k,1);
for i=1:k
if y(i)<s_minus(i)
    output(i)=s_minus(i);
elseif y(i)>s_plus(i)
    output(i)=s_plus(i);
else
    output(i)=y(i);
end
end