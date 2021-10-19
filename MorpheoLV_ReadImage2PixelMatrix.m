%----------------------------------------------
% Read the image to get a B&W pixel matrix
%----------------------------------------------
function [MI,HI,LI]=MorpheoLV_ReadImage2PixelMatrix(GrainName,ThresholdBW)
% INPUT: File name, Threshold for the B&W conversion
% OUTPUT: Pixel matrix: MI, [HI,LI]=size(MI)

%----------------------------------------------
% Read a truecolor, grey level or B&W image
%----------------------------------------------
   [A,map] = imread(GrainName); [HI,LI] = size(A); %height HI and length LI of the image
% Test if the image is duplicate twice (case of truecolor images)
   if (mod(LI,3)==0)
      if (A(1:HI,1:LI/3)==A(1:HI,LI/3+1:LI/3*2))
% if .true. then remove the last two copies
         LI=LI/3; MI=zeros(HI,LI); MI(1:HI,1:LI)=A(1:HI,1:LI); clear A; 
      else
         MI=A; clear A;
      end
   end

%----------------------------------------------
% True color or grey level image to BW image
%----------------------------------------------
% The ThresholdBW may be changed with respect to the image quality
% It doesn't matter if white pixel remains far inside the the particle
% The importat point is to capture the particle boundary in a fair manner,
% that is to avoid holes close to the boundary
  if MI(1,1)==0  %BW image
     if (max(max(MI))>1), MI = (round((double(MI))/255));end
  else           %True color image
     if (max(max(MI))>1), MI = (round((double(MI)+ThresholdBW)/255)-1)*(-1);end
  end

%Copyright (c) 2016, CNRS and University of Strasbourg, France
%All rights reserved.

%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

%1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

%2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

%3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
