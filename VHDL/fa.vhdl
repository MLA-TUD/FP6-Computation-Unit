library ieee;
use ieee.std_logic_1164.all;

entity fa is	-- full adder
	port (
		a : in std_logic;		-- input 1: bit
		b : in std_logic;		-- input 2: bit
		c_in : in std_logic;	-- input (carry) 3: bit
		s : out std_logic;		-- output sum: bit
		c_out : out std_logic	-- output carry: bit
	);
end fa;

architecture behavior of fa is
	component ha is		-- half adder
		port (
			a : in std_logic;	-- input 1: bit
			b : in std_logic;	-- input 2: bit
			s : out std_logic;	-- output sum: bit
			c : out std_logic	-- output carry: bit
		);
	end component ha;
	
	signal s1, c1, c2 : std_logic;	-- s: sum; c: carry		(intermediate steps)
begin
	half_adder_1: ha port map(a, b, s1, c1);	-- half adding: a, b
	half_adder_2: ha port map(c_in, s1, s, c2);	-- half adding: c_in, sum(a, b)
	
	c_out <= c1 or c2;	-- carry
end behavior;
