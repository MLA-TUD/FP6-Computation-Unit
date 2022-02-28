library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;
 


entity sa_tb is -- systolic array testbench
end sa_tb;

architecture test of sa_tb is
	
	component sa is -- systolic array
        port ( -- c: clock; r: reset
            a : in std_1d_vector_array; -- upper side
            b : in std_1d_vector_array; -- left side
            c : in std_logic;
            r : in std_logic;
            d : out std_2d_vector_array
        );
    end component;

	signal a, b: std_1d_vector_array;
	signal c, r: std_logic;
	signal d: std_2d_vector_array;
	
	signal outputVector: std_logic_vector(7 downto 0);
begin

    sa1: sa port map(a => a, b => b, c => c, r => r, d => d);
    
    outputVector <= getVectored2D(d);
	
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

		for i in 0 to 7 loop
            a(i) <= "00000001";
            b(i) <= "00000001";
        end loop;
        r <= '1';
        wait for 1 ns;
        r <= '0';
        wait for 1 ns;
        
        
		wait;
	end process;
end test;
