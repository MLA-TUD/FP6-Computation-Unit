library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity sa_filler_tb is		
end sa_filler_tb;

architecture test of sa_filler_tb is
	component sa_filler is -- systolic array
        generic (
		systolicArraySize : integer := 8;
		bitSize : integer := 8;
		counterSize : integer := 24
	);
	port (
		numVals : in std_logic_vector ((counterSize-1) downto 0);
		clk : in std_logic;
		r_bar_w : in std_logic;
		rst : in std_logic;
		fifoOut : in std_logic_vector((bitSize-1) downto 0);
		rinc : out std_logic;
		rdy : out std_logic;
		saIn : out std_1d_vector_array(0 to systolicArraySize-1)
	);
    	end component sa_filler;

    
signal clk, r_bar_w,rst,rinc,rdy:std_logic;
signal numVals:std_logic_vector((8-1) downto 0);
signal fifoOut:std_logic_vector((8-1) downto 0);	
signal saIn:std_1d_vector_array(0 to 8-1);
begin
    sa_filler1: sa_filler generic map(systolicArraySize=>8, bitSize=>8, counterSize=>8)port map(numVals=>numVals,clk=>clk,r_bar_w=>r_bar_w,rst=>rst,fifoOut=>fifoOut,rinc=>rinc,rdy=>rdy,saIn=>saIn);
    
	process begin
        --Setup start values and reset the whole sa-filler
		clk <= '0';
		r_bar_w <= '0';
		rst <= '1';
		numVals <= "00000010";
		fifoOut <= "00000000";
		wait for 10 ns;
		rst <= '0';
		fifoOut <= "00000001";                                  -- fill in 1
		wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		fifoOut <= "00000010";                                  -- fill in 2
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		fifoOut <= "00000011";                                  -- fill in 3
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		fifoOut <= "00000100";                                  -- fill in 4
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		r_bar_w <= '1';
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		clk <= '1';wait for 10 ns;clk <= '0';wait for 10 ns;
		
        -- final result should be :  0 1 2 -> 1st row sa
        --                           3 4 0 -> 2nd row sa
        --                           0 0 0 ... rest are zeros
		wait;		
			
	end process;
end test;
