library ieee;
use ieee.std_logic_1164.all;


entity and_gate_three is	
	port (		
        	a,b,c : in std_logic;
        	o : out std_logic	
	);
end and_gate_three;

architecture behavior of and_gate_three is
begin	
	o <= a and b and c;
end behavior;
