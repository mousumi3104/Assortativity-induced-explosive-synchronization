clear all
clc

global N tf ntrans    %n should be in function
tf=50000;ntrans=30000;
N=500; m0=4;m=3;  %scalefree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
epsilon_for=0:0.01:0.25;
epsilon_back=0.25:-0.01:0.001;
epsilon=[epsilon_for epsilon_back] ;

disp=0.035;             %dissimilitude parameter (0.03+\delta)
assort=0.25;            %assortativity coefficient

time_x=zeros(tf-ntrans,N);

rr=zeros(length(epsilon),1);

A1=scalefree(N,m0,m);
%load('coupling_matrix_final500.mat');    %adjacency matrix
    
x=rand(N,1);y=rand(N,1);       %initial condition
C=scalefree_assort(A1,assort,N);
kkk=0.03+(disp-0.03)*rand(N,1);
         
for d=1:length(epsilon)  
    d
    ep=epsilon(d)./sum(C');
   
for t=1:tf

fx=(x.^2).*exp(y-x)+kkk+ep'.*(C*x-x.*(sum(C'))');  %time series
fy=0.89*y-0.6*x+0.28;
x=fx;
y=fy;

if t>ntrans
    time_x(t-ntrans,:)=x;
end
end

rr(d)=explosive_adaptive_function(time_x);  %order parameter
end

plot(epsilon,rr,'o-','Linewidth',2);
axis square