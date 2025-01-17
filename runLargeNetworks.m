clear all;
clc;

% CaseFiles={'case_illinois200','case1354pegase','case2383wp','case3012wp','case9241pegase'};
CaseFiles={'case2383wp'};
% CaseFiles={'case_illinois200'};
% CaseFiles={'case57'};
% CaseFiles={'case1354pegase'};
% Perturbation
% CaseFiles={'case9241pegase'};
% CaseFiles={'case1354pegase'};
PRatio=0.1; 
QRatio=0.0484;


SsControlOptions={'OPF','ALQR-OPF'};
SteadyStateOutput=cell(length(CaseFiles),length(SsControlOptions));
% Coupling parameter
Alpha=0.6;

% LQR time importance
Tlqr=1000;


%% Steady-state runs
if exist('Results')~=7
mkdir('Results');
end
SaveName=['Case6515ProgressReport',num2str(Alpha*100),'Percent.txt'];
FileID=fopen(['Results/',SaveName],'w'); 
fprintf(FileID,'%-15s & %-15s & %-15s & %-15s & %-15s & %-15s & %-15s\n',...
    'Network', 'SsMethod','ObjValue', 'SsCost', 'StCostEst.','TotalCostEst.', 'CompTime');

for kk=1:length(CaseFiles)
    CaseFile=CaseFiles{kk};
for ii=1:length(SsControlOptions)
    SteadyStateCase=steadyStateDriver(CaseFile,SsControlOptions{ii},Alpha, Tlqr, PRatio, QRatio);  
    SteadyStateOutput{kk,ii}=SteadyStateCase;
     fprintf(FileID, '%-15s & %-15s & %-15.2f & %-15.2f & %-15.2f & %-15.2f & %-15.2f  \n', ...
    CaseFile, SsControlOptions{ii}, SteadyStateCase.SsObjEst, SteadyStateCase.SsCost,...
   SteadyStateCase.TrCostEstimate, SteadyStateCase.TotalCostEstimate, SteadyStateCase.CompTime);
end
end
fclose(FileID);








