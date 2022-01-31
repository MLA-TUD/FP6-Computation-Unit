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
    signal rdata: std_logic_vector(dataSize-1 downto 0);
    signal wfull: std_logic;
    signal rempty: std_logic;
    signal wdata: std_logic_vector(dataSize-1 downto 0);
    signal winc, wclk, wrst_n: std_logic;
    signal rinc, rclk, rrst_n: std_logic;
	fi_fo: fifo generic map(8 => dataSize, 2 => addressSize) port map(rdata, wfull, rempty, wdata, winc, wclk, wrst_n,rinc, rclk, rrst_n);
	
	process begin
		-- ?
		wait;
	end process;
end test;
