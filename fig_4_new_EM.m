%Studio della dinamica del sistema nel caso di ricci insaziabili/saziabili
%Plot punti di equilibrio nello spazio C,T, U
%Caso adimensionale

%close all
%clear all
figure(2)

tspan = [0 800]; % 8000
K_1=4;
K_2=4;
K_3=4;
C_in=linspace(0,1,K_1);
T_in=linspace(0,1,K_2);
U_in=linspace(0,3,K_3);

index=1;
y_fin=zeros(K_1*K_2*K_3,3);
% idea: prendo più condizioni iniziali e disegno più soluzioni per capire
% se esistono "zone di influenza"

%Definizione dei parametri
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
Du=3.52;
Ctu=0.9;
Ccu=0.9;
K_C=1; K_T=1; %carrying capacity posta =1


opt=odeset('RelTol',1e-10,'AbsTol',1e-13);

  
for a=1:K_1
    for b=1:K_2
        for c=1:K_3
        y0=[C_in(a) T_in(b) U_in(c)];

[t,y] = ode45(@(t,y)  att_esp_r_s_EM(y,R,T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu), tspan, y0,opt);
y_fin(index,:)=y(end,:);
y0_col(index,:)=y0;
index=index+1;
[m,n]=size(y);
if m>100
%plot3(y(end-100:end,1),y(end-100:end,2),y(end-100:end,3).*Du./phi,'.b','Markersize',15)
plot3(y(end-200:end,1),y(end-200:end,2),y(end-200:end,3),'.b','Markersize',15)
else
plot3(y(end,1),y(end,2),y(end,3),'.b','Markersize',15)
end
hold on
%title(['Phase space in case of $R$=',num2str(R(i))],'Interpreter','latex')
xlabel('$C$','Interpreter','latex','Fontsize',18)
ylabel('$T$','Interpreter','latex','Fontsize',18)
zlabel('$U$','Interpreter','latex','Fontsize',18)
text(0.01,0.999,0.003,'$E_1$','Interpreter','Latex','FontSize',18)
text(0.79,0.9985,0.003,'$E_2$','Interpreter','Latex','FontSize',18)
zticks([0 0.01 0.02 0.03])
%axis([0 .8 .96 1 0 .035])

box on
grid on
%axis([0 1 0 1 0 1])
   figure
plot(t,y(:,1),'b',t,y(:,2),'r',t,y(:,3),'m')
hold on

legend('Cystoseira','Turf','Sea urchins')
 title(['$\phi$=',num2str(phi(i))],'Interpreter','latex')
title(['$R$=',num2str(R(i))],'Interpreter','latex')
        end
    end
end

hold off
%T=table(y0_col,y_fin)
    shg
