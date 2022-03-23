library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity fifo_mem is generic(dataSize:integer:=8;addressSize:integer:=8);
    port(
        rdata: out std_logic_vector(dataSize-1 downto 0);       --Bitvector input
        wdata: in std_logic_vector(dataSize-1 downto 0);        --Bitvector output
        raddr: in std_logic_vector(addressSize-1 downto 0);     --Internal address of readpointer
        waddr: in std_logic_vector(addressSize-1 downto 0);     --Internal address of writepointer
        wclken: in std_logic;                                   --Enables writing on clockpulse
        wfull: in std_logic;                                    --Active HIGH when memory is full
        wclk: in std_logic                                      --clock pulse for writing into memory
    );
end entity fifo_mem;
architecture fifo_mem_behaviour of fifo_mem is
    subtype WORD is std_logic_vector(dataSize-1 downto 0);
    type MEMORY is array(0 to 2**addressSize-1) of WORD;
    signal ram:MEMORY;
    
    begin
        process(wclk,wdata,raddr)
        variable ram_waddr:natural range 0 to 2**addressSize-1;
        variable ram_raddr:natural range 0 to 2**addressSize-1;
        begin
            ram_waddr := to_integer(UNSIGNED(waddr));
            ram_raddr := to_integer(UNSIGNED(raddr));
            rdata <= ram(ram_raddr);

            if rising_edge(wclk) then
                if (wclken='1' and wfull='0') then
                    ram(ram_waddr) <= wdata;
                end if;

            end if;
        end process;
    end architecture fifo_mem_behaviour;
