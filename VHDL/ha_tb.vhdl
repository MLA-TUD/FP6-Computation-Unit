library ieee;
use ieee.std_logic_1164.all;

entity ha_tb is -- half adder testbench
end ha_tb;

architecture test of ha_tb is
	component ha is -- half adder
		port ( -- s: sum; c: carry
			a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			c : out std_logic
		);
	end component ha;
	
	signal a, b, s, c : std_logic := '0';
	
begin
	ha_test: ha port map(a, b, s, c);
	
	process begin
		a <= '0';
		b <= '0';
		wait for 1 ns; -- s = 0; c = 0
		a <= '0';
		b <= '1';
		wait for 1 ns; -- s = 1; c = 0
		a <= '1';
		b <= '0';
		wait for 1 ns; -- s = 1; c = 0
		a <= '1';
		b <= '1';
		wait for 1 ns; -- s = 0; c = 1
		wait;
	end process;
end test;