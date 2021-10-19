function []=Morpheo_HistoClass(SampleName,Rc)
% This histogram uses 10 classes ranging from (0,0.001) to (0,0.01) for the Rcs for all the intervals so as to compare them in a fair manner.
% This should be adapted to other studies.
[H,L]=size(Rc);
nbclass=13;
iclass=zeros(nbclass,1); 
% Put the Rcs in their right class
for i=1:L
   Rcfloor=int8(floor(Rc(i)*1000));
   if (Rcfloor>nbclass-1) 
      Rcfloor=nbclass-1;
   end
   iclass(Rcfloor+1)=iclass(Rcfloor+1)+1;
end

h=figure(6); hold on;
% Plot a rectangle for each of the classes 
for i=1:nbclass
   x=[ i-1; i; i; i-1 ; i-1]; y=[ 0; 0; iclass(i); iclass(i); 0];
   x=x*0.001;
   plot(x,y,'-b', 'LineWidth',4); set(gca,'FontSize',16)
end
ylim([0,int8(max(iclass)*1.1)]);
title({SampleName;strcat('Mean Rc: ',num2str(mean(Rc),2),'; Std:  ' ,num2str(std(Rc),2))},'FontSize',28); 
xlabel(strcat('Rc ranges'),'FontSize',24); ylabel('Grain number','FontSize',24);
% save output figures
MorpheoLV_PrintSaveFig(h,SampleName)

%Copyright (c) 2016, CNRS and University of Strasbourg, France
%All rights reserved.

%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

%1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

%2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

%3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
