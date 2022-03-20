library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mac_tb is	-- mulitply-accumulate unit testbench
end mac_tb;

architecture testbench of mac_tb is
	component mac is	-- multiply-accumulate unit
		port (
			a : in std_logic_vector(7 downto 0);	-- input: 1
			b : in std_logic_vector(7 downto 0);	-- input: 2
			c : in std_logic;						-- clock
			r : in std_logic;						-- reset (to "00000000")
			d : out std_logic_vector(7 downto 0);	-- output 8-bit signed (2k) data (sum of: "a * b")
			e : out std_logic_vector(7 downto 0);	-- output: 1 (= a: delayed by one clock cycle)
			f : out std_logic_vector(7 downto 0)	-- output: 2 (= b: delayed by one clock cycle)
		);
	end component mac;
	
	signal c, r : std_logic;
	signal a, b, d, e, f: std_logic_vector(7 downto 0):= "00000000";
	
begin
    multiply_accumulate_unit: mac port map(a => a, b => b, c => c, r => r, d => d, e => e, f => f);
	
    process begin
        forloopc: for i in 65 downto 0 loop	-- for repeating the clock signal	(until 650 ns)
            c <= '0';
            wait for 5 ns;
            c <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;
    
    process begin	-- for testing (the data)	(multiplication (wtm) and addition (ksa) are already tested) (-> only a simple test (correct connection of components))
        r <= '1';
        wait for 5 ns;		-- d="00000000"
        r <= '0';
        wait for 5 ns;		-- d="00000000"
        a <= "00001000";
        b <= "00000001";
        wait for 200 ns;	-- from d="00001000" up to d="01111111" (MaxInt)
        b <= "11111111";
		wait for 400 ns;	-- from d="01111111" (MaxInt) down to d="10000000" (MinInt)
		r <= '1';
		wait for 5 ns;		-- d="00000000", e="00000000", f="00000000"
        wait;				-- watch out for: over- and underflows and that d (the sum of products) is in [-128, 127];	e (=a) and f (=b) are one clock cycle late;	(tip: in gtkwave: set number format: to signed Decimal)
    end process;
end testbench;
