library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity matrix_multiplier is	
    generic (
        maxMatrixSize : integer := 8;
        bitSize : integer := 8;
        counterWidth : integer := 24; --ToDo in defines package auslagern
    );
	port (	
        clk : in std_logic
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

    component comparator is	
    generic (
        bitSize : integer := 8
    );
	port (		
        a : in std_logic_vector((bitSize - 1) downto 0);	
		b : in std_logic_vector((bitSize - 1) downto 0);	
        eq : out std_logic
	);
    end component comparator;

    component 

    

    signal a, b: std_1d_vector_array(0 to array_size-1)  ;
	signal c, r: std_logic;
	signal d: std_2d_vector_array(0 to array_size-1, 0 to array_size-1);

    signal demuxIn : std_logic_vector((bitSize-1) downto 0);
    signal demuxOut : std_logic_vector(2**bitSize-1 downto 0);
    signal regSizeOut : std_logic_vector((counterWidth-1) downto 0);
    signal regSizeIn : std_logic_vector((counterWidth-1) downto 0);
    signal counterOut : std_logic_vector((counterWidth-1) downto 0);
begin
    sa1: sa generic map(systolicArraySize=>maxMatrixSize, bitSize=>bitSize)port map(upperInputVectors => a, leftInputVectors => b, clk => c, reset => r, outMatrix => d);
    regSize : reg generic map(bitSize=>counterWidth)port map(d=>, clk=>, q=>regSizeOut);
    counter1 : counter generic map(bitSize=>counterWidth)port map(clk=>, n_r=>, q=>);
    comparator1 : comparator generic map(bitSize=>counterWidth)port map(a=>regSizeOut, b=>, eq=>)
    demux1 : demux generic map(bitSize=>maxMatrixSize)port map(x=>'1', s=>, q=>);
	gen1 : FOR i IN 0 TO maxMatrixSize-1 GENERATE
		reg1 : reg generic map(bitSize=>bitSize)port map(d=>, clk=>, q=>);	
	END GENERATE;
	
end behavior;
