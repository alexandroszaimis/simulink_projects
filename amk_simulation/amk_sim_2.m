%EMRAX 228 params

Ld = 120*10^(-6);
Lq = 240*10^(-6);
Ld_m = Ld/3;
Lq_m = Lq/3;


% Ld = 0.980613543874242*10^(-3);
% Lq = 1.13758505425488*10^(-3);
I_base = 85.7;
Io = 53.1;
J = 0.000528;%2.74e-4; %[moment of inertia]
%J = 30e-4;
Rs = 202.5e-3; %[phase resistance]
Rs_m = Rs/3;
np = 5; %[pole pairs]
%bm = 1;
bm = 0.008; %[T = bm*w]
u_dc = 550;

k = 1;

I_max = 85.7;

psi = 0.05077789*k; %[PM flux - Vs]

ar_max = 1500;

kp_ar = 1e-5;
ki_ar = 0.2;

u_nom = u_dc*k; %[Max ac voltage SVPWM]
N_max = 20000;
wm_max = N_max*2*pi/60;
w_base = 2*pi*N_max/60; %[rad/s]
Vd_lim = u_nom;
rpm_nom = 12000;
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


%I2t control

t_max = 1.24;
Overload_limiter = 0.5;
t_drop = 3.0;

f = @(t) (I_max - (I_max-I_con)*sqrt(t/t_drop));
ts = 1e-6;


integral_value =0;
for t = 0:ts:10
    integral_value = integral_value + (f(t).^2+f(t+ts).^2)*ts/2;
    if f(t) <= I_con || f(t+ts) <= I_con    
        t_drop = t;
        %fprintf('The loop stopped at t = %.2f because f(x) reached I_con.\n', t);
        break;

    end
end

I2t_drop = integral_value;

% Ενδεικτικές τιμές Overload_limiter και t_drop για I_cap = I_max
% 0.9 με 0.3
% 0.8 με 1
% 0.7 με 1.8
% 0.6 με 2.5
% 0.5 με 3.1

I_cap = I_max*0.7;   

% real motor parameters %

% PM.sqrt3 = sqrt(3);
% PM.one_third = 1/3;
% PM.R = Rs;
% PM.Ld = Ld;
% PM.Lq = Lq;
% PM.Flux = psi;
% PM.J = J;
% PM.p = np;  
% PM.Tf = 0;
% PM.F = 0;
% PM.isdo = 0;
% PM.isqo = 0;
% PM.thOffset = 0;

%simout = sim("amk_sim_model.slx");

%if simout.wm < 500
%    psi = 0.047;
%else
%    psi = 0.038;
%end

% constant_test =10;
% 
% % Create or load your Simulink model
% modelName = 'amk_sim_model0x2840x29';
% open_system(modelName);
% 
% % Get the handle to the constant block whose value you want to change
% constantBlock = [modelName '/constant_test']; % Provide the full path to the block
% % If the constant block is nested within subsystems, use appropriate notation
% 
% % Define the new value for the constant
% newValue = 13;
% 
% % Set the new value for the constant block
% set_param(constantBlock, 'Value', num2str(newValue));
% 
% pause(0.1);
% 
% newValue = 33;
% set_param(constantBlock, 'Value', num2str(newValue));
% 
% % Run the simulation
% sim(modelName);



%plot(simout.IGBT_Temperature, simout.Stator_current, '-', 'LineWidth', 2);
%grid on;
%y = linspace(0,110,1000);
%yticks([0 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 105 110]);
%xticks([30 40 50 60 70 80 90 100 110 120 130 140]);
%xticklabels({'0','1.24','2','3','4','5','6','7','8','9','10'})
%title('Inverter Phase Current vs Motor Temperature')
%xlabel('Motor Temperature(°C)')
%ylabel('Inverter Phase Current(Arms)')
%xlim([30 140]);