function [t,x1]=TMCPI(gamma,p,m,dp,dm,fl,theta)
tspan=[0:0.01:5]; options=odeset(); n=length(m(0)); x0=[theta;2*ones(4*n+2,1)];
warning off

% ZNN solutions
tic
[t,x1]=ode15s(@ZNN,tspan,x0,options,gamma,p,m,dp,dm,fl,theta);
toc
for i=1:n
subplot(n,1,i);plot(t,x1(:,i),'Color',[0.4940 0.1840 0.5560]);hold on
ylabel(['\eta_{',num2str(i),'}(t)']);
end

% LVI-PDNN solutions
tic
[t,x2]=ode15s(@LVIPDNN,t,x0(1:n+1),options,gamma,p,m,fl,theta);
toc
for i=1:n
subplot(n,1,i);plot(t,x2(:,i),'-.','Color',[0.4660 0.6740 0.1880]);hold on
end

% S-LVI-PDNN solutions
if n<10
tic
[t,x3]=ode15s(@SLVIPDNN,t,x0(1:n+1),options,gamma,p,m,fl,theta);
toc
for i=1:n
subplot(n,1,i);plot(t,x3(:,i),'--','Color',[0.3010 0.7450 0.9330]);hold on
end
end

% linprog solutions
options1=optimset('Display','off');
tot=length(t);xth=zeros(n,tot);fth=zeros(tot,1);
tic
for i=1:tot
[xi_minus,xi_plus,~,J,A,q,d,b]=problem(t(i),p,m,fl,theta);
try
[xth(:,i),fth(i)]=linprog(q,A,b,J,d,xi_minus,xi_plus,theta,options1);
catch
xth(:,i)=zeros(n,1);
end
end
toc
for i=1:n
subplot(n,1,i);plot(t,xth(i,:),':','Color',[0.9290 0.6940 0.1250]);hold on
end

xlabel('Time')
if n<10
legend('ZNN','LVI-PDNN','S-LVI-PDNN','${\tt linprog}$','Interpreter','latex')
else
legend('ZNN','LVI-PDNN','${\tt linprog}$','Interpreter','latex')
end
hold off

kt=zeros(tot,1); kt1=kt; kt2=kt; kt3=kt; nerr2=kt; nerr1=kt; 
kexp1=kt; kexp2=kt; kexp0=kt; kexp3=kt; kexp4=kt;
err2=x2(:,1:n)'-xth; err1=x1(:,1:n)'-xth; 
if n<10
err3=x3(:,1:n)'-xth; nerr3=nerr2;
end
for i=1:tot
om=oomega(t(i));pom=p(om*t(i));mom=m(om*t(i));
kt(i)=pom'*x2(i,1:n)';
kt1(i)=pom'*x1(i,1:n)';
kt2(i)=pom'*theta;
kexp0(i)=x1(i,1:n)*mom;
kexp1(i)=x2(i,1:n)*mom;
kexp2(i)=xth(:,i)'*mom;
kexp3(i)=theta'*mom;
nerr2(i)=norm(err2(:,i),2);
nerr1(i)=norm(err1(:,i),2);
if n<10
kt3(i)=pom'*x3(i,1:n)';
kexp4(i)=x3(i,1:n)*mom;
nerr3(i)=norm(err3(:,i),2);
end
end

figure
plot(t,kt2,'Color',[0.8500 0.3250 0.0980]);hold on
plot(t,kt1,'Color',[0.4940 0.1840 0.5560]);
plot(t,kt,'-.','Color',[0.4660 0.6740 0.1880]);
if n<10
plot(t,kt3,'--','Color',[0.3010 0.7450 0.9330]);
end
plot(t,fth,':','Color',[0.9290 0.6940 0.1250])
xlabel('Time')
ylabel('Portfolio Insurance')
xticklabels({'1/5','3/6','1/7','1/8','3/9','1/10'});
if n<10
legend('$\theta$','ZNN','LVI-PDNN','S-LVI-PDNN','${\tt linprog}$','Interpreter','latex');
else
legend('$\theta$','ZNN','LVI-PDNN','${\tt linprog}$','Interpreter','latex');
end
hold off

figure
plot([t(1) t(end)],[fl fl],'Color',[0 0.4470 0.7410]);hold on
plot(t,kexp3,'Color',[0.8500 0.3250 0.0980]);
plot(t,kexp0,'Color',[0.4940 0.1840 0.5560])
plot(t,kexp1,'-.','Color',[0.4660 0.6740 0.1880])
if n<10
plot(t,kexp4,'--','Color',[0.3010 0.7450 0.9330])
end
plot(t,kexp2,':','Color',[0.9290 0.6940 0.1250])
xlabel('Time')
ylabel('Portfolio Payoff')
if n<10
legend('Floor','$\theta$','ZNN','LVI-PDNN','S-LVI-PDNN','${\tt linprog}$','Interpreter','latex')
else
legend('Floor','$\theta$','ZNN','LVI-PDNN','${\tt linprog}$','Interpreter','latex')
end
xticklabels({'1/5','3/6','1/7','1/8','3/9','1/10'});
hold off

figure
if n<10
semilogy(t,nerr3,':','Color',[0.3010 0.7450 0.9330]);hold on
end
semilogy(t,nerr2,'Color',[0.4660 0.6740 0.1880]); hold on
semilogy(t,nerr1,'Color',[0.4940 0.1840 0.5560]);
if n<10
legend('$|\!|\phi_\mathrm{S-LVI-PDNN}(t)-\phi_{\tt linprog}(t)|\!|^2_2$',...
    '$|\!|\phi_\mathrm{LVI-PDNN}(t)-\phi_{\tt linprog}(t)|\!|^2_2$',...
    '$|\!|\phi_\mathrm{ZNN}(t)-\phi_{\tt linprog}(t)|\!|^2_2$','Interpreter','latex');
else
legend('$|\!|\phi_\mathrm{LVI-PDNN}(t)-\phi_{\tt linprog}(t)|\!|^2_2$',...
    '$|\!|\phi_\mathrm{ZNN}(t)-\phi_{\tt linprog}(t)|\!|^2_2$','Interpreter','latex');
end
ylabel('Error');xlabel('Time');hold off