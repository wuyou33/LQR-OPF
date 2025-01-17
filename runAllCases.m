clear all;
clc;
CaseFiles={'case9wmac_con', 'case14wmac_con','case39wmac_con','case57'};
% Perturbation
PRatio=0.1; 
QRatio=0.0484;


SsControlOptions={'LQR-OPF', 'ALQR-OPF','OPF'};
SteadyStateOutput=cell(length(CaseFiles),length(SsControlOptions));
% Coupling parameter
Alpha=0.6;

% LQR time importance
Tlqr=1000;


%% Steady-state runs
if exist('Results')~=7
mkdir('Results');
end
SaveName=['SteadyStateProgressReport',num2str(Alpha*100),'Percent.txt'];
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


%% Dynamical simulations
LfControlOptions={'LQR','AGC'};
DynamicOutput=cell(length(CaseFiles), length(SsControlOptions), length(LfControlOptions));
SaveName=['DynamicalProgressReport',num2str(Alpha*100),'Percent.txt'];
FileID=fopen(['Results/',SaveName],'w'); 

for kk=1:length(CaseFiles)
    CaseFile=CaseFiles{kk};
for jj=1:length(LfControlOptions)
              LfControl=LfControlOptions{jj};
              fprintf(FileID,['---------------------', LfControl, '-----------------', '\n']);
              fprintf(FileID,'%-15s & %-15s & & %-15s & %-15s & %-15s & %-15s & %-15s \n',...
    'Network', 'SsMethod', 'SsCost','StCost','TotalCost.', 'MaxFreqDev', 'MaxVoltDev');
    for ii=1:length(SsControlOptions)
    DynamicCase=dynamicDriver([SteadyStateOutput{kk,ii}.SteadyStatePath, '/',SteadyStateOutput{kk,ii}.SteadyStateFileName], LfControl,'YesPlots');
    DynamicOutput{kk,ii,jj}=DynamicCase;
     fprintf(FileID, '%-15s & %-15s  & %-15.2f & %-15.2f & %-15.2f & %-15.4f & %-15.4f  \n', ...
    CaseFile, SsControlOptions{ii}, DynamicCase.SsCost, DynamicCase.TrCost, DynamicCase.TotalCost,...
    DynamicCase.MaxFreqDev, DynamicCase.MaxVoltDev );
end
end
end
fclose(FileID);






