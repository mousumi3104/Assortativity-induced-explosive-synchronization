function explo=explosive_adaptive_function(time_x)

global ntrans N tf 
mini=zeros(N,1);maxi=zeros(N,1);
for u=1:N    
    burst=[];
    x1=time_x(:,u); 
for t=1:(tf-ntrans)-1
    if (x1(t)-0.3)<0 && (x1(t+1)-0.3)>0
        if abs(x1(t)-0.3)<abs(x1(t)-0.3)
            burst=[burst,t];
        else
            burst=[burst,t+1];
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
burst=ntrans+burst;
mini(u)=min(burst); maxi(u)=max(burst);
maxx{u}=burst;
end

MM=max(mini);
NN=min(maxi);
time=MM:NN;
phi=zeros(length(time),N);
for u=1:N 
    
h=maxx{u};
for v=1:length(h)
    if time(1)>=h(v)   %%from where to start calculation
       p1=v; 
    end
end
for v=length(h):-1:1
    if time(end)<=h(v)
        p2=v;
    end
end
b=h(p1:p2);
p=2;
     for t=1:1:length(time)
         if time(t)<=b(p)
          phi(t,u)=2*pi*(time(t)-b(p-1))/(b(p)-b(p-1));
         else
             p=p+1;
            phi(t,u)=2*pi*(time(t)-b(p-1))/(b(p)-b(p-1));
         end  
     end 
   
end
exp_phi=exp(1i.*phi);
final_r=zeros(length(time),1);   
r=zeros(length(time)-1,1);

    for t=1:length(time)
        final_r(t)=sum(exp_phi(t,:)/N);
        
        r(t)=sqrt((real(final_r(t)))^2+(imag(final_r(t)))^2);    
    end 
    
summ1=sum(r)/(length(time));

 explo=summ1  

