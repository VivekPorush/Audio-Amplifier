Audio-Amplifier
===============

This project provides Spice code for Audio Amplifier.

    ****************************************************************
    ***			      Analog And Mixed Signal VLSI                    
    ***		       Audio Amplifier version 0.0.1 by Porush, Vivek  
    ***			<vporus2@uic.edu;vivek.91.porush@gmail.com>          
    ****************************************************************
=====================
General Usage Notes
=====================
	- This particular version is specified for LTSpice.
	- HSPICE does not support “.wav” files as audio inputs and outputs.
	- Max threads are limited to 4 in LTSPice, thus limiting performance & extended
	  simulation times.
	- Power Supply is replaced by two +/- 15 V DC sources from this design because 
	  original supply had setting time constraints and simulation capabilities of host 
	  computer only allowed simulate results up to 2s before it encountered thermal shutdown!!!!
	  (Due to uneven distribution of load b/w CPU & GPU; GPU remains IDEAL!!!!)
	- Power Supply can be included when audio signal is a simple sine wave as it could
	  be easily simulated by host computer.
	- Power Supply can also be included if hardware permits required simulation.

=============
Introduction
=============
    This package contains complete Spice code for an Audio Amplifier implementation on
    LTSpice. Every effort has been made to improve portability of this program. This code
    can be used “as it is” on LTSpice. However, HSPICE portability needs some amendments
    in code.
    
    - HSPICE does not support ".wav" formats, thus input wave must be provided
      in the net-list it self (as a simple sinusoidal wave).
    - Coupling coefficient for individual winding have to be provided on separate
      lines. (for Center Tapped Transformer)
    - Other issues can be reported on below mentioned contact information. 

==========
Features
==========

	-  Mono (channel 1) or Stereo (Channel 2) input from a CD or MP3 player (Audio File)

	-  8 ohm speakers with minimum and maximum gain of -3 dB(0.7V/V) and 20 dB
	   (9.80~10 V/V)with minimum (0.2) distortion over the range of 300 Hz to 10KHz.

	-  Digitally controlled volume with 3 bits on each channel
	
	-  Digital Volum Control is inverted as it is implimented in PMOS logic.
	
	- Genral digital convention follows for Volume control +5 V = 1, 0 V = 0. 

	-  Four-stage LED indicators on each channel corresponding to 0.25V, 0.5V, 1V, 2V.

	-  Maximum Power delivered to 8 ohm resistor is ~ 4W.

==============
Installation
==============
Besides the LTSpice software, you should have VIM, and (optionally) Matlab installed 
on your system. Please follow below mentioned guidelines before you simulate spice file
on your system:-

	- Place all the files in the folder named “Spice” in the same directory.

	- In the file “Audio Amplifier.sp” change directory according to your home directory
	  (command 'pwd' in the terminal to find path of home directory).lib /Users/vivekporush
	  /Desktop/standard.sp ("./lib/" will remain as it is)

	- Further change audio input and output paths & name accordingly in the spice
	  command -"wavefile" & ".wave"

	- After completion of above steps simulation should work. It may take several
	  minutes to complete depending on processing capabilities of your system.

	- Please note that power supply is not included in this file due to computation
	  limitations of host computer. However, its code can be included in this package.

==============================
Block Diagram        
==============================
                                             _________________ ______________
                                             |Digital control| |Audio signal|
                                             _________________ ______________                  
    -----------------------------
    |Ac Mains (120VRMS @ 60 Hz) |-->            V(100) |||          | 
    ----------------------------   |            V(101) |||          | V(12)
                                   |            V(102) |||          |
                                   v                   vvv          v
           |-------------------------|             |----------------|
           |   Power Supply          |------------>|  Volume Control|
           |-------------------------|             |----------------|
                 /               \ \____________________         | 
                /                  \                    \        | V(19)
               v                    V                    v       v
    V(47)<---|-----------|V(35)|---------------|V(21)|——---------------|
    V(48)<---|LED Display|<----|Power Amplifier|<----|Voltage Amplifier|
    V(49)<---|           |     |---------------|     |-----------------|
    V(50)<---|-----------|
                      BLOCK DIAGRAM OF AUDIO AMPLIFIER
                      
