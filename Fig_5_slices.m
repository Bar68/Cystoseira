function [C,T,U,Z] = Fig_5_slices

tspan = [0 50];
nlayers = 6;
ngrid = 100;  % 100

U =linspace(.05,.5,nlayers);   % .2
x=linspace(0,.3,ngrid);  % .2
y =linspace(0,.9,ngrid);    % 1
[C,T] = meshgrid(x,y);

[m,n] = size(C);

Z = zeros(m,n,nlayers);

l=40;
C0=3;
T0=2;
beta=0.1;
phi=0.2;
r=1;
R=1.5;
Acu=1;
Atu=1;
Bcu=0.1;
Btu=0.6;
Du=3.5;
Ctu=0.9;
Ccu=0.9;

opt=odeset('RelTol',1e-10,'AbsTol',1e-13);
for j = 1:nlayers
    index=1;
for a=1:ngrid
    for b=1:ngrid

    y0=[C(a,b) T(a,b) U(j)];

[t,y] = ode45(@(t,y)  att_esp_r_s(y,R,T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu), tspan, y0,opt);

if y(end,3)>.0001%(abs(max(bif_3)-min(bif_3))>0.0001)
Z(a,b,j) = 1; % blue
elseif (y(end,1)>0.0001)
Z(a,b,j) = 2; % green
else
Z(a,b,j) = 3; % red
end
index = index+1;
    end
end
end
end
