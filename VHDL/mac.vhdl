library ieee;
use ieee.std_logic_1164.all;

entity mac is -- multiply-accumulate unit
	port ( -- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		c : in std_logic;
		r : in std_logic;
		d : out std_logic_vector(7 downto 0)
	);
end mac;

architecture behavior of mac is
	component ksa is -- kogge-stone adder
		port ( -- s: sum
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			s : out std_logic_vector(7 downto 0)
		);
	end component ksa;
	
	component wtm is -- wallace-tree multiplier
		port ( -- p: product
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			p : out std_logic_vector(7 downto 0)
		);
	end component wtm;
	
	component pipo is -- parallel-in parallel-out (8-Bit Register)
		port ( -- c: clock; r: reset
			a : in std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic;
			b : out std_logic_vector(7 downto 0)
		);
	end component pipo;
	
	-- p: product; m: memory; s: sum
	signal p, m, s, pipo_out : std_logic_vector(7 downto 0) := "00000000";

begin
	wallace_tree_multiplier: wtm port map(a, b, p);
	
	kogge_stone_adder: ksa port map(m, p, s);
	
	register_8bit: pipo port map(s, c, r, m);
	
	d <= m;
end behavior;
