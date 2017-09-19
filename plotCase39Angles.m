%% delta plots
DeltayMax=max(max(radians2degrees([LqrOpf.deltaVec-repmat(LqrOpf.deltaS,1,length(t)),...
    ALqrOpf.deltaVec-repmat(ALqrOpf.deltaS,1,length(t)), Opf.deltaVec-repmat(Opf.deltaS,1,length(t))])));
DeltayMin=min(min(radians2degrees([LqrOpf.deltaVec-repmat(LqrOpf.deltaS,1,length(t)),...
    ALqrOpf.deltaVec-repmat(ALqrOpf.deltaS,1,length(t)), Opf.deltaVec-repmat(Opf.deltaS,1,length(t))])));

DeltayOffSet=0.01;

x0=0;
y0=1;
width=8;
height=5;
Figure2=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(Figure2, 'Name', 'GenAngle');
plot(t,radians2degrees(LqrOpf.deltaVec)-radians2degrees(repmat(LqrOpf.deltaS,1,length(t))),'lineWidth',2);
 xlabel('Time (sec)', 'FontWeight','bold');
 ylabel('$\boldmath{\delta}-\boldmath{\delta}^s$ (deg)'); 
axis([0 TFinal DeltayMin-DeltayOffSet DeltayMax+DeltayOffSet]);
set(gca,'box','on');
set(gca,'fontSize',22); 
set(0,'defaulttextinterpreter','latex')
 grid on;
title('Generator angle dev.'); 
if exist('Figures')~=7
    mkdir('Figures'); 
 end

 cd('Figures'); 
  print -dpdf Case39_LQROPF_alphapoint8_LQR.pdf
print -depsc2 Case39_LQROPF_alphapoint8_LQR
cd('..');



%% ALQR-OPF

x0=0;
y0=1;
width=8;
height=5;
Figure2=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(Figure2, 'Name', 'GenAngle');
plot(t,radians2degrees(ALqrOpf.deltaVec)-radians2degrees(repmat(ALqrOpf.deltaS,1,length(t))),'lineWidth',2);
 xlabel('Time (sec)', 'FontWeight','bold');
 ylabel('$\boldmath{\delta}-\boldmath{\delta}^s$ (deg)'); 
axis([0 TFinal DeltayMin-DeltayOffSet DeltayMax+DeltayOffSet]);
set(gca,'box','on');
set(gca,'fontSize',22); 
set(0,'defaulttextinterpreter','latex')
 grid on;
title('Generator angle dev.'); 
if exist('Figures')~=7
    mkdir('Figures'); 
 end

 cd('Figures'); 
  print -dpdf Case39_ALQROPF_alphapoint8_LQR.pdf
print -depsc2 Case39_ALQROPF_alphapoint8_LQR
cd('..');


 
%% OPF

x0=0;
y0=1;
width=8;
height=5;
Figure2=figure('Units','inches',...
'Position',[x0 y0 width height],...
'PaperPositionMode','auto');
set(Figure2, 'Name', 'GenAngle');
plot(t,radians2degrees(Opf.deltaVec)-radians2degrees(repmat(Opf.deltaS,1,length(t))),'lineWidth',2);
 xlabel('Time (sec)', 'FontWeight','bold');
 ylabel('$\boldmath{\delta}-\boldmath{\delta}^s$ (deg)'); 
axis([0 TFinal DeltayMin-DeltayOffSet DeltayMax+DeltayOffSet]);
set(gca,'box','on');
set(gca,'fontSize',22); 
set(0,'defaulttextinterpreter','latex')
 grid on;
title('Generator angle dev.'); 
if exist('Figures')~=7
    mkdir('Figures'); 
 end

 cd('Figures'); 
  print -dpdf Case39_OPF_alphapoint8_LQR.pdf
print -depsc2 Case39_OPF_alphapoint8_LQR
cd('..');



