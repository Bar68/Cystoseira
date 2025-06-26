%Studio dei bacini di influenza


close all
clear all

tspan = [0 7000];
K_1=10;
K_2=10;
K_3=10;
C_in=linspace(0.1,1,K_1);
T_in=linspace(0,1,K_2);
U_in=linspace(0,3,K_3);
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

opt=odeset('RelTol',1e-10,'AbsTol',1e-13);

prompt = 'Integrazione nel caso di ricci insaziabili (1) o nel caso di ricci saziabili (2)?';
x = input(prompt);
if (x==1)

      figure
for a=1:K_1
    for b=1:K_2
        for c=1:K_3
    y0=[C_in(a) T_in(b) U_in(c)];

[t,y] = ode45(@(t,y)  att_esp_r_i(y,R,T0,beta,Acu,phi,C0,r,Atu,Du,Ctu,Ccu), tspan, y0,opt);

%[t,y] = ode45(@(t,y)  att_esp_r_s_nv(y,R(i),T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu), tspan, y0,opt);
y_fin(index,:)=y(end,:);
y0_col(index,:)=y0;

if (y(end,3)>0.0001)
plot3(y0(1),y0(2),y0(3),'.b','Markersize',10)
y_C(a,b,c)=2; %convivenza delle tre specie
elseif (y(end,1)>0.2)
plot3(y0(1),y0(2),y0(3),'.g','Markersize',10)
y_C(a,b,c)=1; %U è assente, C e T convivono
else
    plot3(y0(1),y0(2),y0(3),'.r','Markersize',10)
    y_C(a,b,c)=0; %spariscono C e T
end
hold on

%plot3(y(end-1000:end,1),y(end-1000:end,2),y(end-1000:end,3),'.','Markersize',8)
%plot3(y(:,1),y(:,2),y(:,3),'-o')
%hold on
%title(['Phase space in case of $R$=',num2str(R(i))],'Interpreter','latex')
xlabel('Cystoseira')
ylabel('Turf')
zlabel('Urchins')
 
%axis([0 1 0 1 0 1])
 %   figure
%plot(t,y(:,1),'b',t,y(:,2),'r',t,y(:,3),'m')
%hold on

%legend('Cystoseira','Turf','Sea urchins')
%  title(['$\phi$=',num2str(phi(i))],'Interpreter','latex')
% title(['$R$=',num2str(R(i))],'Interpreter','latex')
index=index+1;
        end
    end
end
elseif (x==2)

        figure
for a=1:K_1
    for b=1:K_2
        for c=1:K_3
    y0=[C_in(a) T_in(b) U_in(c)]
   % y_0(index,:)=y0;
[t,y] = ode45(@(t,y)  att_esp_r_s(y,R,T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu), tspan, y0,opt);
y_fin(index,:)=y(end,:);
%y0(index,:)=y0;
y0_col(index,:)=y0;
%    bif_3=y(end-l+1:end,3);
if y(end,3)>0.0001%(abs(max(bif_3)-min(bif_3))>0.0001)
plot3(y0(1),y0(2),y0(3),'.b','Markersize',10)
elseif (y(end,1)>0.0001)
plot3(y0(1),y0(2),y0(3),'.g','Markersize',10)
else
    plot3(y0(1),y0(2),y0(3),'.r','Markersize',10)
end
hold on        
index=index+1;
%plot3(y(end-1000:end,1),y(end-1000:end,2),y(end-1000:end,3),'.','Markersize',8)
%plot3(y(:,1),y(:,2),y(:,3),'-o')
%hold on
%title(['Phase space in case of $R$=',num2str(R(i))],'Interpreter','latex')
xlabel('Cystoseira')
ylabel('Turf')
zlabel('Urchins')
 
%axis([0 1 0 1 0 1])
 %   figure
%plot(t,y(:,1),'b',t,y(:,2),'r',t,y(:,3),'m')
%hold on

%legend('Cystoseira','Turf','Sea urchins')
%  title(['$\phi$=',num2str(phi(i))],'Interpreter','latex')
% title(['$R$=',num2str(R(i))],'Interpreter','latex')
        end
    end
end
end
%    figure
T=table(y0_col,y_fin)
%%
%for i=1:K_1*K_2*K_3
 %   hold on
  %  if (y_fin(i,3)>0.0001)
    %    plot3(y0_col(i,1),y0_col(i,2),y0_col(i,3),'.b','Markersize',10)
   % elseif (y_fin(i,1)>0.0001)
%        plot3(y0_col(i,1),y0_col(i,2),y0_col(i,3),'.g','Markersize',10)
%    else 
 %       plot3(y0_col(i,1),y0_col(i,2),y0_col(i,3),'.r','Markersize',10)
 %   end
%end
%%
    
            
    shg
