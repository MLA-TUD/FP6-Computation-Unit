library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_wptr_full is generic(addressSize:integer:=8);
    port(
        wfull: out std_logic;
        waddr: out std_logic_vector(addressSize-1 downto 0);
        wptr: out std_logic_vector(addressSize downto 0);
        wq2_rptr: in std_logic_vector(addressSize downto 0);
        winc: in std_logic;
        wclk: in std_logic;
        wrst_n: in std_logic
    );
end entity fifo_wptr_full;

architecture fifo_wptr_full_behaviour of fifo_wptr_full is
    signal wbin: std_logic_vector(addressSize downto 0);
    signal wgraynext: std_logic_vector(addressSize downto 0);
    signal wbinnext: std_logic_vector(addressSize downto 0);
    signal wfull_val: std_logic;
    signal wfull_tmp: std_logic;

    function To_Std_Logic(L: BOOLEAN) return std_ulogic is
    begin
        if L then
          return('1');
       else
          return('0');
       end if;
    end function To_Std_Logic; 

    function Std_Logic_To_Std_Logic_Vector(b: std_logic) return std_logic_vector is
    variable ret: std_logic_vector(addressSize downto 0);
    begin
        ret := (others => '0');
        ret(0) := b;
        return ret;
    end function Std_Logic_To_Std_Logic_Vector; 

    begin
        waddr <= wbin(addressSize-1 downto 0);
        wbinnext <= std_logic_vector(unsigned(wbin)+unsigned(Std_Logic_To_Std_Logic_Vector(winc and (not wfull_tmp))) );
        wgraynext <= std_logic_vector(shift_right(unsigned(wbinnext),1)) xor wbinnext;
        wfull_val <= (wgraynext(addressSize) xor wq2_rptr(addressSize)) and
                     (wgraynext(addressSize-1) xor wq2_rptr(addressSize-1)) and
                     To_Std_Logic(wgraynext(addressSize-2 downto 0) = wq2_rptr(addressSize-2 downto 0));

        process(wclk,wrst_n)
        begin
            if rising_edge(wclk) or falling_edge(wrst_n) then
                if (wrst_n='0') then
                    --Pointer
                    wbin <= (others => '0');
                    wptr <= (others => '0');
                    --FIFO full
                    wfull <= '0';
                    wfull_tmp <= '0';
                else
                    --Pointer
                    wbin <= wbinnext;
                    wptr <= wgraynext;
                    --FIFO full
                    wfull <= wfull_val;
                    wfull_tmp <= wfull_val;
                end if;
            end if;
        end process;

    end architecture fifo_wptr_full_behaviour;
