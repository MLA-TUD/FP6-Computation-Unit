library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity sa is	-- systolic array
	port (
		a : in std_1d_vector_array(0 to array_size-1);						-- input 1: (top)	1-dimensional array of: 8-bit signed (2k) data
		b : in std_1d_vector_array(0 to array_size-1);						-- input 2: (left)	1-dimensional array of: 8-bit signed (2k) data
		c : in std_logic;													-- clock
		r : in std_logic;													-- reset (each cell (-> d) to "00000000")
		d : out std_2d_vector_array(0 to array_size-1, 0 to array_size-1)	-- output: (back)	2-dimensional array of: 8-bit signed (2k) data
	);
end sa;

architecture behavior of sa is
	component mac is	-- multiply-accumulate unit
		port (
			a : in std_logic_vector(7 downto 0);	-- input: 1: 8-bit signed (2k) data
			b : in std_logic_vector(7 downto 0);	-- input: 2: 8-bit signed (2k) data
			c : in std_logic;						-- clock
			r : in std_logic;						-- reset (to "00000000")
			d : out std_logic_vector(7 downto 0);	-- output 8-bit data (sum of: "a * b")
			e : out std_logic_vector(7 downto 0);	-- output: 1: 8-bit signed (2k) data (= a: delayed by one clock cycle)
			f : out std_logic_vector(7 downto 0)	-- output: 2: 8-bit signed (2k) data (= b: delayed by one clock cycle)
		);
	end component mac;
	
	signal ver : std_2d_vector_array(0 to array_size-1, 0 to array_size);	-- vertical connections
	signal hor : std_2d_vector_array(0 to array_size, 0 to array_size-1);	-- horizontal connections
	
begin
	loop_i_horizontal : FOR i IN 0 TO array_size-1 GENERATE
		-- fill first lines
		ver(i, 0) <= a(i);
		hor(0, i) <= b(i);	-- normally "hor(0, j)", but the sa is quadratic in size and we only fill one dimension here (-> i=j holds)
		
		loop_j_vertical: FOR j IN 0 TO array_size-1 GENERATE
			mac1 : mac port map(a => ver(i, j), b => hor(i,j), c => c, r => r, d => d(i, j), e => ver(i, j+1), f => hor(i+1, j) );
		END GENERATE;
	END GENERATE;
end behavior;
