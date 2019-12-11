function [n,xgttSuite,L]=NGARecordAssembly(eqmotions,dt)
%
% Load and resample earthquake data from NGAWest2-compatible ASCII files
%
% [#n#,#xgttSuite#,#L#]=NGARecordAssembly(#eqmotions#,#dt#)
%
% Description
%     This function is used to read the earthquake record data from a
%     number of external ASCII files. This function is compatible with the
%     format of the files that are downloaded by the NGAWest2 earthquake
%     database. The link for downloading these records is the following:
%     https://ngawest2.berkeley.edu/spectras/147393/searches/new
%     The following operations are performed:
%     1) The earthquake data are loaded from the external ASCII
%     files that are specified in #eqmotions#. 
%     2) The record time histories are resampled so that their time step is
%     equal to #dt#. All the acceleration time histories in #xgttSuite#
%     have the same time step #dt#.
%     3) The record time histories are checked for non-consecutive or
%     trailing NaNs. In the first case an error is issued, whereas in the
%     second case the trailing NaN are truncated.
%
% Input parameters
%     #eqmotions# ({#n# x 1}): cell array containing the names of the
%         NGAWest2-compatible ASCII files to be processed, including their
%         extensions.
%     #dt# (scalar): is the time step according to which the time history
%         data loaded from the ASCII files are resampled.
%
% Output parameters
%     #n# (scalar): number of the earthquake record time histories the data
%         of which are assembled into #xgttSuite#.
%     #xgttSuite# ({#n# x 1}): cell array containing the time-history data
%         of the earthquake records. Each cell of #xgttSuite# contains the
%         time history data in a column vector.
%     #L# (scalar): maximum length of the time histories contained in the
%         cells of #xgttSuite#.
%
%__________________________________________________________________________
% Copyright (c) 2019
%     George Papazafeiropoulos
%     Captain, Infrastructure Engineer, Hellenic Air Force
%     Civil Engineer, M.Sc., Ph.D. candidate, NTUA
%     Email: gpapazafeiropoulos@yahoo.gr
% _________________________________________________________________________


n=numel(eqmotions);
L=0;
% Initialize
xgttSuite=cell(n,1);
for i=1:n
    % earthquake
    [xgtti,dti] = readNGARecord(eqmotions{i});
    % resample so that the time step is equal for all acceleration time
    % histories
    [d1,d2] = rat(dti/dt);
    [xgtt,by] = resample(xgtti,d1,d2);
    
    NANxgtt=find(isnan(xgtt));
    errxgtt=find(diff(NANxgtt)>1);
    if any(errxgtt)
        error('Non consecutive NaNs!!!')
    end
    if any(NANxgtt)
        xgtt = xgtt(1:NANxgtt(1)-1);
    end
    
    % plot for verification of the resampling procedure
    %plot((0:dti:dti*(numel(xgtti)-1))',xgtti)
    %hold on
    %plot((0:dt:dt*(numel(xgtt)-1))',xgtt)
    
    % acceleration time histories
    xgttSuite{i}=xgtt;
    
    L=max(L,numel(xgtt));
end

xgttSuite=xgttSuite(~cellfun('isempty',xgttSuite));
n=numel(xgttSuite);

end