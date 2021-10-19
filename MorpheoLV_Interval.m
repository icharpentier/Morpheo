function [MeanRc]=MorpheoLV_Interval(IntervalName, NbPoints, ThresholdBW)
% Compute the mean roughness coefficient for the grain sample belonging to the interval under study

close all
%% INPUTS: 
% IntervalName: name of the folder/interval containing the particle images
% NbPoints: number of points used in the FFT 
% ThresholdBW: Black & White threshold
% OUTPUT
% Roughness coefficients for the interval
% MeanRc: mean roughness coefficients for the interval
% Plot and histogram, save it as png and fig files

% Within Matlab, the number of arguments may be variable
% Three arguments may be used
% Default input values
if nargin < 2, NbPoints = 256; end  
if nargin==2, ThresholdBW=0; end

%% No full test is made on the nature of the file, the folder is assumes to contain image files, the format of which is JPG/jpg/TIF/tif
IntervalList = dir(IntervalName);
[nbint,l]=size(IntervalList);  % nbf contains the number of file in the folder (l=1 normally)

if nbint==0, fprintf('Wrong folder name/path for the interval'); return; end
Rc=[];

% call Morpheo for each of the images
% first image of the folder 
% classically with the dir command, the first two names of imagelist are '.' and '..')
% the first image is thus related the third name
	i=1; GrainName=strcat(IntervalName,'/',IntervalList(i+2).name);
        % test if the file is an image from its extension
	if (MorpheoLV_IsAnImage(GrainName))
	% call Morpheo for this image and computes the roughness coefficient Rc
           [Rc]=MorpheoLV_Grain(GrainName,NbPoints,ThresholdBW,0);
        end

% do the same for the other images of the folder
% and store power spectrums and roughness coefficients in array
while i < nbint-2
    	i=i+1; GrainName=strcat(IntervalName,'/',IntervalList(i+2).name);
        if (MorpheoLV_IsAnImage(GrainName))
    	   [Rc1]=MorpheoLV_Grain(GrainName,NbPoints,ThresholdBW); [Rc]=[Rc Rc1];
        end
end
fprintf('\n');
fprintf('Roughness coefficients for interval %s\n',IntervalName);
disp(Rc)
% Mean and standard deviation for the interval
fprintf('%s%d  %s%d  \n','Mean: ',mean(Rc), 'Std Deviation: ',std(Rc));
% Morpheo histogram for the interval
MorpheoLV_HistoClass(IntervalName,Rc);


%Copyright (c) 2016, CNRS and University of Strasbourg, France
%All rights reserved.

%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

%1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

%2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

%3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
