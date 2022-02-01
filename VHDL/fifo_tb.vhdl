library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
	
    signal rdata: std_logic_vector(7 downto 0);
    signal wfull: std_logic;
    signal rempty: std_logic;
    signal wdata: std_logic_vector(7 downto 0);
    signal winc, wclk, wrst_n: std_logic;
    signal rinc, rclk, rrst_n: std_logic;
begin
    
	fi_fo: fifo generic map(dataSize => 8, addressSize => 2) port map(rdata, wfull, rempty, wdata, winc, wclk, wrst_n,rinc, rclk, rrst_n);
	process begin
        rinc <= '0';
        winc <= '0';
        rclk <= '0';
        wclk <= '0';
        wdata <= "00000000";
        
        --reset synchronisation
        wrst_n <= '1';
        rrst_n <= '1';
        wait for 1 ns;
        wrst_n <= '0'; 
        rrst_n <= '0';
        wait for 1 ns;
        wrst_n <= '1';
        rrst_n <= '1';
	report "Started Testing";
        -- One cycle for clean startup
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';

	-- fill fifo with some values
	report "First fill";
        winc <= '1';
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rempty = '1')
        report "test failed for rempty = 1 when empty" severity error;
        assert (wfull= '0')
        report "test failed for wfull = 0 when empty" severity error;
        
        
        wdata <= "00000001";
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
	assert (rempty = '1')
        report "test failed for rempty = 1 for 1 item" severity error;
        assert (wfull= '0')
        report "test failed for wfull = 0 for 1 item" severity error;

        wdata <= "00000010";
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
	assert (rempty = '1')
        report "test failed for rempty = 1 for 2 items" severity error;
        assert (wfull= '0')
        report "test failed for wfull = 0 for 2 items" severity error;

        wdata <= "00000011";
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
	assert (rempty = '0')
	report "test failed for rempty = 0 when full" severity error;
	assert (wfull= '1')
        report "test failed for wfull = 1 when full" severity error;

        -- read out for several cycles
        winc <= '0';
        rinc <= '1';
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "00000001")
        report "test failed for read combination 01" severity error;
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "00000010")
        report "test failed for read combination 10" severity error;
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "00000011")
        report "test failed for read combination 11" severity error;
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "00000000")
        report "test failed: read from stack is not 00000000" severity error;
      
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        

                
        -- fill for several cycles again
        report "Second fill";
        winc <= '1';
        rinc <= '0';
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rempty = '1')
        report "test failed for rempty = 1 when empty" severity error;
        assert (wfull= '0')
        report "test failed for wfull = 0 when empty" severity error;
        
        
        wdata <= "11111111";
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
	assert (rempty = '1')
        report "test failed for rempty = 1 for 1 item" severity error;
        assert (wfull= '0')
        report "test failed for wfull = 0 for 1 item" severity error;

        wdata <= "11111110";
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
	assert (rempty = '1')
        report "test failed for rempty = 1 for 2 items" severity error;
        assert (wfull= '0')
        report "test failed for wfull = 0 for 2 items" severity error;

        wdata <= "11111111";
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
	assert (rempty = '0')
	report "test failed for rempty = 0 when full" severity error;
	assert (wfull= '1')
        report "test failed for wfull = 1 when full" severity error;
        
        -- read out for several cycles
        winc <= '0';
        rinc <= '1';
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "11111111")
        report "test failed for read combination 01" severity error;
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "11111110")
        report "test failed for read combination 10" severity error;
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "11111111")
        report "test failed for read combination 11" severity error;
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        assert (rdata = "00000000")
        report "test failed: read from stack is not 00000000" severity error;
        
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        wait for 1 ns;wclk <= '1';rclk <= '1';wait for 1 ns; wclk <= '0';rclk <= '0';
        
        report "Ended Testing";
		wait;
	end process;
end test;
