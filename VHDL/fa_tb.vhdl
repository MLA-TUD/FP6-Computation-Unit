library ieee;
use ieee.std_logic_1164.all;

entity fa_tb is		-- full adder testbench
end fa_tb;

architecture test of fa_tb is
	component fa is		-- full adder
		port (
			a : in std_logic;		-- input 1: bit
			b : in std_logic;		-- input 2: bit
			c_in : in std_logic;	-- input 3 (carry): bit
			s : out std_logic;		-- output sum: bit
			c_out : out std_logic	-- output carry: bit
		);
	end component fa;
	
	signal a, b, c_in, s, c_out : std_logic := '0';
	
begin
	full_adder: fa port map(a, b, c_in, s, c_out);
	
	process begin
		a <= '0';
		b <= '0';
		c_in <= '0';
		wait for 1 ns;	-- s=0; c_out=0
		a <= '0';
		b <= '0';
		c_in <= '1';
		wait for 1 ns;	-- s=1; c_out=0
		a <= '0';
		b <= '1';
		c_in <= '0';
		wait for 1 ns;	-- s=1; c_out=0
		a <= '0';
		b <= '1';
		c_in <= '1';
		wait for 1 ns;	-- s=0; c_out=1
		a <= '1';
		b <= '0';
		c_in <= '0';
		wait for 1 ns;	-- s=1; c_out=0
		a <= '1';
		b <= '0';
		c_in <= '1';
		wait for 1 ns;	-- s=0; c_out=1
		a <= '1';
		b <= '1';
		c_in <= '0';
		wait for 1 ns;	-- s=0; c_out=1
		a <= '1';
		b <= '1';
		c_in <= '1';
		wait for 1 ns;	-- s=1; c_out=1
		wait;
	end process;
end test;
