**************************************************************************************
********************************Audio Amplifier***************************************
**************************************************************************************
***** Porush, Vivek                               e-mail: vporus2@uic.edu*************
*****vivek.91.porush@gmail.com                                                 *******
***Audio Amplifier                                                                 ***
***    Copyright (C) <2014>  <Porush Vivek>                                        ***
***    This program is free software: you can redistribute it and/or modify        ***
***    it under the terms of the GNU Affero General Public License as published by ***
***    the Free Software Foundation, either version 3 of the License, or           ***
***    (at your option) any later version.                                         ***
***                                                                                ***
***    This program is distributed in the hope that it will be useful,             ***
***    but WITHOUT ANY WARRANTY; without even the implied warranty of              ***
***    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the               ***
***    GNU Affero General Public License for more details.                         ***
***                                                                                ***
***    You should have received a copy of the GNU Affero General Public License    ***
***    along with this program.  If not, see <http://www.gnu.org/licenses/>.       ***
***                                                                                ***
*My contact information can be found on <https://sites.google.com/site/vivekporush91/>*
*************************************************************************************
*************This Project is listed under Analog & Mixed Signal VLSI*****************
*************************************************************************************
***Circuit parameters are given as :-->                                           ***
***                                                                               ***
***-->1. Vin = 120 VRMS Sin Wave 60 Hz   \\ Input Voltage \\ \\ Passive \\        ***
***-->2. Vregulated = +/- 15 V Dc       \\DC Regulated Voltage\\ \\Passive\\      ***
***-->3. Vaud =  guitar.wav              \\ Input Audio Signal \\ \\ Passive\\    ***
***-->4. Volume control                                                           ***
***              0.7 V(@ -3db) ~ 10 V(@ 20db)                                     ***
***-->5. Load = 2 channel 8 ohm Speakers \\Load\\Passive                         ***
*************************************************************************************
*************************************************************************************
***Output results :-->                                                            ***
***Obtain requested amplification and verify results.                             ***
***Results are obtained as an output audio file.                                  ***
*************************************************************************************
*************************************SPICE-Code**************************************
*************************************************************************************
**********************************Input-Power-Supply*********************************
*************************************************************************************
*************************************************************************************
* Include Operational Amplifier subcircuit
.INCLUDE 'LM741.sp'
*************************************************************************************
************************************Power Supply*************************************
*************************************************************************************
V+ 7 0 15V
V- 8 0 -15V
**********************************Volume Control*************************************
*************************************************************************************
** Digital input from user (INVERTED AS PMOS)
VMSB 100 0 0V
VM   101 0 0V
VLSB 102 0 0V
** Audio Signal guitar.wav audio file
Vaud 12 0 wavefile= /Users/vivekporush/Desktop/ecgwav_noise.wav chan=1
** DAC Resistor Network for volume control
R1 12 13 14.28K
R2 12 14 1.92K
R3 12 15 3.85K
R4 12 16 7.69K
Rf 13 19 1K
** Input Switches (PMOS) for digital input from user
M1 14 100 13 0 PMOS L=0.5u W=300u
M2 15 101 13 0 PMOS L=0.5u W=300u
M3 16 102 13 0 PMOS L=0.5u W=300u
** OP-Amp Sub Circuit Call to LM741
XOP  0 13 7 8 19 LM741
*************************************************************************************
**********************************Voltage Amplifier**********************************
*************************************************************************************
** Input & Feed-Back resistor network
R21 19 20 1K
R22 20 21 10k
** OP-Amp Sub Circuit Call Voltage Amplifier (Constant Gain Av=10)
X2 0 20 7 8 21 LM741
*************************************************************************************
**********************************Power Amplifier************************************
*************************************************************************************
** Input resistor network
R33  21 39 1u
** Input Coupling capacitor network
C35 39 37 0.1m
C32 38 39 0.1m
** Biasing Resistor network
R31 7 37 3.9k
Q31 7 37 35 0 NPN
** Biasing Diode network
D31 32 37 diode
D32 38 32 diode
R32 38 8 3.9k
Q32 8 38 35 0 PNP
** DC shift resistor network
Rdc 7 35 8
** Load resistor (Speaker)
Rl  35 8 8
*************************************************************************************
**********************************LED Display****************************************
*************************************************************************************
** Voltage reference resistor network
Ra 7 40 54k
Rb 40 44 4k
Rc 44 45 2k
Rd 45 46 1K
Re 46 0 1K
** OP-Amp Sub Circuit Call Comparators for LED Levels
X3 35 40 7 8 47 LM741
X4 35 44 7 8 48 LM741
X5 35 45 7 8 49 LM741
X6 35 46 7 8 50 LM741
** LED Diode Display
D7 0 47 GREEN
D8 0 48 GREEN
D9 0 49 GREEN
D10 0 50 GREEN
** NPN model
.model NPN NPN
** PNP model
.model PNP PNP
** PMOS model
.MODEL PMOS pmos (VTO= 0.7V KP=25u LAMBDA=0.005)
** Diode model
.MODEL diode D (IS=18.8n RS= 0 BV= 400 IBV= 5.00u CJO= 30p M=0.333 N=2.0 TT =0)
** LED Diode model
.Model GREEN D(Is=1e-19 N=2.0 Rs=1.5 Eg=2.23 )
** Output Requested
.tran 1m 1
.wave /Users/vivekporush/Desktop/000ch1.wav 24 44100 V(35)
.End
