library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
	
	signal a, b : std_logic_vector(7 downto 0);
	signal p : std_logic_vector(15 downto 0);
begin
	wallace_tree_multiplier: wtm port map(a, b, p);
	
	process begin
	
		for i in 0 to 255 loop
			a <= std_logic_vector(to_unsigned(i, 8));
			
			for j in 0 to 255 loop
				b <=std_logic_vector(to_unsigned(j, 8));
			
				wait for 20 ns;
			
			end loop;
		
		end loop;
		
		wait;
	end process;
end test;