%DEDOMENA

M=1;
Iz=0.08;
g=9.81;
am=4410;

zTonos=0;  %z'(0)=0
yTonos=0;  %y'(0)=0

%arxikes sunthikes

fz= M*g + (am/1000);
tz=0;

z0= am/1000;
psi0=0;

Cz= 3-(am/5000);
Cy= 5+(am/5000);

%erwthma b dedomena

h=0.001;
t=0:h:30;
N=length(t);
disp(N);


f1=@(t,z1,z2) (z2);
f2=@(t,z1,z2) ((fz-(g.*M)-Cz.*(abs(z2).*z2))./M);

g1=@(t,y1,y2) (y2);
g2=@(t,y1,y2) ((tz-Cy.*abs(y2).*y2)./Iz);      

%Euler 
z1(1)= z0;
z2(1)= zTonos;
y1(1)= psi0;
y2(1)= yTonos;

for n=1:N-1;
  z1(n+1)= z1(n)+ h*f1(t(n),z1(n),z2(n));
  z2(n+1)= z2(n)+ h*f2(t(n),z1(n),z2(n));
endfor

figure;
subplot(321);
plot(t,z1,'c-');
title('Euler z');

for n=1:N-1;
  y1(n+1)= y1(n)+ h*g1(t(n),y1(n),y2(n));
  y2(n+1)= y2(n)+ h*g2(t(n),y1(n),y2(n));
endfor


subplot(322);
plot(t,y1,'c-');
title('Euler Y');

% tropopoihmenh Euler 
z1_tr(1)= z0;
z2_tr(1)= zTonos;
y1_tr(1)= psi0;
y2_tr(1)= yTonos;

for n=1:N-1;
  z1_tr(n+1)= z1_tr(n)+ h*f1(t(n)+h/2,z1_tr(n)+h/2,z2_tr(n)+h/2*f2(t(n),z1_tr(n),z2_tr(n)));
  z2_tr(n+1)= z2_tr(n)+ h*f2(t(n)+h/2,z1_tr(n)+h/2,z2_tr(n)+h/2*f2(t(n),z1_tr(n),z2_tr(n)));
  y1_tr(n+1)= y1_tr(n)+ h*g1(t(n)+h/2,y1_tr(n)+h/2,y2_tr(n)+h/2*g2(t(n),y1_tr(n),y2_tr(n)));
  y2_tr(n+1)= y2_tr(n)+ h*g2(t(n)+h/2,y1_tr(n)+h/2,y2_tr(n)+h/2*g2(t(n),y1_tr(n),y2_tr(n)));
endfor


subplot(323);
plot(t,z1_tr,'r-');
title('Tropopoihmenh Euler z');


subplot(324);
plot(t,y1_tr,'r-');
title('Tropopoihmenh Euler Y');