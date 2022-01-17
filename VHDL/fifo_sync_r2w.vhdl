library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_sync_r2w is generic(addressSize:integer:=8);
    port(
        wq2_rPtr: out std_logic_vector(addressSize downto 0);
        rPtr: in std_logic_vector(addressSize downto 0);
        wRst_n: in std_logic;
        wClk: in std_logic
    );
end entity fifo_sync_r2w;

architecture fifo_sync_r2w_behaviour of fifo_sync_r2w is
    signal wq1_rPtr: std_logic_vector(addressSize downto 0);
    
    begin
        process(wClk,wRst_n)
        begin
            if rising_edge(wClk) or falling_edge(wRst_n) then
                if (wRst_n='0') then
                    wq2_rPtr <= (others => '0');
                    wq1_rPtr <= (others => '0');
                else
                    wq2_rPtr <= wq1_rPtr;
                    wq1_rPtr <= rPtr;
                end if;
            end if;
        end process;
    end architecture fifo_sync_r2w_behaviour;
