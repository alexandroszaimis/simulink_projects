%EMRAX 228 params

Ld = 177*10^(-6);
Lq = 183*10^(-6);
Ld_motor = Ld;
Lq_motor = Lq;

I_base = 240*sqrt(2);
Io = I_base;
J = 421e-4;%2.74e-4; %[moment of inertia]
Rs = 18e-3; %[phase resistance]
np = 10; %[pole pairs]
%bm = 1;
bm = 0.008; %[T = bm*w]
u_dc = 550;

k = 1;

I_max = I_base;

psi = 0.0542*k; %[PM flux - Vs]

ar_max = 1500;

kp_ar = 1e-5;
ki_ar = 0.2;

u_nom = u_dc*k; %[Max ac voltage SVPWM]
N_max = 6500;
wm_max = N_max*2*pi/60;
w_base = 2*pi*N_max/60; %[rad/s]
Vd_lim = u_nom;
rpm_nom = 5100;
%Inverter params
fsw = 8e3; %[Switching frequency]
Peak_power = 50000;
Peak_regen = -1500000;

sample_time = 1e-6;

%current control params
tr = 1.2e-3; %[rise time]
trfw = 12e-3;
trs = 30e-3;
ac = log(9)/tr; %[bandwidth for current]
as = log(9)/trs; %[bandwidth for speed]
a_fw = log(9)/trfw;

ba = 2*k^2*(as*J - bm)/(np^2*psi);
kp_s = 2*k^2*as*J/(np^2*psi); %[kp speed]
ki_s = 2*k^2*as^2*J/(np^2*psi); %[ki speed]
Ra_d = ac*Ld-Rs; %active resistance d
Ra_q = ac*Lq-Rs; %active resistance q
kp_d = ac*Ld;
ki_d = (ac^2)*Ld;
kp_q = ac*Lq;
ki_q = (ac^2)*Lq;

min_value = -500;
max_value = 500;
Icon = 33.5;
I_con = Icon;
Ipeak = 87.5;
Imax_interval = 5;

max_temp = 140;
temp_threshold = 100;