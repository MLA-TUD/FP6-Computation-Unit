library ieee;
use ieee.std_logic_1164.all;


entity or_gate_three is	
	port (		
        	a,b,c : in std_logic;
        	o : out std_logic	
	);
end or_gate_three;

architecture behavior of or_gate_three is
begin	
	o <= a or b or c;
end behavior;
