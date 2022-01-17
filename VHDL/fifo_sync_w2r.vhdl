library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_sync_w2r is generic(addressSize:integer:=8);
    port(
        rq2_wPtr: out std_logic_vector(addressSize downto 0);
        wPtr: in std_logic_vector(addressSize downto 0);
        rRst_n: in std_logic;
        rClk: in std_logic
    );
end entity fifo_sync_w2r;

architecture fifo_sync_w2r_behaviour of fifo_sync_w2r is
    signal rq1_wPtr: std_logic_vector(addressSize downto 0);
    
    begin
        process(rClk,rRst_n)
        begin
            if rising_edge(rClk) or falling_edge(rRst_n) then
                if (rRst_n='0') then
                    rq2_wPtr <= (others => '0');
                    rq1_wPtr <= (others => '0');
                else
                    rq2_wPtr <= rq1_wPtr;
                    rq1_wPtr <= wPtr;
                end if;
            end if;
        end process;
    end architecture fifo_sync_w2r_behaviour;
