library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  Button_M : in std_logic;
			  Button_H : in std_logic;
           anode : out std_logic_vector(3 downto 0);
			  segments : out std_logic_vector (6 downto 0)
           );
end counter;

architecture counter of counter is

signal 	clk1 : std_logic :='0';
signal 	clk2 : std_logic :='0';
signal 	count : integer :=1;
signal 	div    :  std_logic_vector(22 downto 0);
signal 	WhichDisplay	:	std_logic_vector(1 downto 0);
signal 	digit1: INTEGER := 0;
signal 	digit2: INTEGER := 0;
signal 	digit3: INTEGER := 0;
signal 	digit4: INTEGER := 0;
signal 	digit5: INTEGER := 0;
signal 	digit6: INTEGER := 0;

type display_ROM is array (0 to 9) of std_logic_vector (6 downto 0);
constant convert_to_segments : display_ROM :=
		("0111111","0000110","1101011","1001111","1010110","1011101","1111101","0000111",
		 "1111111","1011111"); --0,1,2,3,4,5,6,7,8,9


begin

PROCESS(clk1,clk2, reset)
 
 BEGIN
 ---- counter: ----------------------
 IF (reset='1') THEN
 digit1 <= 0;
 digit2 <= 0;
 digit3 <= 0;
 digit4 <= 0;
 digit5 <= 0;
 digit6 <= 0;
 
 ELSIF rising_edge(clk1) THEN
 digit1 <= digit1 + 1;
 IF (digit1=9) THEN
 digit1 <= 0;
 digit2 <= digit2 + 1;
 IF (digit2=5) THEN
 digit2 <= 0;
 digit3 <= digit3 + 1;
 IF (digit3=9) THEN
 digit3 <= 0;
 digit4 <= digit4 + 1;
 IF (digit4=5) THEN
 digit4 <= 0;

 digit5 <= digit5 + 1;
 IF (digit5=9) THEN
 digit5 <=0;
  
 digit6 <= digit6 + 1;
 if (digit6=3) then 

 digit1 <= 0;
 digit2 <= 0;
 digit3 <= 0;
 digit4 <= 0;
 digit5 <= 0;
 digit6 <= 0;
END IF; END IF; END IF; END IF; END IF; END IF; END IF;
 
END PROCESS;
 
 
div<= div + 1 when rising_edge(clk);
WhichDisplay <= div(16 downto 15);

process(clk)
begin

		if rising_edge(clk) then
		count <=count+1;
		if(count = 11250000) then
			clk1 <= not clk1;
			count <=1;
		if(count = 5625000) then
			clk2 <= not clk2;
			count <=1;
		end if;
		end if;
		end if;
	
		if rising_edge(clk) then
		
		if WhichDisplay ="11" then
			segments <= convert_to_segments(digit4 ); -- 0
			anode<="0111";
		elsif WhichDisplay ="10" then
			segments <= convert_to_segments(digit3); -- 1
			anode<="1011";
		elsif WhichDisplay ="01" then
			segments <= convert_to_segments(digit2); -- 2
			anode<="1101";		
		else
			segments <= convert_to_segments(digit1); -- 3
			anode<="1110";
		end if;
		
		end if;
			
  end process;
end counter;