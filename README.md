# Morpheo
Particle shape analysis with the Matlab tool MORPHEO
----------------------------------------------------


The MorpheoLV library has been written by 
	Isabelle Charpentier, CNRS, Icube (UMR 7357), Strasbourg

Companion papers:
[1] Alicia B. Staszyc, Isabelle Charpentier, Julia S. Wellner, Vanessa Alejandro, A reliable method for quantifying grain shape: A case study in Holocene glacial marine sediments, submitted.
[2] I. Charpentier, D. Sarocchi and L.A. Rodriguez Sedano (2013) Particle shape analysis of volcanic clast samples with the Matlab tool MORPHEO, Computers & Geosciences, 51: 172--181.

MorpheoLV is a Matlab program intended for the quantification of grain morphology through Fourier analysis.

The current version provides:
* routines for the analysis of an image containing a unique grain. As described in [1], MorpheoLV: 
  - turns the image into black and white leaving only the darker pixels,
  - determines the outline of this pixel set in the Cartesian plane,
  - computes the centroid of the particle,   
  - represents the outline as a 1D signal by using polar coordinates (r,theta). 
  - interpolates this signal using a power of two points called NbPoints and representing the number of computed harmonics,
  - normalizes the intrerpolated signal,
  - applies a Fast Fourier Transform Analysis and computes the power spectrum,
  - computes the roughness coefficient described in [1] for this grain.
  This process is organized in the routine MorpheoLV_Grain to be run as follows

  >> MorpheoLV_Grain ('Particle name.jpg',NbPoints), where 'Particle name.jpg' is the file of an image with a jpeg or a tiff extension and NbPoints is set to 256. In [1], MorpheoLV_Grain computes the Rc value in the prescribed harmonic range for this study, a=10 to b=14. This can be changed in  MorpheoLV_Grain at line 24
  
* The routine for the analysis of an interval, i.e. a sample of grains, each of them stored individually, is run following

  >> MorpheoLV_Grain ('Interval name.jpg',NbPoints),
  
  This routine: 
  - runs the former process for each of the grain,
  - computes the average roughness coefficient and the standard deviation of the sample,
  - plots a histogram of the roughness coefficients

* The routine for the analysis of a core, i.e. a sample of intervals, is run following

  >> MorpheoLV_core ('Core name.jpg',NbPoints),
  
  This routine: 
  * runs the grain image processing described above for each of the intervals (in this version depth is assumed to be provided through the interval names),
  * computes the average roughness coefficient and the standard deviation of each of the interval,
  * plots the roughness coefficients and standard deviations along the depth.

* some interval data,

* this README.txt file.


I. Licensing
------------
Copyright (c) 2016, CNRS and University of Strasbourg, France
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

II. Installing
--------------
MorpheoLV is distributed as the zip file: MorpheoLV.zip
and may be installed with the following command:

$ unzip MorpheoLV.zip

This creates the MorpheoLV repository containing the sources (filenames with .m extension) and the core repository continaing a very few intervals with their grains for replicability experiments.

III. Compiling and path setting
-------------------------------
These Matlab do not require any compilation, but pay attention to be in the appropriate data repository and set the path to the matlab files.

Matlab path should be set so as to include MorpheoLV repository


IV.1 Results of the code
------------------------
These are described in [1]. Some details and reference results are presented hereafter.

MorpheoLV is provided with the last three intervals of the core studied in [1].

Pay attention to the tricky white space characters in the names 

IV.1 Results of the code for a grain analysis
---------------------------------------------
In the matlab command window:
  move to the interval repository (pay attention to white space characters. The Matlab completion write them as a ')

>> cd NBP1203' JPC36'/NBP1203' JPC36 20.71-20.72m'/

   run the MorpheoLV command

>> tic; MorpheoLV_Grain('Particle-94697nm-80.JPG',256), toc
Roughness coefficient 8.417311e-03

ans =

    0.0084

Elapsed time is 2.568198 seconds.

This also open five figures continaing : the RGB grain, the BW grain, its outline and centroid, its signal, its power spectrum. These plot are not saved in an automatic fashion. The time measure is mainlys concerned with visualization.

IV.2 Results of the code for an interval analysis
-------------------------------------------------
This paragraph reports results obtained on these three intervals.

Once a command is run (>> commad), the Matlab command window yields 
 * text: roughness coefficients, the mean and standard deviation over the sudied sample/interval 
 * plot: the histogram over the studied sample/interval 
 
In the  NBP1203 JPC36 repository

>> tic; MorpheoLV_Interval ('NBP1203 JPC36 6.81-6.82m',256), toc
Roughness coefficients for interval NBP1203 JPC36 6.81-6.82m
  Columns 1 through 6

    0.0069    0.0046    0.0031    0.0022    0.0050    0.0089

  Columns 7 through 12

    0.0050    0.0061    0.0101    0.0036    0.0045    0.0047

  Columns 13 through 18

    0.0049    0.0034    0.0029    0.0031    0.0033    0.0046

  Columns 19 through 24

    0.0044    0.0062    0.0044    0.0030    0.0039    0.0048

  Columns 25 through 30

    0.0044    0.0038    0.0051    0.0063    0.0055    0.0032

  Columns 31 through 36

    0.0027    0.0046    0.0044    0.0035    0.0045    0.0036

  Columns 37 through 40

    0.0055    0.0065    0.0022    0.0050

Mean: 4.610181e-03  Std Deviation: 1.621026e-03  
Elapsed time is 0.837688 seconds.

  The histogram plots are saved in the core repository using interval names.
  Filenames are

>> !ls -lt |more
total 204
-rw-rw-r-- 1 charpentier charpentier  6093 avril  7 09:12 NBP1203 JPC36 6.81-6.82m.fig
-rw-rw-r-- 1 charpentier charpentier  8379 avril  7 09:12 NBP1203 JPC36 6.81-6.82m.eps
-rw-rw-r-- 1 charpentier charpentier 11647 avril  7 09:12 NBP1203 JPC36 6.81-6.82m.png

IV.3 Results of the code for a core analysis
--------------------------------------------
When the current repository contains the core repository, the core analysis may be run using the command described above, in in the present zip file we did not provide all the intervals

>> MorpheoLV_Core('NBP1203 JPC36',256,0)

** HERE I REMOVED SOME DATA, THUS RESULTS ARE LIMITED **

  It also produces a figure plotting the mean roughness coefficient related to these 3 depths.
  The resulting figure is saved as NBP1203 JPC36.fig and NBP1203 JPC36.png

V. Brief description of the routines and call graph of the codes
----------------------------------------------------------------
line count, filename, description
(ranked in alphebetical order, line count includes the license clauses)

  100 MorpheoLV_Core.m
  112 MorpheoLV_Grain.m
   40 MorpheoLV_HistoClass.m
   66 MorpheoLV_Interval.m
   27 MorpheoLV_IsAnImage.m
   23 MorpheoLV_Outline2Centroid.m
   59 MorpheoLV_Outline2Signal.m
   45 MorpheoLV_OutlineDetection.m
   26 MorpheoLV_OutlinePlot.m
   21 MorpheoLV_PowerSpectrum.m
   21 MorpheoLV_PrintSaveFig.m
   21 MorpheoLV_Rc.m
   46 MorpheoLV_ReadImage2PixelMatrix.m
   23 MorpheoLV_TestFile.m
  630 total
