%% environment params
qe = 0.1;

%% controllers
s = tf('s');


Khst = 20000;
Dhst = 1000;

Bm = 0.8;
Km = 1;

Bs = 3.2;
Ks = 4;


Mm = 0.5;
Ms = 2;


Zs = Ms*s;
Cs = Bs + Ks/s;
Cm = Bm + Km/s;
Zm = Mm*s;

Dm = 0;%5;
Ds = 0;%10;

Jh = 0.5;
Bh = 70;
Kh = 2000;


Je = 0;
Be = 100;
Ke = 200;

Zh = (Jh*s + Bh + Kh/s)*1/(s+10000);
Ze = (Je*s + Be + Ke/s)*1/(s+10000);


ZmINV = 1/(Mm*s+Dm);
ZsINV = 1/(Ms*s+Ds);








C1 = (Zs+Cs)*1/(s+10000);
C2 = 1;
C3 = 1;
C4 = -(Zm+Cm)*1/(s+10000);
