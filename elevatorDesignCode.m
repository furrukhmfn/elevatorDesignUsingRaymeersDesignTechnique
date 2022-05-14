% Clearing workspace and screen
clear;
clc;
% Input Variables
SurfaceArea = 363.1;
AspectRatio = 9.2;
efficiency = 0.88;
CL_alpha_h = 5.7;
MassofAircraft = 250E3;
WeightpfAircraft = MassofAircraft * 9.81;
densityofair = 1.225;
V_c = 707.455;
delta_CL_flap = 0.5;
CDo_to = 0.102;
VR = 166.46;
VS = VR;
CL_tof = 0.797;
Cm_ac_wf = 0.05;
mu = 0.4;  % Runaway Friction Coefficient 
SingleEngineThrust = 98E3;
NumberofEngines = 04;
ThrustofAircraft = SingleEngineThrust*NumberofEngines;
xmg_minus_xcg = 1.1*1.5;
zd_minus_zmg = 1.9*1.5;
zt_minus_zmg = (1.7+0.3)*1.5;
xmg_minus_xacwf = 0.8*1.5;
zcg_minus_zmg = 1.7*1.5;
xac_minus_xmg = 11.3*1.5;
Iyy = 1500000;
angularrotation = 12/57.3;
SurfaceArea_horizontaltail = 16;
CL_alpha_w = 5.7;
alpha_w = 2;
alpha_w_rad=alpha_w/57.3;
ih = 1;
CL_alpha_w = 4.7;
Maximum_deflection = -30;
bE_over_bh = 1;
lh = 11.3;
Cl_alpha_h = 4.3;
eta_h =1;
Cm_dot = 0.5;
% Calculations 
Span = sqrt(SurfaceArea*AspectRatio);
MeanAerodynamicchord = SurfaceArea/Span;
K = 1/(pi*efficiency*AspectRatio);
CL_c = (2*WeightpfAircraft)/(densityofair*(V_c^2)*SurfaceArea);
CL_to = CL_c + delta_CL_flap ;
CD_to = CDo_to + K*(CL_to^2);
D_to = 0.5*densityofair*(VR^2)*SurfaceArea*CDo_to;
L_to = 0.5*densityofair*(VR^2)*SurfaceArea*CL_tof;
Mac_wf = 0.5*densityofair*(VR^2)*SurfaceArea*Cm_ac_wf*MeanAerodynamicchord;
% Calculation of Step # 06
Ff = mu*(WeightpfAircraft-L_to);
AicraftLinearAcceleration = (ThrustofAircraft - D_to - Ff)/MassofAircraft;
% Calculation of step # 07
Mw = -WeightpfAircraft*(xmg_minus_xcg);
Md = D_to*(zd_minus_zmg);
Mt = -ThrustofAircraft*(zt_minus_zmg);
ML_wf = L_to*(xmg_minus_xcg);
Ma = MassofAircraft*AicraftLinearAcceleration*(zcg_minus_zmg);
L_wf = L_to;
% Calculation of Step # 08
Lh = -(ML_wf+Mac_wf+Ma+Mw+Md+Mt-(Iyy*angularrotation))/(xac_minus_xmg);
% Calcualtion of Step # 09
Cl_h = (2*Lh)/(densityofair*(VR^2)*(SurfaceArea_horizontaltail));
% Calculation of Step # 10
downwash_effectiveness = (2*CL_to)/(pi*AspectRatio);
deltaepsilon_over_deltaalpha = (2*CL_alpha_w)/(pi*AspectRatio);
epsilon = downwash_effectiveness+deltaepsilon_over_deltaalpha*alpha_w_rad;
horizontaltail_angleofattack = alpha_w-ih+rad2deg(epsilon);
angleofattack_effectiveness = (deg2rad(horizontaltail_angleofattack)+(Cl_h/CL_alpha_w))/(deg2rad(Maximum_deflection));
% Calculation of Step # 11
% Should Be Done From The Graph and Value Should be Placed 
CE_over_Ch = 0.40;
% Calculation of Step # 14
delta_alpha_wo = -1.15*(CE_over_Ch)*Maximum_deflection;
% Calculation of Step # 16
V_bar_H = (lh*SurfaceArea_horizontaltail)/(SurfaceArea*MeanAerodynamicchord);
C_m_delatE = -Cl_alpha_h *eta_h*V_bar_H*bE_over_bh*angleofattack_effectiveness;
C_L_deltaE = Cl_alpha_h*eta_h*(SurfaceArea_horizontaltail/SurfaceArea)*bE_over_bh*angleofattack_effectiveness;
Cl_h_deltaE = CL_alpha_h*angleofattack_effectiveness;
% Calculation of Step # 17
zt = -0.3;
Cl_alpha = 5.7;
h_minus_ho = 0.8-0.5;
Cl_deltaE = -0.626;
dyanmicpressure = 0.5*densityofair*(V_c^2);
CL_i=(2*WeightpfAircraft)/(densityofair*SurfaceArea*(V_c^2));
Cm_alpha = CL_tof*(h_minus_ho)-CL_alpha_h*eta_h*(SurfaceArea_horizontaltail/SurfaceArea)*(lh/MeanAerodynamicchord)*(1-deltaepsilon_over_deltaalpha);
Factor1 = (((ThrustofAircraft*zt)/(dyanmicpressure*SurfaceArea*MeanAerodynamicchord))+Cm_dot)*(Cl_alpha);
Factor2 = (CL_i - CL_to)*Cm_alpha;
Factor3 = Cl_alpha*C_m_delatE-Cm_alpha*Cl_deltaE
delta_E = -(Factor1+Factor2)/(Factor3)
% Calculation of Step # 20
alpha_sto = 12;
Alpha_to = alpha_sto -2;
alpha_h_to = Alpha_to*(1-deltaepsilon_over_deltaalpha)+ih-downwash_effectiveness;
% Calculation of Step # 25
bE__over_bh = 1
bh=12
bE = bh*bE__over_bh
Mean_Ch = SurfaceArea_horizontaltail/bh
CE = CE_over_Ch*Mean_Ch
SE = bE*CE
