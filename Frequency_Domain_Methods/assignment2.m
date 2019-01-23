Np=[800*5717.7^2*14325.7^2];
D=conv([1 0 0],[1 2*0.008*5717.7 5717.7^2]);
Dp=conv(D,[1 2*0.02*14325.7 14325.7^2]);
Gp=tf(Np,Dp);
k=1.63;
Gc=tf([2.04*0.012 1],[0.012 1])
Go=series(Gp,Gc)
Gideal=tf(1,1);
Gcl=feedback(Go,Gideal);

%bode(Gp)
step(Gcl)
title('step response of plant with P and lead controller')