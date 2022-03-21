library ieee;
use ieee.std_logic_1164.all;


entity and_gate_two is	
	port (		
        	a,b : in std_logic;
        	o : out std_logic	
	);
end and_gate_two;

architecture behavior of and_gate_two is
begin	
	o <= a and b;
end behavior;
