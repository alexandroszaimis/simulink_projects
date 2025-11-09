clear; clc;

tr = 5e-3;
tr_s = 100e-3;
tr_m = 200e-3;
%Induction Motor Parameters
V_base = 60;%230 * sqrt(2); %[V]
V_nom = 230 * sqrt(2);
w_base = 2*pi*50;           %[rad/s]
I_base = 3.6 * sqrt(2); %[A]
I_nom = 3.6;
P_n = 1470;             %[W]
N_n = 1410;             %[rpm]
Z_base = V_nom/I_base; % [Ω]
Rs = 6.5;      % [Ω]
Rr = 2.5;    % [Ω]
Lls = 0.02;  % [H]
Llr = 0.02;  % [H]
Lm = 0.388;  % [H]
J = 0.1;    % [kgm^2]
np = 2;      % pole pairs
wm_n = 2 * pi/60 * N_n;    %[rad/s]

b=Lm/(Lm+Llr);

LM=b*Lm;
RR=(b^2)*Rr;
Lsig=Lls+Llr;

RR_m = RR;
Rs_m = Rs;
Lsig_m = Lsig;
LM_m = LM;
J_m = J;

psi_nom = (V_nom/w_base)*sqrt((1-(w_base*Lsig/Z_base)^2)/(1+2*Lsig/LM));

psi = psi_nom;

Id_nom = psi_nom/LM;

Te_n = P_n/wm_n;

k = Te_n/wm_n;

k2 = Te_n/wm_n^2;

Vpeak = V_base;

ac=log(9)/tr;
Ra = ac*Lsig-Rs-RR;
Kp=ac*Lsig;
Ki=(ac^2)*Lsig;

lamba = 1.5;

w_delta = 0.1*w_base;
al =log(9)/tr_m;

%ap = 20;

RRest2 = RR;
LMest2 = LM;
RRest = RRest2;
LMest = LMest2;

K = 1;
as=log(9)/tr_s;    % one decade slower than the current control loop
%Kps=as*J/psi_nom;
Kps = 2*K^2 * as * J/(3*np^2 * psi_nom);

%Kis=(as^2)*J/psi_nom;
Kis = 2*K^2 * as^2 * J/(3*np^2 * psi_nom);

%ba=(as*J)/psi_nom; 
ba = 2 * K^2 * (as * J)/(3*np^2 * psi_nom);

ksi = (Lsig + LM)/Lsig;

