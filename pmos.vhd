LIBRARY ieee;
LIBRARY std;
USE	std.ALL;
USE	ieee.ALL;

ENTITY PMOS IS
	GENERIC (
		Vth0 : real := -0.8;		--zero bias threshold voltage
		--Kn : real := 120.0e-6; 	--un*Cox
		Kp : real := 40.0e-6;	--up*Cox
		gamma : real := 0.4; 	--body factor
		PHI : real := 0.8; 		--2*Vfp;(Vfp= electrostatic potential)
		lambda : real := 0.02; 	--Channel length modulation parameter
		tox : real := 40.0e-10;	--oxide thickness in m
		W : real := 10.0e-6;		--device width in m
		Lt : real := 2.0e-6		--total device length in m
		--Ld : real := 0.0	  	--Lateral Diffusion Length
		);
	PORT (
		terminal G, S, D, B: ELECTRICAL
		);
END ENTITY PMOS;

---------- ARCHITECTURE DECLARATION behav ----------
ARCHITECTURE behav OF pmos IS
quantity Vsd across Isd through S to D;
quantity Vsg across S to G;
quantity Vsb across S to B;

quantity Vth: real;
quantity Leff: real;
	
BEGIN
Vth == Vth0 - gamma * (sqrt(PHI - Vsb) - sqrt(PHI)); --Threshold Voltage
--Leff == Lt - 2.0*Ld;  -- Effective Length
Leff == Lt;

if Vsg <= abs(Vth) use
	Isd == 0.0; --MOS is Turned OFF
elsif Vsd <= (Vsg - abs(Vth)) use --Triode Region
	Isd == Kp * (W/Leff) * ((Vsg - abs(Vth))*Vsd - 0.5*Vsd**2.0) * (1.0 + lambda*Vsd);
else --Saturation Region
	Isd == 0.5 * Kp *(W/Leff) * (Vsg - abs(Vth))**2.0 * (1.0 + lambda*Vsd);
end use;


END ARCHITECTURE behav;
