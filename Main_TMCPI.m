%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Source codes for the TMCPI problem (version 1.0)                 %
%                                                                   %
%  Developed in MATLAB R2021a                                       %
%                                                                   %
%  Author and programmer: S.D.Mourtas, V.N.Katsikis                 %
%                                                                   %
%   e-Mail: spirosmourtas@gmail.com, vaskatsikis@econ.uoa.gr,       %
%                                                                   %
%   Main paper: V.N.Kovalnogov, R.V.Fedorov, D.A.Generalov,         %
%               A.V.Chukalin, V.N.Katsikis, S.D.Mourtas, T.E.Simos, %
%               "Portfolio Insurance through Error-Correction Neural%
%               Networks", Mathematics, 10(18), 3335 (2022)         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear 
close all
clc

s=21;                     % number of delays for average matrix
X1=xlsread('market');     % stocks close prices (included delays)

% Example settings: n stocks market
% n: number of stocks without views 

n=3; fl=158;    % Example 1
%n=5; fl=465;    % Example 2
%n=10; fl=960;   % Example 3
%n=20; fl=1600;  % Example 4

X=X1(:,1:n);              % market space
theta=2*ones(n,1); % given portfolio
[p,m,c,dp,dm,dc]=dataprep(X,s,theta);

gamma=1e3; % NN design parameter
[t1,x1]=TMCPI(gamma,p,m,c,dp,dm,dc,fl,theta);