===================================
Macros From Other Vendors
===================================
Listed below are the Macros included in this project from other vendors. These files are 
used under educational and research license. Macros are copyrighted products of their 
respective vendors.Please read appropriate license for usage.
    
    ---------------
    Input Files
    ---------------
    LM741.sp   		Operational Amplifier (National Semiconductors)
    guitar.wav 		Input Audio Signal File
                        (freesound.org under Creative Commons 0 License)
    --------------
    Output Files
    --------------
    out.wav    		Output Audio Signal File (24 BPS, Sample rate- 44100)
    <vol>.wav		Output Audio Signal for specified volume 
                        (24 BPS, Sample rate- 44100)
                        effect_of_bps.wav   Output Audio Signal for highest volume  
                        (16 BPS, Sample rate- 56100)
    
===============================
Audio Input Syntax
===============================
LTSpice can read ".wav" audio files. These files can be used as the input of any simulation.

    --------
    |Syntax|
    --------
    <Voltage_Name> <Node_a> <Node_b> <wavefile=> <path_of_file> <channel=1/2>
    ________
    |Example|
    -------- 
    Vaud 12 0 wavefile= /Users/vivekporush/Desktop/q.wav chan=1

================================
Audio Output Syntax
================================
LTSpice can write ".wav" audio files. These files can then be listened to or be used as the 
input of another simulation.

        ________
        |Syntax|
        --------	
        .wave<spice_command> <path_of_output_filename.wav> <bits_per_sample> <sample_rate> <sample_parameter(V/I)>
        ________
        |Example|
        --------
        .wave /Users/vivekporush/Desktop/505ch1.wav 24 44100 V(35)

	- <path_of_output_filename> is either a complete absolute path for the .wav file you
	  wish to create or a relative path computed from the directory containing the
	  simulation schematic or netlist.
	- <bits_per_sample> is the number of sampling bits. The valid range is from 1 to 32 bits.
	- <sample_rate> is the number of samples to write per simulated second. The valid range
	  is from 1 to 4294967295 samples per second.
	- The remainder of the syntax lists the nodes that you wish to save. Each node will be
	  an independent channel in the .wav file. The number of channels may be 	  as few as one
	  or as many as 65535. It is possible to write a device current,e.g., Ib(Q1) as well as 
	  node voltage. The .wav analog to digital converter has a full scale range of -1 to +1
	  Volt or Amp.
    Note that it is possible to write .wav files that cannot be played on your PC sound system
    because of the number of channels, sample rate or number of bits due to limitations of your
    PC's codec.If you want to play the .wav file on your PC sound card, keep in mind that the
    more popularly supported .wav file formats have 1 or 2 channels; 8 or 16 bits/channel; and
    a sample rate of 11025, 22050, or 44100 Hz.

==============================
Summary of Options
==============================
Specified as per the required type of output:

    .wave |.Print |.Plot |.Op |.Tran |.AC
    .wave	- Output file in the .wav extension
    .Print	- Print(log) requested parameters
    .Plot	- Plot(screen) requested parameters
    .Op         - DC Operating point computations
    .Tran	- Transient analysis
    .AC         - AC analysis

=======================================
Macro Model Pin Configuration
=======================================
Listed below is the pin configuration of LM741 used in this project:

    *//////////////////////////////////////////////////////////
    *LM741 OPERATIONAL AMPLIFIER MACRO-MODEL (National Semiconductors)
    *//////////////////////////////////////////////////////////
    *
    * connections:      non-inverting input
    *                   |   inverting input
    *                   |   |   positive power supply
    *                   |   |   |   negative power supply
    *                   |   |   |   |   output
    *                   |   |   |   |   |
    *                   |   |   |   |   |
    .SUBCKT LM741       1   2  99  50  28

===============
Bugs
===============
	- Due to internal parasites and geometry of LM 741, a LPF with cut off frequency of 30 Khz is always present.
	- This interferes with the expected response of device and thus the resultant output is deviated.

===============
Documentation
===============

    Although extensive explanation of code is provided in the attached spice file,
    further details can be found in the reference documentation along with this project.
    However, basic knowledge of circuits along with familiarity with analog VLSI is required.
   Documentation can be found at [My Git Documentation Page](http://vivekporush.github.io)
    
============
Feedback
===========

    If you encounter any bugs or any particular features that are missing,
    please contact me at:

  Porush, Vivek <vporus2@uic.edu> or <vivek.91.porush@gmail.com> or <https://sites.google.com/site/vivekporush91/>
  
    Please feel free to write your macros and extensions.If you send me patches, I will most
    probably include them in future versions of Audio Amplifier and maintain them to the best
    of my abilities.;-) I also appreciate any orthographic and grammatical corrections.
    
    Porush, Vivek
============
Copyright
===========
    Audio Amplifier
    Copyright (C) <2014>  <Porush Vivek>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
