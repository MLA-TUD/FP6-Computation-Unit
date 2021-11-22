library ieee;
use ieee.std_logic_1164.all;

entity fifo is -- first-in first-out (parallel-in parallel-out)
	port ( -- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);
		c : in std_logic;
		r : in std_logic;
		b : out std_logic_vector(7 downto 0)
	);
end fifo;

architecture behavior of fifo is
	-- ?
begin
	-- ?
end behavior;