library ieee;
use ieee.std_logic_1164.all;


entity or_gate_two is	
	port (		
        	a,b : in std_logic;
        	o : out std_logic	
	);
end or_gate_two;

architecture behavior of or_gate_two is
begin	
	o <= a or b;
end behavior;
