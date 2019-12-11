function [acc,dtacc] = readNGARecord(filename)
%
% Read earthquake data from a NGAWest2-compatible ASCII file
%
% [#acc#,#dtacc#] = readNGARecord(#filename#)
%
% Description
%     This function is used to read the earthquake record time history data
%     from an external NGAWest2-compatible ASCII file. This function is
%     compatible with the format of the files that are downloaded by the
%     NGAWest2 earthquake database. The link for downloading these records
%     is the following:
%     https://ngawest2.berkeley.edu/spectras/147393/searches/new
%
% Input parameters
%     #filename# (row string): is the name of the NGAWest2-compatible ASCII
%         file being read.
%
% Output parameters
%     #acc# ([#m# x 1]): is the time history data being read from the file.
%     #dtacc# (scalar): time step of the time history data being read from
%         the file.
%
%__________________________________________________________________________
% Copyright (c) 2019
%     George Papazafeiropoulos
%     Captain, Infrastructure Engineer, Hellenic Air Force
%     Civil Engineer, M.Sc., Ph.D. candidate, NTUA
%     Email: gpapazafeiropoulos@yahoo.gr
% _________________________________________________________________________


fid=fopen(filename);
if fid<0
    error('Unable to open record file')
end

skipline=3;
for i=1:skipline+1
    tline = fgetl(fid);
end
match1 = strfind(lower(tline),'npts=');
match2 = strfind(lower(tline),'dt=');
match3 = strfind(lower(tline),',');
match4 = strfind(lower(tline),'se');

nsteps=str2double(tline(match1+5:match3(1)-1));
if nsteps<=0
    disp('ERROR: not able to find DT or NPTS');
    return;
end

dtacc=str2double(tline(match2+3:match4-1));
if dtacc<=0
    disp('ERROR: not able to find DT or NPTS');
    return;
end

cac = textscan(fid,'%f%f%f%f%f','Headerlines',skipline+1,'CollectOutput',true );

fclose(fid);

acc = cac{1};
acc=acc';
acc=acc(:);

end