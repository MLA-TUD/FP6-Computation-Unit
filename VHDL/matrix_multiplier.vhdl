library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity matrix_multiplier is	
    generic (
        bitSize : integer := 8
    );
	port (		
        a : in std_logic_vector((bitSize - 1) downto 0);	
		b : in std_logic_vector((bitSize - 1) downto 0);	
        eq : out std_logic
	);
end matrix_multiplier;

architecture behavior of matrix_multiplier is
    component fifo is -- first-in first-out (parallel-in parallel-out)
		generic(dataSize:integer:=8;addressSize:integer:=8);
        port(
            rdata: out std_logic_vector(dataSize-1 downto 0);
            wfull: out std_logic;
            rempty: out std_logic;
            wdata: in std_logic_vector(dataSize-1 downto 0);
            winc, wclk, wrst_n: in std_logic;
            rinc, rclk, rrst_n: in std_logic
    );
	end component fifo;

    component reg is	
    generic (bitSize : integer := 8);
	port (		
		d : in std_logic_vector((bitSize - 1) downto 0);	
		clk : in std_logic;	
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
    end component reg;

    component counter is	
    generic (bitSize : integer := 8);
	port (		
        clk : in std_logic;
        n_r : in std_logic;
		q : out std_logic_vector((bitSize - 1) downto 0)	
	);
    end component counter;

    component demux is	
    generic (bitSize : integer := 8);
	port (		
        x : in std_logic;
		s : in std_logic_vector((bitSize - 1) downto 0);	
		q : out std_logic_vector((2**bitSize - 1) downto 0)	
	);
    end component demux;
    
begin
	process(a,b) begin
        tmp <= '1';
		for i in 0 to (bitSize - 1) loop
		    if a(i) /= b(i) then --They are different
                tmp <= '0';
            end if;
	    end loop;
	    eq <= tmp;
	end process;
	
end behavior;
