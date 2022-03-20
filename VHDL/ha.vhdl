library ieee;
use ieee.std_logic_1164.all;

entity ha is	-- half adder
	port (
		a : in std_logic;	-- input 1: bit
		b : in std_logic;	-- input 2: bit
		s : out std_logic;	-- output sum: bit
		c : out std_logic	-- output carry: bit
	);
end ha;

architecture behavior of ha is
begin
	s <= a xor b;	-- sum
	c <= a and b;	-- carry
end behavior;
