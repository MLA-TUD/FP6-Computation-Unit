library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_sync_r2w is generic(addressSize:integer:=8);
    port(
        wq2_rptr: out std_logic_vector(addressSize downto 0);
        rptr: in std_logic_vector(addressSize downto 0);
        wrst_n: in std_logic;
        wclk: in std_logic
    );
end entity fifo_sync_r2w;

architecture fifo_sync_r2w_behaviour of fifo_sync_r2w is
    signal wq1_rptr: std_logic_vector(addressSize downto 0);
    
    begin
        process(wclk,wrst_n)
        begin
            if rising_edge(wclk) or falling_edge(wrst_n) then
                if (wrst_n='0') then
                    wq2_rptr <= (others => '0');
                    wq1_rptr <= (others => '0');
                else
                    wq2_rptr <= wq1_rptr;
                    wq1_rptr <= rptr;
                end if;
            end if;
        end process;
    end architecture fifo_sync_r2w_behaviour;
