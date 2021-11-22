library ieee;
use ieee.std_logic_1164.all;

entity ksa_tb is -- kogge-stone adder testbench
end ksa_tb;

architecture test of ksa_tb is
	component ksa is -- kogge-stone adder
		port ( -- s: sum
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			s : out std_logic_vector(7 downto 0)
		);
	end component ksa;
	
	signal a, b, s : std_logic_vector(7 downto 0) := "00000000";
begin
	kogge_stone_adder: ksa port map(a, b, s);
	
	process begin
		-- ?
		wait;
	end process;
end test;