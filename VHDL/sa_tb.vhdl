library ieee;
use ieee.std_logic_1164.all;

entity sa_tb is -- systolic array testbench
end sa_tb;

architecture test of sa_tb is
	component sa is -- systolic array
		generic (
			matrix_size : positive := 8
		);
		port ( -- c: clock; r: reset
			a : in array(matrix_size, matrix_size) of std_logic_vector(7 downto 0);
			b : in array(matrix_size, matrix_size) of std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic;
			d : out array(matrix_size, matrix_size) of std_logic_vector(7 downto 0)
		);
	end component sa;

	-- ?
begin
	systolic_array: sa port map( ? );
	
	process begin
		-- ?
		wait;
	end process;
end test;