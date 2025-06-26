function [dydt] = att_esp_r_s(y,R,T0,beta,Acu,phi,C0,r,Atu,Bcu,Btu,Du,Ctu,Ccu)
% Sistema dinamico che descrive il comportamento di C,T,U,
% nel caso di attenuazione della luce di tipo esponenziale
dydt = zeros(2,1);

epsilon=1e-4;

if (y(1)<epsilon)
    y(1)=0; end
dydt(1) = R.*exp(-y(2)./T0).*sqrt(y(1)).*(1-sqrt(y(1)))-beta.*sqrt(y(1).*y(2))-(Acu.*sqrt(y(3).*y(1)))./(Bcu+sqrt(y(1)));

dydt(2) = phi.*exp(-y(1)./C0).*(1-y(2))+r.*sqrt(y(2)).*(1-sqrt(y(2)))-(Atu.*y(3).*y(2))./(Bcu+y(2));
if (y(1)<epsilon)
    y(1)=0; end
dydt(3)=-Du.*y(3)+Ctu.*Atu.*y(3).*y(2)./(Btu+y(2))+Ccu.*Atu.*sqrt(y(3).*y(1))./(Bcu+sqrt(y(1)));
end

