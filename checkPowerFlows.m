function [checkpf, checkEqs,realGen_check, reactiveGen_check, ...
    realLoad_check,reactiveLoad_check]...
    = checkPowerFlows(VS,thetaS,pgS,qgS, pdS,qdS)
% CHECKPOWERFLOWS Validates given power flow solution.
% [checkpf,checkEqs,realGen_check,...
%     reactiveGen_check, realLoad_check,...
%     reactiveLoad_check] = checkPowerFlows(VS, thetaS, pgS, qgS, pdS, qdS )  
%  validates given power flow solution.  This is a vectorized
%  implementation. See checkPowerFlowsPerNode for a node by node
%  implementation.
%
% Description of outputs:
%  1. checkpf:  is a scalar binary which equals  1 when all power flow
%  equations are satisfied with absolute accuracy 1e-3. 
%  2. checkEqs: is a vector of size(2*N,1), expressing the difference with zero
% for any of the equations in CDC 2016 paper equations (2c)-(3b)
%  3. realGen_check: is a vector of size(G,1), expressing the difference with
%  zero for equations (2c)
%  4. reactiveGen_check: is a vector of size(G,1), expressing the difference
%  with zero for equations (2d)
% 5. realLoad_check: is a vector of size(L,1), expressing the difference with
% zero for equations (3a)
% 6. reactiveLoad_check: is a vector of size(L,1), expressing the difference
% with zero for equations (3d)
%
% Description of inputs:
%  1. VS: the steady-state voltage magnitude power flow solution
% 2. thetaS: the steady-state voltage phase power flow solution (in Radians)
% 3. pgS: the generator real power set points set points and the calculated pg for slack bus 
% 4. qgS: the generator reactive power inputs
% 5. pdS: the steady-state real power loads used to run the power flow
% 6. qdS: the steady-state reactive power loads used to run the power flow
%
% See also checkPowerFlowsPerNode
%
% Required modifications:
% 1. Fix equation number references.

global N G  GenSet...
    LoadSet  GMat BMat...
    Cg


VSmat=diag(sparse(VS));
cosMat=diag(cos(sparse(thetaS)));
sinMat=diag(sin(sparse(thetaS)));





realCheck=VSmat*cosMat*GMat*VSmat*cos(thetaS)-VSmat*cosMat*BMat*VSmat*sin(thetaS)...
  +VSmat*sinMat*BMat*VSmat*cos(thetaS)+VSmat*sinMat*GMat*VSmat*sin(thetaS)+pdS-Cg*pgS;
reactiveCheck=VSmat*sinMat*GMat*VSmat*cos(thetaS)-VSmat*sinMat*BMat*VSmat*sin(thetaS)...
  -VSmat*cosMat*BMat*VSmat*cos(thetaS)-  VSmat*cosMat*GMat*VSmat*sin(thetaS)+qdS-Cg*qgS;

realGen_check=realCheck(GenSet);
reactiveGen_check=reactiveCheck(GenSet);
realLoad_check=realCheck(LoadSet);
reactiveLoad_check=reactiveCheck(LoadSet);
checkEqs=[realGen_check; reactiveGen_check; realLoad_check;reactiveLoad_check];

if max(abs(checkEqs))<1e-3
% disp('Power flow equations satisfied'); 
checkpf=1;
else
% disp('Power flow equations NOT satisfied'); 
checkpf=0;
end
end
