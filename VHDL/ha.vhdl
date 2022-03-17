library ieee;
use ieee.std_logic_1164.all;

entity ha is	-- half adder
	port (		-- s: sum; c: carry
		a : in std_logic;	-- input: 1
		b : in std_logic;	-- input: 2
		s : out std_logic;	-- output: sum
		c : out std_logic	-- output: carry
	);
end ha;

architecture behavior of ha is
begin
	s <= a xor b;	-- sum
	c <= a and b;	-- carry
end behavior;
