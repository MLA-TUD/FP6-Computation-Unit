library ieee;
use ieee.std_logic_1164.all;

entity ha is -- half adder
	port ( -- s: sum; c: carry
		a : in std_logic;
		b : in std_logic;
		s : out std_logic;
		c : out std_logic
	);
end ha;

architecture behavior of ha is
begin
	s <= a xor b;
	c <= a and b;
end behavior;