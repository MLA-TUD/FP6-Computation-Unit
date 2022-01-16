library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_numeric_std.all;

entity fifo_mem is generic(dataSize:integer:=8;addressSize:integer:=8);
    port(
        rData: out std_logic_vector(dataSize-1 downto 0);
        wData: in std_logic_vector(dataSize-1 downto 0);
        rAddress: in std_logic_vector(addressSize-1 downto 0);
        wAddress: in std_logic_vector(addressSize-1 downto 0);
        wClkEn: in std_logic;
        wFull: in std_logic;
        wClk: in std_logic;
    );
end entity fifo_mem;
architecture fifo_mem_behaviour of fifo_mem is
    subtype WORD is std_logic_vector(dataSize-1 downto 0);
    type MEMORY is array(0 to 2**addressSize-1) of WORD;
    signal ram:MEMORY;
    
    begin
        process(wClk,rData)
        variable ram_waddress:natural range 0 to 2**addressSize-1;
        variable ram_raddress:natural range 0 to 2**addressSize-1;
        begin
            ram_waddress := to_integer(UNSIGNED(wAddress));
            ram_raddress := to_integer(UNSIGNED(rAddress));
            rData <= ram(ram_raddress);

            if rising_edge(wClk) then
                if (wClkEn && !wFull) then
                    ram(ram_waddress) <= wData;
                end if;

            end if;
        end process;
    end architecture fifo_mem_behaviour;
