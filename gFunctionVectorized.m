function [ deltaDot, omegaDot, eDot, mDot ] = gFunctionVectorized( ...
    delta, omega, e,m,...
     vg, thetag,pg,pref,f)
% GFUNCTIONVECTORIZED calculates the differential function g(x,a,u); according to 
% CDC 2016 (1a)--(1c). 
% [ deltaDot, omegaDot, eDot ] = gFunctionVectorized( ...
%   delta, omega, e,...
%    thetag, vg, pg,m,f,...
%    OMEGA_S, m_vec, d_vec, tau_vec, xd_vec,...
%    xprime_vec) calculates the state derivates.
% 
% Description of Outputs:
% 1. deltaDot: the time-derivative of generator internal angle delta,
% size(G,1).
% 2. omegaDot: the time-derivative of generator internal frequency,
% size(G,1).
% 3. eDot: the time-derivate of generator electromotive force, size(G,1). 
% 
% Description of Inputs:
% 1. delta: vector of generator internal angles in radians, size(G,1).
% 2. omega: vector of generator internal frequencies in radians per second,
% size(G,1).
% 3. e: vector of generator electromotive force in pu volts, size(G,1).
% 4. thetag: vector of generator terminal voltage angles in radians,
% size(G,1).
% 5. vg: vector of generator terminal voltage magnitudes in pu volts,
% size(G,1). 
% 6. pg: vector of generator real power generated output in pu watts,
% size(G,1). 
% 7. qg: vector of generator reactive power generated output in pu vars,
% size(G,1). 
% 8. m: generator mechanical power input,  size(G,1).
% 9. f: generator internal field voltage in pu voltage, size(G,1). 
% 10. OMEGA_S: the steady-state frequency.
% 11. m_vec: vector of generator inertia constants in pu, size(G,1). 
% 12. d_vec: vector of damping coefficients, size(G,1)
% 13. tau_vec: vector of direct axis transient open-circuit time constant,
% size(G,1). 
% 14. xd_vec:  vector of direct axis synchronous reactance pu, size(G,1).
% 15. xprime_vec: direct axis transient reactance pu, size(G,1).
% 16. Tch_vec
% 17. freqR_vec

% See also gFunction
% 
% Required: 
% 1. Fix equation numbers. 

global  TauVec XdVec XqVec XprimeVec DVec MVec TchVec FreqRVec
global OMEGAS

M=diag(MVec);
D=diag(DVec);
T=diag(TauVec);
Tch=diag(TchVec); 
FreqR=diag(FreqRVec); 
Xprime=diag(XprimeVec); 
Xd=diag(XdVec);
V_g=diag(vg);


InvM=diag(1./MVec);
InvT=diag(1./TauVec);
InvXprime=diag(1./XprimeVec);
InvTch=diag(1./TchVec);
InvFreqR=diag(1./FreqRVec);



deltaDot=omega-OMEGAS;
omegaDot=InvM*(m-D*(omega-OMEGAS)-pg); 
eDot=InvT*(- InvXprime*Xd*e+ InvXprime*(Xd-Xprime)*V_g*cos(delta-thetag)+f);
mDot=InvTch*( pref-InvFreqR*(omega-OMEGAS)-m); 
end

