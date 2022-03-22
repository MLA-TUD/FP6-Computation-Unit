library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stack is
    generic(
        bitSize : integer := 8;
        stackSize : integer := 4
    );
    port(
        d  : in  std_logic_vector(bitSize - 1 downto 0); 
        q  : out std_logic_vector(bitSize - 1 downto 0);
        bar_push_pop : in  std_logic; 
        full  : out std_logic; 
        empty : out std_logic; 
	en 	: in std_logic;
        clk     : in  std_logic;
        rst     : in  std_logic
    );
end entity stack;

architecture arch of stack is
    

    	type memory_type is array (0 to stackSize) of std_logic_vector(bitSize - 1 downto 0);
   	signal memory : memory_type;
begin
    main : process(clk, rst) is
        variable stack_pointer : integer range 0 to stackSize := stackSize;
    begin
        if rst = '1' then
		memory <= (others => (others => '0'));
            	empty <= '1';
            	full  <= '0';
            	stack_pointer := stackSize;
		q <= (others => '0');
        elsif rising_edge(clk) then
	    if en = '1' then
            	if bar_push_pop = '1' then --pop
                	if stack_pointer < stackSize then
                    		
                    		stack_pointer := stack_pointer + 1;
				q <= memory(stack_pointer);
			else
				q <= (others => '0');
                	end if;
            	else  --push
                	if stack_pointer > 0 then
                    		stack_pointer := stack_pointer - 1;
                    		memory(stack_pointer) <= d;
				q <= d;
                	end if;
            	end if;


            	if stack_pointer = stackSize then
               		empty <= '1';
			q <= (others => '0');
            	else
                	empty <= '0';
            	end if;
            	if stack_pointer = 0 then
                	full <= '1';
            	else
                	full <= '0';
            	end if;
	    end if;
        end if;
    end process main;

end architecture arch;
