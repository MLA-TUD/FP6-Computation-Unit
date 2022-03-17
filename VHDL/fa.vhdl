library ieee;
use ieee.std_logic_1164.all;

entity fa is	-- full adder
	port (		-- s: sum; c: carry
		a : in std_logic;		-- input: 1
		b : in std_logic;		-- input: 2
		c_in : in std_logic;	-- input: 3 (carry)
		s : out std_logic;		-- output: sum
		c_out : out std_logic	-- output: carry
	);
end fa;

architecture behavior of fa is
	component ha is		-- half adder
		port (			-- s: sum; c: carry
			a : in std_logic;	-- input: 1
			b : in std_logic;	-- input: 2
			s : out std_logic;	-- output: sum
			c : out std_logic	-- output: carry
		);
	end component ha;
	
	signal s1, c1, c2 : std_logic;	-- s: sum; c: carry		(intermediate steps)
begin
	half_adder_1: ha port map(a, b, s1, c1);	-- half adding: a,b
	half_adder_2: ha port map(c_in, s1, s, c2);	-- half adding: c_in, sum(a,b)
	
	c_out <= c1 or c2;	-- carry
end behavior;
