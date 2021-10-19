function []=MorpheoLV_Core(CoreName, NbPoints, ThresholdBW)
tic

% Within Matlab, the number of arguments may be variable
% Three arguments may be used
% Default input values
if nargin < 2, NbPoints = 256; end  
if nargin==2, ThresholdBW=0; end

depth=zeros(500,1); depthindex=0;
meanRc=zeros(500,1); stdRc=zeros(500,1); 
indsample=1; X=[]; G=[];

% print roughness means and standard deviations along the core
fprintf('Sample name      mean(Rc)      std(Rc) \n');

% CoreName is the folder name containing the interval folders (called IntervalName)
% No test is made on the nature of IntervalName, the folder is thus assumes to contain intervals forlders only
CoreList = dir(CoreName); 
% nbint contains the number of intervals in the folder (l=1 normally)
[nbint,l]=size(CoreList); 

% call Morpheo for each of the interval
cd(CoreName)
j=0;
while j < nbint-2
   j=j+1; IntervalName=CoreList(j+2).name;

if isdir(IntervalName)
        % IntervalName is a directory to explore (should be an actual interval repository)
        depthindex=depthindex+1;
	% Test to sort out the interval depth
	% Should be adapted if the naming convention is different from those described
   	k1=strfind(IntervalName,'-'); k2=strfind(IntervalName,'m');
   	depth(depthindex)=str2num(IntervalName(k1+1:k2-1));
	% initialisation of PS and rc array for this sample
   	Rc=zeros(1,1);

   	IntervalList = dir(IntervalName);
   	[nbimag,l]=size(IntervalList);

   	i=1; GrainName=IntervalList(i+2).name;
   	cd(IntervalName)
   	% test if the file is an image from its extension
	if (MorpheoLV_IsAnImage(GrainName))
	% call Morpheo for this image and computes the roughness coefficient 
           [Rc]=MorpheoLV_Grain(GrainName,NbPoints,0,ThresholdBW);
        end

   	% do the same for the other images of the folder
   	% and store power spectrums and roughness coefficients in array
   	while i < nbimag-2
      	   i=i+1; GrainName=IntervalList(i+2).name;
      	   % test if the file is an image from its extension
	   if (MorpheoLV_IsAnImage(GrainName))
	   % call Morpheo for this image and computes the roughness coefficient
             [Rc1]=MorpheoLV_Grain(GrainName,NbPoints,0,ThresholdBW); [Rc]=[Rc Rc1];
           end
        end
        cd('..') 
        meanRc(depthindex)=mean(Rc); stdRc(depthindex)=std(Rc);
   end
end
cd('..');
toc

% sort with respect to depth
[d,IX]=sort(depth(1:depthindex),'ascend');
m=meanRc(IX); s=stdRc(IX);
% and print roughness means and standard deviations along the core
for i=1:depthindex
   fprintf('%s %d %d  \n',CoreList(IX(i)+2).name,m(i),s(i));
end

% Plot means and standard deviations along the column
h=figure(1); plot(m,d,'-b',s,d,'-r','LineWidth',3);
set(gca,'YDir','reverse'); set(gca,'FontSize',16)
legend('Mean', 'Standard deviation','Location','South')
title ('Roughness','FontSize',28)
ylabel('Depth (m)','FontSize',24); xlabel('Rc_{10-14}','FontSize',24);
set(gca,'YTick',[ 0.05 5 10  15 20 25]);
set(gca,'YTickLabel',{'0.05', '5',  '10', '15', '20', '25'})
set(gcf,'position',[800 300 360 800]);
cd(CoreName)
MorpheoLV_PrintSaveFig(h,CoreName)
cd('..');
toc

%Copyright (c) 2016, CNRS and University of Strasbourg, France
%All rights reserved.

%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

%1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

%2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

%3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
