library ieee;
use ieee.std_logic_1164.all;


entity n_bit_mux_two_one is
	generic (
		bitSize : integer := 8	
	);	
	port (		
        	a,b : in std_logic_vector(bitSize-1 downto 0);
		s : in std_logic;
        	o : out std_logic_vector(bitSize-1 downto 0)	
	);
end n_bit_mux_two_one;

architecture behavior of n_bit_mux_two_one is
	component mux_two_one is
	port (		
        	a,b,s : in std_logic;
        	o : out std_logic	
	);
	end component mux_two_one;
	
begin	
	gen1 : FOR i IN 0 TO bitSize-1 GENERATE
		mux_two_ones : mux_two_one port map(a=>a(i),b=>b(i),s=>s,o=>o(i));
	END GENERATE;
end behavior;
