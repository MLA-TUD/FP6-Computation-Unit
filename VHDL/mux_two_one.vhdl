library ieee;
use ieee.std_logic_1164.all;


entity mux_two_one is	
	port (		
        	a,b,s : in std_logic;
        	o : out std_logic	
	);
end mux_two_one;

architecture behavior of mux_two_one is
	component and_gate_two is
	port (		
        	a,b : in std_logic;
        	o : out std_logic	
	);
	end component and_gate_two;
	component or_gate_two is
	port (		
        	a,b : in std_logic;
        	o : out std_logic	
	);
	end component or_gate_two;
	component not_gate is
	port (		
        	a : in std_logic;
        	o : out std_logic	
	);
	end component not_gate;
signal not_s, andOut1, andOut2 : std_logic;
begin	
	not1 : not_gate port map(a => s, o => not_s);
	and1 : and_gate_two port map(a => a, b => not_s, o => andOut1);
	and2 : and_gate_two port map(a => b, b => s, o => andOut2);
	or1 : or_gate_two port map(a => andOut1, b => andOut2, o => o);
end behavior;
