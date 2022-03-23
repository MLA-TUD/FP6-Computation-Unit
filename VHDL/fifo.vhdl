library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity fifo is generic(dataSize:integer:=8;addressSize:integer:=8);
    port(
        rdata: out std_logic_vector(dataSize-1 downto 0);   --Bitvector to be read
        wfull: out std_logic;                               --Bitvector to be written
        rempty: out std_logic;                              --Active High when FiFo empty
        wdata: in std_logic_vector(dataSize-1 downto 0);    --Active high when FiFo fill
        winc, wclk, wrst_n: in std_logic;                   --winc: increments pointer to writeaddress when clock goes high, wclk: clock-signal for writing operations, wrst_n: resets writepointer active LOW
        rinc, rclk, rrst_n: in std_logic                    --rinc: increments pointer to readaddress when clock goes high, rclk: clock-signal for reading operations, rrst_n: resets readpointer active LOW
    );
end entity fifo;
architecture fifo_behaviour of fifo is
    component fifo_sync_r2w 
    generic(addressSize:integer:=8);
    port(
        wq2_rptr: out std_logic_vector(addressSize downto 0);
        rptr: in std_logic_vector(addressSize downto 0);
        wrst_n: in std_logic;
        wclk: in std_logic        
    );
    end component fifo_sync_r2w;

    component fifo_sync_w2r
    generic(addressSize:integer:=8);
    port(
        rq2_wptr: out std_logic_vector(addressSize downto 0);
        wptr: in std_logic_vector(addressSize downto 0);
        rrst_n: in std_logic;
        rclk: in std_logic   
    );
    end component fifo_sync_w2r;

    component fifo_mem 
    generic(dataSize:integer:=8;addressSize:integer:=8);
    port(
        rdata: out std_logic_vector(dataSize-1 downto 0);
        wdata: in std_logic_vector(dataSize-1 downto 0);
        raddr: in std_logic_vector(addressSize-1 downto 0);
        waddr: in std_logic_vector(addressSize-1 downto 0);
        wclken: in std_logic;
        wfull: in std_logic;
        wclk: in std_logic
    );
    end component fifo_mem;

    component fifo_rptr_empty 
    generic(addressSize:integer:=8);
    port(
        rempty: out std_logic;
        raddr: out std_logic_vector(addressSize-1 downto 0);
        rptr: out std_logic_vector(addressSize downto 0);
        rq2_wptr: in std_logic_vector(addressSize downto 0);
        rinc: in std_logic;
        rclk: in std_logic;
        rrst_n: in std_logic
    );
    end component fifo_rptr_empty;

    component fifo_wptr_full 
    generic(addressSize:integer:=8);
    port(
        wfull: out std_logic;
        waddr: out std_logic_vector(addressSize-1 downto 0);
        wptr: out std_logic_vector(addressSize downto 0);
        wq2_rptr: in std_logic_vector(addressSize downto 0);
        winc: in std_logic;
        wclk: in std_logic;
        wrst_n: in std_logic
    );
    end component fifo_wptr_full;

    signal waddr, raddr: std_logic_vector(addressSize-1 downto 0);
    signal wptr, rptr, wq2_rptr, rq2_wptr: std_logic_vector(addressSize downto 0);
    signal wfull_var: std_logic;
begin
    wfull <= wfull_var;
    sync_r2w: fifo_sync_r2w generic map(addressSize => addressSize) port map(wq2_rptr, rptr, wrst_n, wclk);
    sync_w2r: fifo_sync_w2r generic map(addressSize => addressSize) port map(rq2_wptr, wptr, rrst_n, rclk);
    mem: fifo_mem generic map(dataSize =>dataSize, addressSize => addressSize) port map(rdata, wdata, raddr, waddr, winc, wfull_var, wclk);
    rptr_empty: fifo_rptr_empty generic map(addressSize => addressSize) port map(rempty, raddr, rptr, rq2_wptr, rinc, rclk, rrst_n);
    wptr_full: fifo_wptr_full generic map(addressSize => addressSize) port map(wfull_var, waddr, wptr, wq2_rptr, winc, wclk, wrst_n);
    
end architecture fifo_behaviour;
