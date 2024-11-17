%DEDOMENA

M=1;
Iz=0.08;
g=9.81;
am=4410;

%DEDOMENA ERWTHMATOS G
Cz=3+(am/5000);
Cy=5;

Kpz=5;
Kdz= 15-(am/1000);
Kpy=5;
Kdy=20;
z0=am/1000;
y0=0;
zdes=am/200;
ydes=am/3000;

zTonos=0;
yTonos=0;

%diasthma 
h=0.001;
t=0:h:30;
N=length(t);

f1=@(t,z1,z2) (z2);
f2=@(t,z1,z2) ((M*g+Kpz*(zdes-z1)-Kdz*z2-(g*M)-Cz.*(abs(z2).*z2))./M);
g1=@(t,y1,y2) (y2);
g2=@(t,y1,y2) ((Kpy*(ydes-y1)- Kdy*y2-Cy.*abs(y2).*y2)./Iz); 


%Euler 
z1(1)= z0;
z2(1)= zTonos;
y1(1)= y0;
y2(1)= yTonos;

for n=1:N-1;
  z1(n+1)= z1(n)+ h*f1(t(n),z1(n),z2(n));
  z2(n+1)= z2(n)+ h*f2(t(n),z1(n),z2(n));
 
endfor

figure;
subplot(321);
plot(t,z1);
title('Euler: z');

for n=1:N-1;
  y1(n+1)= y1(n)+ h*g1(t(n),y1(n),y2(n));
  y2(n+1)= y2(n)+ h*g2(t(n),y1(n),y2(n));
endfor

subplot(322);
plot(t,y1);
title('Euler: y');

% tropopoihmenh Euler 
z1_tr(1)= z0;
z2_tr(1)= zTonos;
y1_tr(1)= y0;
y2_tr(1)= yTonos;

for n=1:N-1;
  z1_tr(n+1)= z1_tr(n)+ h*f1(t(n)+h/2, z1_tr(n)+h/2, z2_tr(n)+h/2*f2(t(n),z1_tr(n),z2_tr(n)));
  z2_tr(n+1)= z2_tr(n)+ h*f2(t(n)+h/2, z1_tr(n)+h/2, z2_tr(n)+h/2*f2(t(n),z1_tr(n),z2_tr(n)));
  y1_tr(n+1)= y1_tr(n)+ h*g1(t(n)+h/2, y1_tr(n)+h/2, y2_tr(n)+h/2*g2(t(n),y1_tr(n),y2_tr(n)));
  y2_tr(n+1)= y2_tr(n)+ h*g2(t(n)+h/2, y1_tr(n)+h/2, y2_tr(n)+h/2*g2(t(n),y1_tr(n),y2_tr(n)));
endfor

subplot(323);
plot(t,z1_tr);
title('Tropopoihmenh Euler: z');

subplot(324);
plot(t,y1_tr);
title('Tropopoihmenh Euler: y');