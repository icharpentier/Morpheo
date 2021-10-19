%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       outline to signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [theta,r]=MorpheoLV_outline2signal(NbPoints,outline)

% create a complex coordinate outline from the outline
complexoutline=complex(outline(:,1),outline(:,2));
[Hc,Lc]=size(complexoutline); signal_=zeros(Hc,2);
% compute angles and radius for each of the complex coordinate
signal_(:,1)=(angle(complexoutline));  % angle     
signal_(:,2)=(abs(complexoutline));    % radius

% sort  the angles 
B=zeros(Hc,2); [B,Ix]=sort(signal_(:,:),1);
% eliminate repetitions
ind=1; B(1,1:2)=signal_(Ix(1),1:2);
for j=2:Hc
    if (B(ind,1)~=signal_(Ix(j),1)) && (B(ind,2)~=signal_(Ix(j),2))
        ind=ind+1; B(ind,1:2)=signal_(Ix(j),1:2);
    end
end
signal=zeros(ind,2); signal=B(1:ind,1:2); Hc=ind;

theta_=zeros(Hc+1,1); r_=zeros(Hc+1,1);
theta_=signal(:,1);   r_=signal(:,2);
theta_(Hc+1,1)=signal(1,1)+2*pi; r_(Hc+1,1)=signal(1,2);

%Interpolation
theta=zeros(NbPoints,1);
theta(:,1)=[(-pi+2*pi/(NbPoints)): 2*pi/(NbPoints):pi];
r=interp1(theta_,r_,theta,'linear','extrap');

% Normalization: mean_radius=1;       
r=r/mean(r);


    %%%%%%%%%%
% interpolation
%yi = interp1(x,Y,xi,method) interpolates using alternative methods:
%'nearest'  : Nearest neighbor interpolation
%'linear'   : Linear interpolation (default)
%'spline'   : Cubic spline interpolation
%'pchip'    : Piecewise cubic Hermite interpolation
%'cubic'    : (Same as 'pchip')
% 'v5cubic' : Cubic interpolation used in MATLAB 5

%Copyright (c) 2016, CNRS and University of Strasbourg, France
%All rights reserved.

%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

%1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

%2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

%3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
