
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity lablablab is
    Port ( a : in  STD_LOGIC_VECTOR (7 downto 0);
           b : in  STD_LOGIC_VECTOR (7 downto 0);
			  button : in  STD_LOGIC_VECTOR (3 downto 0);
			  clk : in  STD_LOGIC;
           seg7 : out  STD_LOGIC_VECTOR (6 downto 0);
           com : out  STD_LOGIC_VECTOR (1 downto 0));
end lablablab;

architecture Behavioral of lablablab is

 signal addsum  :  std_logic_vector(7 downto 0);
 signal subsum  :  std_logic_vector(7 downto 0);
 signal xorsum  :  std_logic_vector(7 downto 0);
 signal shlsum  :  std_logic_vector(7 downto 0);
 signal seg7msb  :  std_logic_vector(6 downto 0);
 signal seg7lsb  :  std_logic_vector(6 downto 0);
 signal count : std_logic ;
 signal 	div    :  std_logic_vector(22 downto 0);
 signal CLKint : integer range(0) to (100000) := 0;

begin
  

  
  addsum <= (not a)+( not b);
  
    seg7msb <= "1110001" when addsum(7 downto 4)= "1111" else --F
          "1111001" when addsum(7 downto 4) = "1110" else --E
          "1101110" when addsum(7 downto 4) = "1101" else --d
          "0111001" when addsum(7 downto 4) = "1100" else --c
          "1111100" when addsum(7 downto 4) = "1011" else --b
          "1110111" when addsum(7 downto 4) = "1010" else --A
          "1011111" when addsum(7 downto 4) = "1001" else --9
		    "1111111" when addsum(7 downto 4) =  "1000" else --8
		    "0000111" when addsum(7 downto 4) = "0111" else --7
		    "1111101" when addsum(7 downto 4) = "0110" else --6
		    "1011101" when addsum(7 downto 4) = "0101" else --5
		    "1010110" when addsum(7 downto 4) = "0100" else --4
		    "1001111" when addsum(7 downto 4) = "0011" else --3
		    "1101011" when addsum(7 downto 4) = "0010" else --2
		    "0000110" when addsum(7 downto 4) = "0001" else --1
		    "0111111" ;
			 
   seg7lsb <= "1110001" when addsum(3 downto 0) = "1111" else --F
          "1111001" when addsum(3 downto 0) = "1110" else --E
          "1101110" when addsum(3 downto 0) = "1101" else --d
          "0111001" when addsum(3 downto 0) = "1100" else --c
          "1111100" when addsum(3 downto 0) = "1011" else --b
          "1110111" when addsum(3 downto 0) = "1010" else --A
          "1011111" when addsum(3 downto 0) = "1001" else --9
		    "1111111" when addsum(3 downto 0)=  "1000" else --8
		    "0000111" when addsum(3 downto 0) = "0111" else --7
		    "1111101" when addsum(3 downto 0) = "0110" else --6
		    "1011101" when addsum(3 downto 0) = "0101" else --5
		    "1010110" when addsum(3 downto 0) = "0100" else --4
		    "1001111" when addsum(3 downto 0) = "0011" else --3
		    "1101011" when addsum(3 downto 0) = "0010" else --2
		    "0000110" when addsum(3 downto 0) = "0001" else --1
		    "0111111" ;
		
  process (clk) is
   begin
	   if (rising_edge(CLK)) then
		      CLKint <= CLKint+1;
			if (CLKint < 50000) then
			     count <= '0';
			else 
			     count <= '1';
			end if;
			
	   end if;
	
	end process;
	
	com(0) <= count;
	com(1) <= not count;
	
	seg7 <= seg7lsb when count = '0' else
    seg7msb;

 

end Behavioral;

