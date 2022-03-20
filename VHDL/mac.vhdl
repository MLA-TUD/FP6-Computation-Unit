library ieee;
use ieee.std_logic_1164.all;

entity mac is	-- multiply-accumulate unit
	port (
		a : in std_logic_vector(7 downto 0);	-- input: 1: 8-bit signed (2k) data
		b : in std_logic_vector(7 downto 0);	-- input: 2: 8-bit signed (2k) data
		c : in std_logic;						-- clock
		r : in std_logic;						-- reset (to "00000000")
		d : out std_logic_vector(7 downto 0);	-- output 8-bit data (sum of: "a * b")
		e : out std_logic_vector(7 downto 0);	-- output: 1: 8-bit signed (2k) data (= a: delayed by one clock cycle)
		f : out std_logic_vector(7 downto 0)	-- output: 2: 8-bit signed (2k) data (= b: delayed by one clock cycle)
	);
end mac;

architecture behavior of mac is
	component ksa is	-- kogge-stone adder (twos complement correct)
		port (			-- s: sum
			a : in std_logic_vector(7 downto 0);	-- input: 1: 8-bit signed (2k) data
			b : in std_logic_vector(7 downto 0);	-- input: 2: 8-bit signed (2k) data
			s : out std_logic_vector(7 downto 0)	-- output: sum 8-bit signed (2k) data (twos complement correct)
		);
	end component ksa;
	
	component wtm is	-- wallace-tree multiplier (twos complement (2k) correct, 8-Bit (not 16-bit) (shortened) product)
		port (
			a : in std_logic_vector(7 downto 0);	-- input 1: 8-bit signed (2k) data
			b : in std_logic_vector(7 downto 0);	-- input 2: 8-bit signed (2k) data
			p : out std_logic_vector(7 downto 0)	-- output product: 8-bit signed (2k) data
		);
	end component wtm;
	
	component pipo is	-- parallel-in parallel-out (8-Bit Register; rising clock)
		port (
			a : in std_logic_vector(7 downto 0);	-- input: 8-bit data (to save)
			c : in std_logic;						-- clock
			r : in std_logic;						-- reset (to "00000000")
			b : out std_logic_vector(7 downto 0)	-- output: saved 8-bit data
		);
	end component pipo;
	
	signal p, m, s : std_logic_vector(7 downto 0) := "00000000";	-- p: product; m: memory; s: sum

begin
	wallace_tree_multiplier: wtm port map(a, b, p);
	
	kogge_stone_adder: ksa port map(m, p, s);
	
	register_d: pipo port map(s, c, r, m);
	
	regsiter_a_e: pipo port map(a, c, r, e);
	
	register_b_f: pipo port map(b, c, r, f);
	
	d <= m;
end behavior;
