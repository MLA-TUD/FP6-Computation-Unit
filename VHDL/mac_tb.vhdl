library ieee;
use ieee.std_logic_1164.all;

entity mac_tb is -- multiply-accumulate unit testbench
end mac_tb;

architecture test of mac_tb is
	component mac is -- multiply-accumulate unit
		port ( -- c: clock; r: reset
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic
			-- ?
		);
	end component mac;
	
	signal a, b : std_logic_vector(7 downto 0) := "00000000";
	signal c, r : std_logic := '0';
	-- ?
begin
	multiply_accumulate_unit: mac port map(a, b, c, r, ? );
	
	process begin
		-- ?
		wait;
	end process;
end test;