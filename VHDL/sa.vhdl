library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity sa is -- systolic array
    generic (systolicArraySize:integer := 8;bitSize:integer := 8);
	port ( -- c: clock; r: reset
		upperInputVectors : in std_1d_vector_array(0 to array_size-1); -- upper side
        leftInputVectors : in std_1d_vector_array(0 to array_size-1); -- left side
        clk : in std_logic;
        reset : in std_logic;
        outMatrix : out std_2d_vector_array(0 to array_size-1, 0 to array_size-1)
	);
end sa;

architecture behavior of sa is
	component mac is -- multiply-accumulate unit
		port ( -- c: clock; r: reset
			a : in std_logic_vector((bitSize-1) downto 0); -- in top
			b : in std_logic_vector((bitSize-1) downto 0); -- in left
			c : in std_logic; 
			r : in std_logic;
			d : out std_logic_vector((bitSize-1) downto 0); -- output mac
			e : out std_logic_vector((bitSize-1) downto 0); -- out bottom
            f : out std_logic_vector((bitSize-1) downto 0) -- out right
		);
	end component mac;
	
	signal hor : std_2d_vector_array(0 to systolicArraySize, 0 to systolicArraySize-1);
	signal ver : std_2d_vector_array(0 to systolicArraySize-1, 0 to systolicArraySize);
	
begin
	gen1 : FOR i IN 0 TO systolicArraySize-1 GENERATE
		--fill first lines
		ver(i, 0) <= upperInputVectors(i);
		hor(0, i) <= leftInputVectors(i); -- normally hor(0, j), but the sa is quadratic in size and only travels in one direction
		
		gen2 : FOR j IN 0 TO systolicArraySize-1 GENERATE
			mac1 : mac port map(a => ver(i, j), b => hor(i,j), c => clk, r => reset, d => outMatrix(i, j), e => ver(i, j+1), f => hor(i+1, j) );
		END GENERATE;
	END GENERATE;
	
end behavior;
