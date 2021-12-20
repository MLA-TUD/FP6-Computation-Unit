library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
	
	signal a, b, s : std_logic_vector(7 downto 0);
begin
	kogge_stone_adder: ksa port map(a, b, s);
	
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
