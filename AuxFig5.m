tspan = [0 100];
K_1 = 30;
K_2 = 30;
K_3  = 30;

C_in=linspace(0,.3,K_1);  % .5
T_in=linspace(0,.96,K_2);    % 1
U_in=linspace(0,.05,K_3);   % 1
[C,T,U] = meshgrid(C_in,T_in,U_in);
Z = zeros(size(C));
l=40;

y_fin=zeros(K_1*K_2*K_3,3);
%y_C=zeros(K_1,K_2,K_3);

% idea: prendo più condizioni iniziali e disegno più soluzioni per capire
% se esistono "zone di influenza"

%Definizione dei parametri
C0=3;
T0=2;
beta=0.1;
%phi=[0.8];
phi=0.2;
r=1;
%R=[1.56:-0.01:1.47];
R=1.5;
%R=0.5; %R=1.5;
Acu=1;
Atu=1;
Bcu=0.1;
Btu=0.6;
%Du=[1.5];
Du=3.5;

%[m,n]=size(phi);
Ctu=0.9;
Ccu=0.9;
index=1;
index2 = 1;
opt=odeset('RelTol',1e-10,'AbsTol',1e-13);

for a=1:K_1
    for b=1:K_2
        tic
        for c=1:K_2
    y0=[C(a,b,c) T(a,b,c) U(a,b,c)];
   % y_0(index,:)=y0;
[t,y] = ode45(@(t,y)  att_esp_r_s(y,R,T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu), tspan, y0,opt);
y_fin(index,:)=y(end,:);
%y0(index,:)=y0;
y0_col(index,:)=y0;
%    bif_3=y(end-l+1:end,3);
if y(end,3)>0.0001%(abs(max(bif_3)-min(bif_3))>0.0001)
Z(a,b,c) = 1; % blue
elseif (y(end,1)>0.0001)
Z(a,b,c) = 2; % green
else
Z(a,b,c) = 3; % red
end
index=index+1;
        end
index2=index2+1;
eltime = toc;
estime = eltime*(K_1*K_2-index2);
clc
disp(['step restanti =  ' num2str(K_1*K_2*K_3-index)])
disp(['tempo restante (min) =  ' num2str(estime/60,4)])
    end
end