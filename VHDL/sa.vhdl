library ieee;
use ieee.std_logic_1164.all;

entity sa is -- systolic array
	generic (
		matrix_size : positive := 8
	);
	port ( 
        c: std_logic
		--a : in array(matrix_size, matrix_size) of std_logic_vector(7 downto 0);
		--b : in array(matrix_size, matrix_size) of std_logic_vector(7 downto 0);
		--c : in std_logic;
		--r : in std_logic;
		--d : out array(matrix_size, matrix_size) of std_logic_vector(7 downto 0)
	);
end sa;

architecture behavior of sa is
	component fifo is -- first-in first-out (parallel-in parallel-out)
		port ( -- c: clock
			a : in std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic;
			b : out std_logic_vector(7 downto 0)
		);
	end component fifo;
	
	component mac is -- multiply-accumulate unit
		port ( -- c: clock
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic
		);
	end component mac;
	
	-- ?
begin
	-- ?
end behavior;
