library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_sync_w2r is generic(addressSize:integer:=8);
    port(
        rq2_wptr: out std_logic_vector(addressSize downto 0);
        wptr: in std_logic_vector(addressSize downto 0);
        rrst_n: in std_logic;
        rclk: in std_logic
    );
end entity fifo_sync_w2r;

architecture fifo_sync_w2r_behaviour of fifo_sync_w2r is
    signal rq1_wptr: std_logic_vector(addressSize downto 0);
    
    begin
        process(rclk,rrst_n)
        begin
            if rising_edge(rclk) or falling_edge(rrst_n) then
                if (rrst_n='0') then
                    rq2_wptr <= (others => '0');
                    rq1_wptr <= (others => '0');
                else
                    rq2_wptr <= rq1_wptr;
                    rq1_wptr <= wptr;
                end if;
            end if;
        end process;
    end architecture fifo_sync_w2r_behaviour;
