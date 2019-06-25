LIBRARY ieee;
LIBRARY std;
USE	std.ALL;
USE	ieee.ALL;

ENTITY NMOS IS
	GENERIC (
		Vth0 : real := 0.7;		--zero bias threshold voltage
		Kn : real := 120.0e-6; 	--un*Cox
		--Kp : real := 40.0e-0.6	--up*Cox
		gamma : real := 0.45; 	--body factor
		PHI : real := 0.9; 		--2*Vfp;(Vfp= electrostatic potential)
		lambda : real := 0.01; 	--Channel length modulation parameter
		tox : real := 40.0e-10;	--oxide thickness in m
		W : real := 10.0e-6;		--device width in m
		Lt : real := 2.0e-6	--total device length in m
		--Ld : real := 0.0 		--Lateral Diffusion Length
		);

	PORT (
		TERMINAL G, S, D, B :  electrical
		);


END ENTITY NMOS;

---------- ARCHITECTURE DECLARATION behaviour ----------
ARCHITECTURE behaviour OF NMOS IS

quantity Vds across Ids through D to S;
quantity Vgs across G to S;
quantity Vsb across S to B;

quantity Vth: real;
quantity Leff: real;

BEGIN

Vth == Vth0 + gamma * (sqrt(PHI - Vsb) - sqrt(PHI)); --Threshold Voltage
Leff == Lt;  -- Effective Length

if Vgs <= Vth use
	Ids == 0.0; --MOS is Turned OFF
elsif Vds <= (Vgs - Vth) use --Triode Region
	Ids == Kn * (W/Leff) * ((Vgs - Vth)*Vds - 0.5*Vds**2.0) * (1.0 + lambda*Vds);
else --Saturation Region
	Ids == 0.5 * Kn *(W/Leff) * (Vgs - Vth)**2.0 * (1.0 + lambda*Vds);
end use;
	

END ARCHITECTURE behaviour;
