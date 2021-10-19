%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       OUTLINE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% find the pixels bordering the particle
% the resulting outline may contain the same pixels twice
function [outline]=MorpheoLV_OutlineDetection(MI);
[H,L]=size(MI); 
HL=2*(H+L);         % perimeter of the image
elist=zeros(HL,2);  % provisional list of edge pixels (abscissa,ordinate)
    
ind=0;
for i=1:H
% line by line         
   if (sum(MI(i,:)) ~=0)
% if the line contains pixels
% find the white pixels, C contains "ones", I contains the pixel index of maximum elements
      [C,I]=max(MI(i,:));
      ind=ind+1; elist(ind,1)=i; elist(ind,2)=I;      %pixel closest to the right border of the image
      [C,I]=max(fliplr(MI(i,:)));
      ind=ind+1; elist(ind,1)=i; elist(ind,2)=L-I+1;  %pixel closest to the left border 
    end
end
% column per column
for j=1:L
    if (sum(MI(:,j)) ~=0)
        [C,I]=max(MI(:,j));
        ind=ind+1; elist(ind,1)=I; elist(ind,2)=j;    %pixel closest to the upper border 
        [C,I]=max(flipud(MI(:,j)));
        ind=ind+1; elist(ind,1)=H-I+1; elist(ind,2)=j;%pixel closest to the lower border 
    end
end
outline=zeros(ind,2); outline=elist(1:ind,1:2);

%Copyright (c) 2016, CNRS and University of Strasbourg, France
%All rights reserved.

%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

%1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

%2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

%3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
