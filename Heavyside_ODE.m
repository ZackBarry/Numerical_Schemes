% Note that we are not actually using the Heavyside graph - it is not a
% function at x=0.  Instead, we use {(x,0) for x<0}U{(x,1) for x>=0}.

h=0.1;  % time step
t=[0:h:10];   % time grid

g=@(u) u;   % for heavyside (A)
f=@(t) sin(t)-0.5;  % for du/dt=A+f(t)

u=zeros(1,length(t)); % initialize u solution vector
du=zeros(1,length(t)-1); % du is calculated for previous u value
tdu=t(1:length(t)-1);    %    in the loop below. no reason to have
                         %    du(length(t)) value as it wont be used
                         
u(1)=-0.25;    % initial value

for i=2:length(t)
    % t(1)=u(1), so we move to t(2),u(2)
    if u(i-1)<0
        du(i-1)=f(t(i-1));
        u(i)=u(i-1)+h*du(i-1);
    else du(i-1)=1+f(t(i-1));   % see note at beginning of code
        u(i)=u(i-1)+h*du(i-1);
    end
end

sol=zeros(1,length(t)); 

for i=1:length(t)
    u1=u(i);
    if i==1
        u0=u(i);
        a=0;
    else u0=u(i-1);
    end
    if sign(u1)-sign(u0)>0
        a=-t(i);
    else if sign(u1)-sign(u0)<0
        a=t(i);
        end
    end
    if u(i)<0
        sol(i)=-cos(t(i))-0.5*t(i)+u(1)+1+a;  % F(t)+u_0-F(0)+c
    else sol(i)=-cos(t(i))-0.5*t(i)+t(i)+u(1)+1+a;
    end
end

figure
plot(t,u,'r',tdu,du,'k',t,sol,'--')
    