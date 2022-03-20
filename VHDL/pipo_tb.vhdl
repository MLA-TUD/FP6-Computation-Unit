library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipo_tb is
end pipo_tb;

architecture testbench of pipo_tb is
	
	component pipo is	-- parallel-in parallel-out (8-Bit Register)
		port (
			a : in std_logic_vector(7 downto 0);	-- input: 8-bit data (to save)
			c : in std_logic;						-- clock
			r : in std_logic;						-- reset (to "00000000")
			b : out std_logic_vector(7 downto 0)	-- output: saved 8-bit data
		);
	end component pipo;
	
	signal c, r : std_logic;					-- c: clock; r: reset
	signal a, b: std_logic_vector(7 downto 0);	-- 8-bit data (input: a; output: b)
	
begin
    reg: pipo port map(c => c, r => r, a => a, b => b);
	
    process begin	-- for repeating the clock signal	(until 150 ns)
        forloopc: for i in 15 downto 0 loop
            c <= '0';
            wait for 5 ns;
            c <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;
    
    process begin	-- for testing (the data)
		r <= '1';
		wait for 10 ns;		-- reset: b="00000000"
		r <= '0';
		wait for 10 ns;
        a <= "00010001";
        wait for 20 ns;		-- b="00010001"
        a <= "00100001";
        wait for 20 ns;		-- b="00100001"
        a <= "01000001";
        wait for 20 ns;		-- b="01000001"
        r <= '1';
        wait for 10 ns;		-- b="00000000"
        a <= "10000001";
        wait for 20 ns;		-- b="00000000"
        r <= '0';
        wait for 10 ns;		-- b="10000001" ???
        wait;
    end process;
	
end testbench;
