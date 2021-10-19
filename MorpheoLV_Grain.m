function [Rc]=MorpheoLV_Grain(GrainName, NbPoints, ThresholdBW, DisplayGrain)
%Compute the roughness coefficient of the grain under study
% INPUTS: 
% GrainName: name of the image containing the particle
% NbPoints: number of points used in the FFT 
% DisplayGrain:  Display option
% ThresholdBW: Black & White threshold
% OUTPUT
% Rc: Roughness coefficient of the particle 
% Various plots when DisplayGrain==1

% Within Matlab, the number of arguments may be variable
% Four arguments are used when MorpheoLV_Grain is called from MorpheoLV_Histo or MorpheoLV_Core to avoid to display particle images, signals, and powespectrums
% Default input values
if nargin < 2, NbPoints = 256; end  
if nargin==2, DisplayGrain=1; ThresholdBW=0; end
if nargin==3, DisplayGrain=0; end

%----------------------------------------------
% Rc range
% Livsey(2013) a=17, b=21 (also used in the proceeding "powders&grains 2017")
% a=10, b=14 (in the paper submitted to JSR)
%----------------------------------------------
a=10; b=14; 

%----------------------------------------------
% Read the image to get a B&W pixel matrix
%----------------------------------------------
% Pixel matrix: MI, [HI,LI]=size(MI)
[MI,HI,LI]=MorpheoLV_ReadImage2PixelMatrix(GrainName,ThresholdBW);

%----------------------------------------------
% compute the outline of the particle
%----------------------------------------------
% detect the outline as the boundary particles 
[outline]=MorpheoLV_OutlineDetection(MI);
% compute the centroid 
[xCentroid,yCentroid]=MorpheoLV_Outline2Centroid(outline);
% center the outline particle on the centroid of the current outline
CenteredOutline(:,1)=outline(:,1)-xCentroid; CenteredOutline(:,2)=outline(:,2)-yCentroid;
 
%----------------------------------------------                    
% polar decomposition: from a cartesian outline outline to "polar" signal
%----------------------------------------------
[theta,r]=MorpheoLV_Outline2Signal(NbPoints,CenteredOutline);

%----------------------------------------------    
% FFT to compute the power spectrum PS
%----------------------------------------------
[PS]=MorpheoLV_PowerSpectrum(NbPoints,r);

%----------------------------------------------    
% Roughness coefficient
%----------------------------------------------
[Rc]= MorpheoLV_Rc(PS,a,b); 

%----------------------------------------------    
% Display particle's results:
% image together with roughness coefficient
%----------------------------------------------
if DisplayGrain
   close all
   % plot the grain image
   h=figure(1); 
   [A,map] = imread(GrainName); imshow(A);    
   set(gcf,'position',[1 300 200 200]); title(GrainName,'FontSize',28); 
   xlabel(strcat('Roughness coefficient=',num2str(Rc,2)),'FontSize',24)
   MorpheoLV_PrintSaveFig(h,strcat(GrainName,'_image'))
   % plot the BW image
   h=figure(2); 
   imshow(MI); 
   set(gcf,'position',[290 300 200 200]); title('BW Particle after threshold','FontSize',28); 
   xlabel(strcat('Roughness coefficient=',num2str(Rc,2)),'FontSize',24);
   MorpheoLV_PrintSaveFig(h,strcat(GrainName,'_bwimage'))
   % plot the outline and the centroid
   h=figure(3); 
   MorpheoLV_OutlinePlot(outline,xCentroid,yCentroid,HI,LI);
   set(gcf,'position',[495 300 200 200]); title('Particle''s outline ','FontSize',24);
   xlabel(strcat('Roughness coefficient=',num2str(Rc,2)),'FontSize',24);
   MorpheoLV_PrintSaveFig(h,strcat(GrainName,'_outline'))
   % plot the signal
   h=figure(4); 
   plot(theta,r,'-b');
   set(gcf,'position',[700 300 200 200]); title('Particle''s normalized signal','FontSize',28);
   xlim([-pi pi]); set(gca,'XTick',[ -pi -pi/2 0 pi/2 pi ]); 
   set(gca,'XTickLabel',{'-pi','-pi/2','0','pi/2','pi'},'FontSize',16)
   xlabel(strcat('Roughness coefficient=',num2str(Rc,2)),'FontSize',24);
   MorpheoLV_PrintSaveFig(h,strcat(GrainName,'_signal'))
   % plot the power spectrum
   h=figure(5); 
   semilogy(PS(1:33),'-b');
   set(gcf,'position',[905 300 200 200]); title('Power spectrum','FontSize',28);
   xlim([1 33]); set(gca,'XTick',[ 1 9 17 25 33 ]); 
   set(gca,'XTickLabel',{'0','8','16','24','32'})
   xlabel(strcat('Roughness coefficient=',num2str(Rc,2)),'FontSize',24);
   MorpheoLV_PrintSaveFig(h,strcat(GrainName,'_powerspectrum'))
   % print roughness coefficient value
   fprintf('%s %d\n','Roughness coefficient',Rc); 
end

%Copyright (c) 2016, CNRS and University of Strasbourg, France
%All rights reserved.

%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

%1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

%2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

%3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
