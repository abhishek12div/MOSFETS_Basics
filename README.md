## MOSFETS Basics
#### nMOS, pMOS Modeling in VHDL-AMS-for use in Amplifiers
### PMOS
##### 1. Region1: Cut Off
###### Vsg <= |Vth| 
##### 2. Region2: Triode
###### Vsg > |Vth| ; Vsd <= Vsg - |Vth|
##### 3. Region3: Saturation
###### Vsg > |Vth| ; Vsd > Vsg - |Vth|
### NMOS
##### 1. Region1: Cut Off
###### Vgs <= Vth 
##### 2. Region2: Triode
###### Vgs > Vth ; Vds <= Vgs - Vth
##### 3. Region3: Saturation
###### Vgs > Vth ; Vds > Vgs - Vth
