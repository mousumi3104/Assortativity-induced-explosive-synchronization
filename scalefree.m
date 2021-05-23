 function matrix=scalefree(N,m0,m)

A1=zeros(N);
link=0;
for ii=1:m0
    for jj=ii+1:m0
         if jj~=ii
            A1(ii,jj)=1;
            A1(jj,ii)=1;
            link=link+2;
         end
    end
end
for ii=m0+1:N
    
   current_degree=0;
   b=1:(ii-1);
    
   while current_degree<m 
     
       jj=b(randperm(length(b),1));  %without replacemnet
       
       bb=sum(A1(jj,:))/link;
       
       random_number=rand;
      
       if (bb>random_number)
           A1(ii,jj)=1;
           A1(jj,ii)=1;
           link=link+2;
           b(b==jj)=[];   %%% remind it is not the position, it is value  
          
       end
       
       current_degree=sum(A1(ii,:));
       
   end
    
end
sum(sum(A1))/N
%degree of assortativity
M=sum(sum(A1));
sum1=0;sum2=0;sum3=0;
for i=1:N
    for ll=1:N
        if A1(i,ll)==1
           j=sum(A1(i,:));
           k=sum(A1(ll,:));
           sum1=sum1+j*k;
           sum2=sum2+(j+k)/2;
           sum3=sum3+(j^2+k^2)/2;
        end
    end
end

sum(sum(A1))/N

degree_assort=((sum1/M)-(sum2/M)^2)/((sum3/M)-(sum2/M)^2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure;hist(sum(A1),100)
matrix=A1;

