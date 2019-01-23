clc
clear all
Np = [11.51 1.774];
Dp = [1 10.74 8.311 9.21 0];
Gp = tf(Np,Dp);
k= 0;
z1=1.5;
z2=2.5;
p=0.5;
Nc = conv([1 z1],[1 z2]);
Dc = [1 p];
Gc = tf(Nc,Dc);
Go = series(Gp,k*Gc);
%rlocus(Go)
%sgrid
%rlocfind(Go)
pole(Gp);
zero(Gp);
Gideal = tf(1,1);
Gcl = feedback(Go,Gideal);
%figure(1)
step(Gcl)