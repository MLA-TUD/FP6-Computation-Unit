library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_rptr_empty is generic(addressSize:integer:=8);
    port(
        rempty: out std_logic;
        raddr: out std_logic_vector(addressSize-1 downto 0);
        rptr: out std_logic_vector(addressSize downto 0);
        rq2_wptr: in std_logic_vector(addressSize downto 0);
        rinc: in std_logic;
        rclk: in std_logic;
        rrst_n: in std_logic
    );
end entity fifo_rptr_empty;

architecture fifo_rptr_empty_behaviour of fifo_rptr_empty is
    signal rbin: std_logic_vector(addressSize downto 0);
    signal rgraynext: std_logic_vector(addressSize downto 0);
    signal rbinnext: std_logic_vector(addressSize downto 0);
    signal rempty_val: std_logic;
    signal rempty_tmp: std_logic;

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
        raddr <= rbin(addressSize-1 downto 0);
        rbinnext <= std_logic_vector(unsigned(rbin)+unsigned(Std_Logic_To_Std_Logic_Vector(rinc and (not rempty_tmp))) );
        rgraynext <= std_logic_vector(shift_right(unsigned(rbinnext),1)) xor rbinnext;
        rempty_val <= To_Std_logic(rgraynext = rq2_wptr);

        process(rclk,rrst_n)
        begin
            if rising_edge(rclk) or falling_edge(rrst_n) then
                if (rrst_n='0') then
                    --Pointer
                    rbin <= (others => '0');
                    rptr <= (others => '0');
                    --FIFO empty
                    rempty <= '1';
                    rempty_tmp <= '1';
                else
                    --Pointer
                    rbin <= rbinnext;
                    rptr <= rgraynext;
                    --FIFO empty
                    rempty <= rempty_val;
                    rempty_tmp <= rempty_val;
                end if;
            end if;
        end process;

    end architecture fifo_rptr_empty_behaviour;
