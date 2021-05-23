function Coupling=scalefree_assort(A,prob,N)
%first check the degree
M=sum(sum(A));
sum1=0;sum2=0;sum3=0;
for i=1:N
    for ll=1:N
        if A(i,ll)==1
           j=sum(A(i,:));
           k=sum(A(ll,:));
           sum1=sum1+j*k;
           sum2=sum2+(j+k)/2;
           sum3=sum3+(j^2+k^2)/2;
        end
    end
end
degree_assort=((sum1/M)-(sum2/M)^2)/((sum3/M)-(sum2/M)^2);

if degree_assort>prob
    while degree_assort>=prob
        B=reshape(A,[N*N,1]); %reshape matrix
indexx=find(B);          % find the 1s
m=randsample(length(indexx),2);  %randomly chosen index of edge
s=(indexx(m));           % edges form B
co1=1+floor(s/N);  % nodes are connected to that edge
co2=mod(s,N);
for i=1:length(co2)
    if co2(i)==0
        co1(i)=co1(i)-1;
         co2(i)=N;
    end
end

node=[co1; co2] ;                %%% these are 4 nodes according as A
if length(unique(node))==4
summ=degree(graph(A),node);    

sorted_summ=unique(sort(summ));
ind=[];
for i=1:length(sorted_summ)
    ss=find(summ==sorted_summ(i));  %%%nodes are sorted over degree
    ind=[ind,ss'] ;   
end
node_final=(node(ind));

if A(node_final(1),node_final(4))~=1 && A(node_final(2),node_final(3))~=1
   % if prob>random
    A(co1(1),co2(1))=0;
    A(co2(1),co1(1))=0;
    A(co1(2),co2(2))=0;
    A(co2(2),co1(2))=0;            

A(node_final(1),node_final(4))=1;
A(node_final(4),node_final(1))=1;
A(node_final(2),node_final(3))=1;
A(node_final(3),node_final(2))=1;
end
end

M=sum(sum(A));
sum1=0;sum2=0;sum3=0;
for i=1:N
    for ll=1:N
        if A(i,ll)==1
           j=sum(A(i,:));
           k=sum(A(ll,:));
           sum1=sum1+j*k;
           sum2=sum2+(j+k)/2;
           sum3=sum3+(j^2+k^2)/2;
        end
    end
end

degree_assort=((sum1/M)-(sum2/M)^2)/((sum3/M)-(sum2/M)^2)
end
else        
        
while degree_assort<=prob
%random=rand;   % for probability case 

B=reshape(A,[N*N,1]); %reshape matrix
indexx=find(B);          % find the 1s
m=randsample(length(indexx),2);  %randomly chosen index of edge
s=(indexx(m));           % edges form B
co1=1+floor(s/N);  % nodes are connected to that edge
co2=mod(s,N);
for i=1:length(co2)
    if co2(i)==0
        co1(i)=co1(i)-1;
         co2(i)=N;
    end
end

node=[co1; co2] ;   %%% these are 4 nodes according as A
if length(unique(node))==4
summ=degree(graph(A),node);    

sorted_summ=unique(sort(summ));
ind=[];
for i=1:length(sorted_summ)
    ss=find(summ==sorted_summ(i));  %%%nodes are sorted over degree
    ind=[ind,ss'] ;   
end
node_final=(node(ind));    

if A(node_final(1),node_final(2))~=1 && A(node_final(3),node_final(4))~=1
   A(co1(1),co2(1))=0;
   A(co2(1),co1(1))=0;
   A(co1(2),co2(2))=0;
   A(co2(2),co1(2))=0;            

A(node_final(1),node_final(2))=1;
A(node_final(2),node_final(1))=1;
A(node_final(3),node_final(4))=1;
A(node_final(4),node_final(3))=1;
    end
end


M=sum(sum(A));     %   measure of degree of assortativity
sum1=0;sum2=0;sum3=0;
for i=1:N
    for ll=1:N
        if A(i,ll)==1
           j=sum(A(i,:));
           k=sum(A(ll,:));
           sum1=sum1+j*k;
           sum2=sum2+(j+k)/2;
           sum3=sum3+(j^2+k^2)/2;
        end
    end
end

degree_assort=((sum1/M)-(sum2/M)^2)/((sum3/M)-(sum2/M)^2)

end
end
Coupling=A;
end