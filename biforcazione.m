%Diagramma di biforcazione

close all
clear all

K=100; %numero di punti del parametro che prendiamo
%Du=linspace(0,5,K); %valori del parametro
Du=linspace(3.48,3.57,K); %valori del parametro
%R=linspace(1.46,1.54,K);
%phi=linspace(0,0.25,K);
y0=[0.5,0.5,0.5]; %punto iniziale
tspan=[0 5000]; 


l=200; %Numero di punti che disegno

%Definizione dei parametri
C0=3;
T0=2;
phi=0.2;
beta=0.1;
r=1;
R=1.5;
Acu=1;
Atu=1;
Bcu=0.1; % B_cu circa 0.1 B_tu=0.6
Btu=0.6;
Ctu=0.9;
Ccu=0.9;
%Du=3.5;
K_T=1;
opt=odeset('RelTol',1e-6,'AbsTol',1e-9);

bif_1=zeros(l,K);
bif_2=zeros(l,K);
bif_3=zeros(l,K);
min_max_1=zeros(2,K);
min_max_2=zeros(2,K);
min_max_3=zeros(2,K);
%Scelta tra ricci insaziabili e saziabili
prompt = 'Integrazione nel caso di ricci insaziabili (1) o nel caso di ricci saziabili (2)?';
x = input(prompt);
if (x==1)
for i=1:K
    [t,y] = ode45(@(t,y) att_esp_r_i(y,R,T0,beta,Acu,phi,C0,r,Atu,Du(i),Ctu,Ccu), tspan, y0,opt);
    %Integro e trovo un vettore t e un vettore y di soluzioni 
    %N.B. la dimensione di t e y cambia al variare di i
    %Prendo le ultime l iterazioni e le metto in un vettore
    %poi metto in fila tutti i vettori e costruisco una matrice
    [j,k]=size(t);
    bif_1(:,i)=y(end-l+1:end,1);
    bif_2(:,i)=y(end-l+1:end,2);
    bif_3(:,i)=y(end-l+1:end,3);
    
    min_max_1(:,i)=[min( bif_1(:,i)) max(bif_1(:,i))];
    min_max_2(:,i)=[min(bif_2(:,i)) max(bif_2(:,i))];
    min_max_3(:,i)=[min( bif_3(:,i)) max(bif_3(:,i))];
end


elseif (x==2)
    for i=1:K
    [t,y] = ode45(@(t,y)  att_esp_r_s(y,R,T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du(i),Ctu,Ccu), tspan, y0,opt);
    %[t,y] = ode45(@(t,y)  att_esp_r_s(y,R(i),T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu), tspan, y0,opt);
    %[t,y] = ode45(@(t,y)  att_esp_r_s(y,R,T0,beta,Acu,phi(i),C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu), tspan, y0,opt);
    %Integro e trovo un vettore t e un vettore y di soluzioni 
    %N.B. la dimensione di t e y cambia al variare di i
    %Prendo le ultime l iterazioni e le metto in un vettore
    %poi metto in fila tutti i vettori e costruisco una matrice
      bif_1(:,i)=y(end-l+1:end,1);
    bif_2(:,i)=y(end-l+1:end,2);
    bif_3(:,i)=y(end-l+1:end,3);
        min_max_1(:,i)=[min( bif_1(:,i)) max(bif_1(:,i))];
    min_max_2(:,i)=[min(bif_2(:,i)) max(bif_2(:,i))];
    min_max_3(:,i)=[min( bif_3(:,i)) max(bif_3(:,i))];
    end
end
%plot(Du,bif_1','.')
%plot(Du,min_max_1,'.-')
plot(Du,min_max_1,'.-')
%plot(phi,min_max_1(2,:),'ok','Markersize',4)
hold on
plot(Du,min_max_1(1,:),'-or','Markersize',4,'Markeredgecolor','r','Markerfacecolor','r')

plot(Du,min_max_1(2,:),'k','Linewidth',1.5)

title('\textbf{Cystoseira}','Interpreter','latex','Fontsize',18)
xlabel('$\mathbf{\Delta_U}$','Interpreter','latex','Fontsize',18)
%xlabel('$\mathbf{\Phi}$','Interpreter','latex','Fontsize',18)
%xlabel('$\mathbf{\Phi}$','Interpreter','latex')
ylabel('$\mathbf{C}$','Interpreter','latex','Fontsize',18)
%xlabel('$R$','Interpreter','latex')

figure
%plot(Du,bif_2','.')
%plot(Du,min_max_2,'.-')
plot(Du,min_max_2,'.-')
%plot(phi,min_max_2,'.-')
%plot(phi,min_max_2(2,:),'ok','Markersize',4)
%plot(R,min_max_2(2,:),'ok','Markersize',4)
hold on
plot(Du,min_max_2(1,:),'-or','Markersize',4,'Markeredgecolor','r','Markerfacecolor','r')

plot(Du,min_max_2(2,:),'k','Linewidth',1.5)
%xlabel('$\mathbf{\delta}$','Interpreter','latex')
ylabel('$\mathbf{T}$','Interpreter','latex','Fontsize',18)
title('\textbf{Turf}','Interpreter','latex','Fontsize',18)
%xlabel('$\mathbf{\Delta_U}$','Interpreter','latex')
xlabel('$\mathbf{\Delta_U}$','Interpreter','latex','Fontsize',18)
%xlabel('$R$','Interpreter','latex')
figure

plot(Du,min_max_3(2,:),'ok','Markersize',4)
hold on
plot(Du,min_max_3(1,:),'-or','Markersize',4,'Markeredgecolor','r','Markerfacecolor','r')

plot(Du,min_max_3(2,:),'k','Linewidth',1.5)

%plot(Du,min_max_3,'.-')
%plot(R,min_max_3,'.-')
%plot(Du,min_max_3,'.-')
%plot(R,min_max_3(2,:).*Du./phi,'ok','Markersize',4)
%plot(R,min_max_3(2,:),'ok','Markersize',4)
%hold on
%plot(R,min_max_3(1,:).*Du./phi,'-or','Markersize',4,'Markeredgecolor','r','Markerfacecolor','r')
%plot(R,min_max_3(1,:),'-or','Markersize',4,'Markeredgecolor','r','Markerfacecolor','r')

%plot(R,min_max_3(2,:).*Du./phi,'k','Linewidth',1.5)

%plot(R,min_max_3(2,:),'k','Linewidth',1.5)
title('\textbf{Sea urchins}','Interpreter','latex','Fontsize',18)
ylabel('$\mathbf{U}$','Interpreter','latex','Fontsize',18)
xlabel('$\mathbf{\Delta_U}$','Interpreter','latex','Fontsize',18)

%xlabel('$\mathbf{\delta}$','Interpreter','latex')

    
