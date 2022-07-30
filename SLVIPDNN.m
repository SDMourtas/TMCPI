function output=SLVIPDNN(t,x,gamma,p,m,fl,theta)
[xi_minus,xi_plus,W,J,A,q,d,b,omegabar]=problem(t,p,m,fl,theta);
[s_minus,s_plus,hta,pii]=inputs(xi_minus,xi_plus,W,J,A,q,d,b,omegabar);
output=gamma*(Poweromega(x-hta*x-pii,s_minus,s_plus)-x);