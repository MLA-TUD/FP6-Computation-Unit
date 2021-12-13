library ieee;
use ieee.std_logic_1164.all;

entity wtm_tb is -- wallace-tree multiplier testbench
end wtm_tb;

architecture test of wtm_tb is
	component wtm is -- wallace-tree multiplier
		port ( -- p: product
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			p : out std_logic_vector(15 downto 0)
		);
	end component wtm;
	
	signal a, b : std_logic_vector(7 downto 0) := "00000000";
	signal p : std_logic_vector(15 downto 0) := "0000000000000000";
begin
	wallace_tree_multiplier: wtm port map(a, b, p);
	
	process begin
		a <= "00000001";
		b <= "00000010";
		wait for 10 ns; -- p = "0000000000000000"
		a <= "00000001";
		b <= "00000001";
		wait for 10 ns; -- p = "0000000000000001"
		a <= "10000000";
		b <= "10000000";
		wait for 10 ns; -- p = "1000000000000000"
		-- ?
		wait;
	end process;
end test;