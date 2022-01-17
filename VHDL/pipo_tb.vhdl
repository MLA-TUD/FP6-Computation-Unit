library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipo_tb is
end pipo_tb;

architecture testbench of pipo_tb is

component pipo is -- parallel-in parallel-out (8-Bit Register)
	port ( -- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);
		c : in std_logic;
		r : in std_logic;
		b : out std_logic_vector(7 downto 0)
	);
end component;

signal c, r : std_logic;
signal a, b: std_logic_vector(7 downto 0);

begin
    reg: pipo port map(c => c, r => r, a => a, b => b);
    process begin
        forloopc: for i in 50 downto 0 loop
            c <= '0';
            wait for 5 ns;
            c <= '1';
            wait for 5 ns;
        end loop;
        wait;

    end process;
    
    process begin
        a <= "00010001";
        wait for 20 ns;
        a <= "00100001";
        wait for 20 ns;
        a <= "01000001";
        wait for 20 ns;
        r <= '1';
        wait for 10 ns;
        a <= "10000001";
        wait for 20 ns;
        r <= '0';
        wait for 10 ns;
        wait;
    end process;
   
    

end testbench;
