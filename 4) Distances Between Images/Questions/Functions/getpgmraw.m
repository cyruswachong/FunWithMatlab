% getpgmraw.m 
% -----------
%
% function  [pic,maxgray]=getpgmraw(filename)
%
%
%  AUTHOR: A.S. Georghiades
%    DATE: April 28, 1997
% PURPOSE:
%         Reads gray scale PGM (raw) images.
%
% ARGUMENTS: 
%         filename: A string containing the name of the image file to be read.
%
% RETURNS:
%         pic: The gray scale image in an array.
%     maxgray: The maximum pixel value in pic. Usually 255.
%
% (No dependancies)
%
  
function [pic,maxgray]=getpgmraw(filename)



%% Open file.
%
 filename(findstr(filename,' '))=[];
 fid=fopen(filename);


%% If not PGM then exit with an error message
%.
 code=fscanf(fid,'%s',1);
 if (code ~= 'P5')
	error('Not a PGM (raw) image');
 end


%% Get width.
%
 width=[];
 while (isempty(width))
   [width,cnt]=fscanf(fid,'%d',1);
   if (cnt==0)
     fgetl(fid);
   end
 end

%% Get height.
%
 height=fscanf(fid,'%d',1);

%% Get max gray value.
%
 maxgray=fscanf(fid,'%d',1);


%% Read actual data.
%
 cnt=fread(fid,1);		% newline
 pic=fread(fid,[width,height])';


%% Close file.
%
 fclose(fid);

