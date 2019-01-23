A=[0 1;-0.4 -4.1];
B=[0;1];
C=[3.3 1];
D=[0];

%% Analogue response of plant
Gp = ss(A,B,C,D);
[Np,Dp]= ss2tf(A,B,C,D);
Gp = tf(Np,Dp);
%step(Gp)
eig(A);
pole(Gp)
zero(Gp)
%title('Continuous-Time Step Response')


%rlocus(Gp)

%%Digital response of plant

T=0.025;
[Npd,Dpd] = c2dm(Np,Dp,T,'zoh')

%[Numzoh,Denzoh] = ss2tf(Azoh,Bzoh,Czoh,Dzoh);

Gpd=tf(Npd,Dpd,T);
pole(Gpd);
%Controller
k=    1;
z1=0.95;
z2=0.1;

num = [1  -z1]
den = [1 -1];
Gc = tf(num,den,T)
Go = series(Gpd,k*Gc);


pzmap(Gpd)
rlocus(Go)
zgrid
%rlocfind(Go)
%checking poles of transfer function and eigvalues of A are equal
poles= pole(Gpd);
%eig(Azoh);

Gideal = tf(1,1);
Gcl = feedback(Go,Gideal);
%step(Gcl)

%zero of transfer function
zero(Gpd);

%calculating damping ratio
PO=30;
dampingratio=sqrt(((log(PO/100))^2)/((pi^2)+(log(PO/100))^2))
%calculating natural frequency and pole placement
settlingT = 3.5;
sigma = 4/settlingT
natural_frequency = sigma/dampingratio;

%figure(2)
%step(Gcl)

%% Linear state feedback controller
[Ad,Bd,Cd,Dd] = c2dm (A,B,C,D,T,'zoh');
k = place (Ad,Bd,[0.972  0.5])
k = [23 18];
poless = eig (Ad-(Bd*k))
Nbar = (1/(Cd*inv (eye (2)-(Ad-Bd*k))*Bd))
Gcl=ss (Ad-(Bd*k),Nbar*Bd,Cd,Dd,T);
%step(Gcl)
% 0.99 is the fastest pole in the system
% Observer needs to react quicker than this fastest pole -> take 1/2 of it
L=place (Ad',Cd',[0.2,0.25])'
%L=[8.2133;-25.7967];
s=size (Ad);
n = s(1);
Acld = [Ad-(Bd*k) Bd*k; zeros(size(Ad)) Ad-(L*Cd)];
Bcld = Nbar*[Bd; zeros(length(Ad),1)];
Ccld = [Cd zeros(1,length (Ad))];
Dcld = Dd;
Gcld = ss (Acld, Bcld, Ccld, Dcld,T);
step (Gcld)
%stepinfo(Gcld)
title('Step response of system using full state linear feedback')
