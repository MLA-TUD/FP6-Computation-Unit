library ieee;
use ieee.std_logic_1164.all;

entity fa is -- full adder
	port ( -- s: sum; c: carry
		a : in std_logic;
		b : in std_logic;
		c_in : in std_logic;
		s : out std_logic;
		c_out : out std_logic
	);
end fa;

architecture behavior of fa is
	component ha
		port ( -- s: sum; c: carry
			a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			c : out std_logic
		);
	end component ha;
	
	signal s1, c1, c2 : std_logic;
begin
	halbaddierer1: ha port map(a, b, s1, c1);
	halbaddierer2: ha port map(c_in, s1, s, c2);
	
	c_out <= c1 or c2;
end behavior;
