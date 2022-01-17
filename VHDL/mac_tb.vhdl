library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mac_tb is
end mac_tb;

architecture testbench of mac_tb is

component mac is -- multiply-accumulate unit
	port ( -- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		c : in std_logic;
		r : in std_logic;
		d : out std_logic_vector(7 downto 0)
	);
end component;

signal c, r : std_logic;
signal a, b, d: std_logic_vector(7 downto 0):= "00000000";

begin
    reg: mac port map(c => c, r => r, a => a, b => b, d => d);
    process begin
        forloopc: for i in 100 downto 0 loop
            c <= '0';
            wait for 5 ns;
            c <= '1';
            wait for 5 ns;
        end loop;
        wait;

    end process;
    
    process begin
        r <= '1';
        wait for 5 ns;
        r <= '0';
        wait for 5 ns;
        a <= "00001000";
        b <= "00000001";
        wait for 200 ns;
        b <= "11111111";
        wait;
    end process;
   
    

end testbench;
