ninterpol = 14;
[a,b,nlayers] = size(Z);
for j = 1:nlayers
figure(1)
M = contour(C,T,Z(:,:,j),[2 2]);
A = M(:,2:end);
X = A(1,:);
Y = A(2,:);
[Xu,ia,ic] = unique(X);
Yu = Y(ia);
Xp = linspace(Xu(1),Xu(end),ninterpol);
Yp = interp1(Xu,Yu,Xp);
figure(2)
h = plot(Xp,Yp,'k');
set(h,'LineWidth',2)
text(Xp(13),.8,num2str(U(j)),'Fontsize',18)
hold on
end
hold off
axis([0,.4,0,.9])
xlabel('$C$','Interpreter','latex','Fontsize',18)
ylabel('$T$','Interpreter','latex','Fontsize',18)
shg
