library ieee;
use ieee.std_logic_1164.all;

entity wtm is -- wallace-tree multiplier
	port ( -- p: product
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		p : out std_logic_vector(15 downto 0)
	);
end wtm;

architecture behavior of wtm is
	component ha is -- half adder
		port ( -- s: sum; c: carry
			a : in std_logic;
			b : in std_logic;
			s : out std_logic;
			c : out std_logic
		);
	end component ha;
	
	component fa is -- full adder
		port ( -- s: sum; c: carry
			a : in std_logic;
			b : in std_logic;
			c_in : in std_logic;
			s : out std_logic;
			c_out : out std_logic
		);
	end component fa;
	
	component ksa is -- kogge-stone adder
		port ( -- s: sum
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			s : out std_logic_vector(7 downto 0)
		);
	end component ksa;
	
	-- ?
begin
	-- ?
end behavior;