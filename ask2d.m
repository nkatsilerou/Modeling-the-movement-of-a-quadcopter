M=1;
Iz=0.08;
g=9.81;

am=4410;

Cz=3+(am/5000);
Kpz=5;
Kdz=15;
zdes=am/200;

z0= am/1000;
zTonos=0; %z'(0)=0


h=0.001;
t=0:h:30;
N=length(t);
k1=@(t,z1,z2) (z2);
k2=@(t,z1,z2) ((Kpz *zdes - Kpz *z1  -(Kdz+Cz)*z2)/M ); %apo erwthma 2a

%ANALUTIKH LUSH 
for n=1:N
  z(n)= 22.05 -19.17*exp(-0.57*t(n)) + 1.33*exp(-8.23*t(n));
endfor


figure;
subplot(311);
plot(t,z,'g-');
title('analutikh  z');

%EULER 
z1(1)= z0;
z2(1)= zTonos;

for n=1:N-1;
  z1(n+1)= z1(n)+ h*k1(t(n),z1(n),z2(n));
  z2(n+1)= z2(n)+ h*k2(t(n),z1(n),z2(n));
 endfor


subplot(312);
plot(t,z1,'r-');
title('euler z');

%TROPOPOIHMENH EULER

z1_tr(1)= z0;
z2_tr(1)= zTonos;

for n=1:N-1;
  z1_tr(n+1)= z1_tr(n)+ h*k1(t(n)+h/2,z1_tr(n)+h/2,z2_tr(n)+h/2*k2(t(n),z1_tr(n),z2_tr(n)));
  z2_tr(n+1)= z2_tr(n)+ h*k2(t(n)+h/2,z1_tr(n)+h/2,z2_tr(n)+h/2*k2(t(n),z1_tr(n),z2_tr(n)));
endfor

subplot(313);
plot(t,z1_tr,'b-');
title(' tropopoihmenh euler z');

