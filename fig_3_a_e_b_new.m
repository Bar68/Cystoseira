%Flusso delle velocità nel caso dei ricci saziabili


% load CTbasin

R=1.5;
T0=5;
beta=0.1;
phi=0.1;
A_tu=1;
A_cu=1;
C0=3;
U=0.1;%U=0.5;
r=1;
Bcu=0.1;
Btu=0.6;

  %[x,y] = meshgrid(-0.3:.1:1.3, -0.3:.1:1.3);
  if 1
       pcolor(C',T',Z)
       shading interp
   colormap((1-gray/3))
   alpha(.5)
     hold on
  [x,y] = meshgrid(linspace(.02,.98,15), linspace(.01,.98,15));
  
  comp=beta.*sqrt(x.*y);
  saz_cu=A_cu.*sqrt(U.*x)./(Bcu+sqrt(x));
  saz_tu=(A_tu.*U.*y)./(Btu+y);
   V_1 = (R./T0).*(T0-y).*sqrt(x).*(1-sqrt(x))-comp-saz_cu;
   V_2=   (phi./C0).*(C0-x).*(1-y)+r.*sqrt(y).*(1-sqrt(y))-saz_tu;
   scale=1.5;
    q = quiver(x,y,V_1,V_2,scale);
    set(q,'MaxHeadSize',0.05)
    set(q,'LineWidth',1)

  plot([x(1); x(end)],[0 0],'k',[0 0],[y(1); y(end)],'k')

  %plot([0 0],[0 1],'r',[0 1],[1 1],'r',[0 1],[0 0],'r',[1 1],[0 1],'r')
 axis([-0.002,1,0,1])
    y_1=linspace(0.1,0.9);
  [x_1] = g_isocline(y_1,C0,phi,A_tu,U,Btu,r);
[y_4,x_4] = parte_reale(y_1,x_1);
  x_3=linspace(0,0.9);
   [y_3] =  Y_2(x_3,beta,R,T0,A_cu,Bcu,U);
   [x_2,y_2] = parte_reale(x_3,y_3);
     plot(x_4,y_4,'Color',[1 0.5 0],'LineWidth',2.5,'LineStyle','-.')
plot(x_2.^2,sign(y_2).*y_2.^2,'Color',1/255*[0,104,87],'LineWidth',2.5,'LineStyle','--')

plot([0 0],[0 1],'Color',1/255*[0,104,87],'LineWidth',2.5,'LineStyle','-.')
  
if 0
  %Trovo punto di equilibrio e lo inserisco nel plot
  tspan = [0 10^3];
  k=30;
  C_in=linspace(0,1,k);
    T_in=linspace(0,1,k);
       for i=1:k
       for j=1:k
y0 = [C_in(i) T_in(j)];
 [t,y] = ode45(@(t,y) rs_mod(t,y,R,r,T0,C0,beta,phi,A_cu,A_tu,U,Bcu,Btu), tspan, y0);
 y_fin=[y(end,1),y(end,2)];
 plot(y(end,1),y(end,2),'k*','Markersize',12,'LineWidth',2)
       end
       end
end
plot(0,.8977,'k*','Markersize',12,'LineWidth',2)
plot(.1184, .899,'ko','Markersize',10,'LineWidth',2.5)
plot(.2312, .8966,'k*','Markersize',12,'LineWidth',2)

 xlabel('$C$','Interpreter','Latex','Fontsize',16)
    ylabel('$T$','Interpreter','Latex','Fontsize',16)
  hold off
  end 


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%

if 0 %%%
     tspan = [0 10^3];
    k=120;
  C_in=linspace(0,.3,k);
    T_in=linspace(0,1,k);
    [C,T] = meshgrid(C_in,T_in);
    Z = zeros(size(C));
 figure(1)
    for i=1:k
        for j=1:k
y0 = [C_in(i) T_in(j)];
  [t,y] = ode45(@(t,y) rs_mod(t,y,R,r,T0,C0,beta,phi,A_cu,A_tu,U,Bcu,Btu), tspan, y0);
  y(end,:)
  if (y(end,1)<1e-3)
      plot(y0(1),y0(2),'.r','Markersize',7)
      plot(y(end,1),y(end,2),'k*','Markersize',12);
      hold on
      Z(i,j) = 1;
  else
       plot(y0(1),y0(2),'.b','Markersize',7)
       plot(y(end,1),y(end,2),'k*','Markersize',12); 
       hold on
  end
  hold on
        end
    end
    xlabel('$C$','Interpreter','Latex','Fontsize',16)
    ylabel('$T$','Interpreter','Latex','Fontsize',16)
    shg
     figure(2)

pcolor(C',T',Z)
colormap((1-gray/3))
shading interp
hold on
plot(.2312, .8966,'k*','Markersize',12,'LineWidth',1.5)
% hold on
plot(0,.8977,'k*','Markersize',12,'LineWidth',1.5)
axis([0 1 0 1])
xlabel('$C$','Interpreter','Latex','Fontsize',16)
    ylabel('$T$','Interpreter','Latex','Fontsize',16)
    hold off
end %%%