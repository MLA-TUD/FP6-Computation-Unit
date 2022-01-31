library ieee;
use ieee.std_logic_1164.all;

package a is
	type std_1d_vector_array is array(0 to 8) of std_logic_vector(7 downto 0);
	type std_2d_vector_array is array(0 to 8, 0 to 8) of std_logic_vector(7 downto 0);
end package a;

library work;
use work.a.all;

library ieee;
use ieee.std_logic_1164.all;

entity sa is -- systolic array
	generic ( -- size: of the array
		size : positive := 8
	);
	port ( -- c: clock; r: reset
		a : in std_1d_vector_array; -- upper side
		b : in std_1d_vector_array; -- left side
		c : in std_logic;
		r : in std_logic;
		d : out std_2d_vector_array
	);
end sa;

architecture behavior of sa is
	component mac is -- multiply-accumulate unit
		port ( -- c: clock; r: reset
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic;
			d : out std_logic_vector(7 downto 0)
		);
	end component mac;
	
	-- ?
begin
	-- ?
end behavior;
