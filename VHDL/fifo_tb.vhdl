library ieee;
use ieee.std_logic_1164.all;

entity fifo_tb is -- first-in first-out testbench (parallel-in parallel-out)
end fifo_tb;

architecture test of fifo_tb is
	component fifo is -- first-in first-out (parallel-in parallel-out)
		generic(dataSize:integer:=8;addressSize:integer:=8);
        port(
            rdata: out std_logic_vector(dataSize-1 downto 0);
            wfull: out std_logic;
            rempty: out std_logic;
            wdata: in std_logic_vector(dataSize-1 downto 0);
            winc, wclk, wrst_n: in std_logic;
            rinc, rclk, rrst_n: in std_logic
    );
	end component fifo;
	
	-- ?
begin
	fi_fo: fifo port map( ? );
	
	process begin
		-- ?
		wait;
	end process;
end test;
