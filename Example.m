%% Example
% This example shows how to read and resample earthquake record time
% histories from external ASCII files that can be downloaded from the
% Pacific Earthquake Engineering Research Center (PEER) Ground Motion Data
% Base, available at the following link:
%
% <https://ngawest2.berkeley.edu/users/sign_in?unauthenticated=true> 
%
% and hosted by the University of California, Berkeley, CA. Initially the
% user must download an earthquake record suite from this website and save
% all ASCII files inside the folder 'Records' of this package.
% 
% After downloading the various records from the above data base, this main
% script is run to load and resample the time history data of the ASCII
% files, assemble them in cell arrays and plot them.
%
% The time histories read in this example include displacement, velocity
% and acceleration, both for horizontal and vertical components of the
% earthquakes considered.
%
% After reading the time history data from an ASCII file, the time history
% data are resampled, i.e. the time step of the data is adjusted to a new
% value that is specified by the user.
% 

%% Install directory
S=mfilename('fullpath');
f=filesep;
ind=strfind(S,f);
S1=S(1:ind(end)-1);
addpath(genpath(S1));
cd(S1)

%% Read and resample the vertical components of the suite

%%
% Specify the time step of the vertical components
dt=0.02;

%%
% File names ending in 'UP'
S = dir([S1,'\Records\*UP.*']);
C={S.name};
eqmotionsVer=C(:);

%%
% File names ending in 'DWN'
S = dir([S1,'\Records\*DWN.*']);
C={S.name};
eqmotionsVer=[eqmotionsVer;C(:)];

%%
% File names ending in '-V'
S = dir([S1,'\Records\*-V.*']);
C={S.name};
eqmotionsVer=[eqmotionsVer;C(:)];

%%
% File names ending in '-Z'
S = dir([S1,'\Records\*-Z.*']);
C={S.name};
eqmotionsVer=[eqmotionsVer;C(:)];

%%
% File names ending in '-Z'
S = dir([S1,'\Records\*UD.*']);
C={S.name};
eqmotionsVer=[eqmotionsVer;C(:)];

%%
% Read files containing time histories of vertical components
[n,timeHistVer,L]=NGARecordAssembly(eqmotionsVer,dt);

%%
% Number of vertical components
n

%%
% Maximum duration of the vertical components
L

%%
% Vertical displacement components
DT2=strfind(eqmotionsVer,'DT2');
DT2indV=~cellfun('isempty',DT2);
xgVert=timeHistVer(DT2indV);

%%
% Vertical acceleration components
VT2=strfind(eqmotionsVer,'VT2');
VT2indV=~cellfun('isempty',VT2);
xgtVert=timeHistVer(VT2indV);

%%
% Vertical acceleration components
AT2=strfind(eqmotionsVer,'AT2');
AT2indV=~cellfun('isempty',AT2);
xgttVert=timeHistVer(AT2indV);

%% Read and resample the horizontal components of the suite

%%
%
S = dir([S1,'\Records\*.*']);
C={S.name};

%%
% Delete single and double dots
C(1:2)=[];

%%
% Load all file names inside the 'Records' folder
eqmotions=C(:);

%%
% Find indices of horizontal motions
ind1=strfind(eqmotions,'UP.');
ind1=~cellfun('isempty',ind1);
ind2=strfind(eqmotions,'DWN.');
ind2=~cellfun('isempty',ind2);
ind3=strfind(eqmotions,'-V.');
ind3=~cellfun('isempty',ind3);
ind4=strfind(eqmotions,'-Z.');
ind4=~cellfun('isempty',ind4);
ind5=strfind(eqmotions,'UD.');
ind5=~cellfun('isempty',ind5);

%%
% Retain only the file names corresponding to horizontal ground motions
ind=(~ind1) & (~ind2) & (~ind3) & (~ind4) & (~ind5);
eqmotionsHor=eqmotions(ind);

%%
% Read files containing time histories of horizontal components
[n,timeHistHor,L]=NGARecordAssembly(eqmotionsHor,dt);

%%
% Number of horizontal components
n

%%
% Maximum duration of the horizontal components
L

%%
% Horizontal displacement components
DT2=strfind(eqmotionsHor,'DT2');
DT2indH=find(~cellfun('isempty',DT2));
xgHor=timeHistHor(DT2indH);

%%
% Horizontal velocity components
VT2=strfind(eqmotionsHor,'VT2');
VT2indH=find(~cellfun('isempty',VT2));
xgtHor=timeHistHor(VT2indH);

%%
% Horizontal acceleration components
AT2=strfind(eqmotionsHor,'AT2');
AT2indH=find(~cellfun('isempty',AT2));
xgttHor=timeHistHor(AT2indH);

%%
% Plot the horizontal displacement time histories, first component
figure(1)
hold on
for i=1:2:size(xgHor,1)
    plot(xgHor{i})
end
leg=legend(eqmotionsHor(DT2indH(1:2:end)));
set(leg,'Interpreter','none');

%%
% Plot the horizontal displacement time histories, second component
figure(2)
hold on
for i=2:2:size(xgHor,1)
    plot(xgHor{i})
end
leg=legend(eqmotionsHor(DT2indH(2:2:end)));
set(leg,'Interpreter','none');

%%
% Plot the horizontal velocity time histories, first component
figure(3)
hold on
for i=1:2:size(xgtHor,1)
    plot(xgtHor{i})
end
leg=legend(eqmotionsHor(VT2indH(1:2:end)));
set(leg,'Interpreter','none');

%%
% Plot the horizontal velocity time histories, second component
figure(4)
hold on
for i=2:2:size(xgtHor,1)
    plot(xgtHor{i})
end
leg=legend(eqmotionsHor(VT2indH(2:2:end)));
set(leg,'Interpreter','none');

%%
% Plot the horizontal acceleration time histories, first component
figure(5)
hold on
for i=1:2:size(xgttHor,1)
    plot(xgttHor{i})
end
leg=legend(eqmotionsHor(AT2indH(1:2:end)));
set(leg,'Interpreter','none');

%%
% Plot the horizontal acceleration time histories, second component
figure(6)
hold on
for i=2:2:size(xgttHor,1)
    plot(xgttHor{i})
end
leg=legend(eqmotionsHor(AT2indH(2:2:end)));
set(leg,'Interpreter','none');

%%
% Plot the vertical displacement time histories
figure(7)
hold on
for i=1:size(xgVert,1)
    plot(xgVert{i})
end
leg=legend(eqmotionsVer(DT2indV));
set(leg,'Interpreter','none');

%%
% Plot the vertical velocity time histories
figure(8)
hold on
for i=1:size(xgtVert,1)
    plot(xgtVert{i})
end
leg=legend(eqmotionsVer(VT2indV));
set(leg,'Interpreter','none');

%%
% Plot the vertical acceleration time histories
figure(9)
hold on
for i=1:size(xgttVert,1)
    plot(xgttVert{i})
end
leg=legend(eqmotionsVer(AT2indV));
set(leg,'Interpreter','none');

%%
%  ________________________________________________________________________
%  Copyright (c) 2019
%  George Papazafeiropoulos
%  Captain, Infrastructure Engineer, Hellenic Air Force
%  Civil Engineer, M.Sc., Ph.D. candidate, NTUA
%  Email: gpapazafeiropoulos@yahoo.gr
%  ________________________________________________________________________

