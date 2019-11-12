------------------------------------------------------------------
--Copyright 2019 Andrey S. Ionisyan (anserion@gmail.com)
--Licensed under the Apache License, Version 2.0 (the "License");
--you may not use this file except in compliance with the License.
--You may obtain a copy of the License at
--    http://www.apache.org/licenses/LICENSE-2.0
--Unless required by applicable law or agreed to in writing, software
--distributed under the License is distributed on an "AS IS" BASIS,
--WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--See the License for the specific language governing permissions and
--limitations under the License.
------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Engineer: Andrey S. Ionisyan <anserion@gmail.com>
-- 
-- Description: generate 8-char text box for a VGA controller
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use ieee.std_logic_unsigned.all;

entity msg_center is
    Port ( 
		clk        : in  STD_LOGIC;
      en         : in std_logic;
      param1     : in std_logic_vector(31 downto 0);
      param2     : in std_logic_vector(31 downto 0);
      res_out1   : in std_logic_vector(31 downto 0);
      res_out2   : in std_logic_vector(31 downto 0);
		msg_char_x : out STD_LOGIC_VECTOR(6 downto 0);
		msg_char_y : out STD_LOGIC_VECTOR(4 downto 0);
		msg_char   : out STD_LOGIC_VECTOR(7 downto 0)
	 );
end msg_center;

architecture Behavioral of msg_center is
    function string_to_std_logic_vector(str: string)
    return std_logic_vector is variable res: std_logic_vector(str'length*8-1 downto 0);
    begin
    	for i in 1 to str'high loop 
         res(i*8-1 downto 8*(i-1)):=conv_std_logic_vector(character'pos(str(str'high+1-i)),8);
    	end loop;
    	return res;
    end function;

    function bcd32_to_std_logic_vector(bcd: std_logic_vector(31 downto 0))
    return std_logic_vector is variable res: std_logic_vector(63 downto 0);
    begin
    res:=conv_std_logic_vector(conv_integer(bcd(31 downto 28))+48,8) &
         conv_std_logic_vector(conv_integer(bcd(27 downto 24))+48,8) &
         conv_std_logic_vector(conv_integer(bcd(23 downto 20))+48,8) &
         conv_std_logic_vector(conv_integer(bcd(19 downto 16))+48,8) &
         conv_std_logic_vector(conv_integer(bcd(15 downto 12))+48,8) &
         conv_std_logic_vector(conv_integer(bcd(11 downto 8))+48,8) &
         conv_std_logic_vector(conv_integer(bcd(7 downto 4))+48,8) &
         conv_std_logic_vector(conv_integer(bcd(3 downto 0))+48,8);    
    return res;
    end function;

   component bin24_to_bcd is
    Port ( 
		clk   : in  STD_LOGIC;
      en    : in std_logic;
      bin   : in std_logic_vector(23 downto 0);
      bcd   : out std_logic_vector(31 downto 0);
      ready : out std_logic
	 );
   end component;
   signal param1_bcd: std_logic_vector(31 downto 0):=(others=>'0');
   signal param2_bcd: std_logic_vector(31 downto 0):=(others=>'0');
	signal res1_bcd: std_logic_vector(31 downto 0):=(others=>'0');
	signal res2_bcd: std_logic_vector(31 downto 0):=(others=>'0');
	
   signal param1_bcd_ready: std_logic:='0';
   signal param2_bcd_ready: std_logic:='0';
	signal res1_bcd_ready: std_logic:='0';
	signal res2_bcd_ready: std_logic:='0';
   
   component msg_box is
    Port ( 
		clk       : in  STD_LOGIC;
      x         : in  STD_LOGIC_VECTOR(7 downto 0);
      y         : in  STD_LOGIC_VECTOR(7 downto 0);
		msg       : in  STD_LOGIC_VECTOR(63 downto 0);
		char_x    : out STD_LOGIC_VECTOR(7 downto 0);
		char_y	 : out STD_LOGIC_VECTOR(7 downto 0);
		char_code : out STD_LOGIC_VECTOR(7 downto 0)
	 );
   end component;
   
   signal msg1_char_x: std_logic_vector(7 downto 0);
   signal msg1_char_y: std_logic_vector(7 downto 0);
   signal msg1_char: std_logic_vector(7 downto 0);
   signal msg1: std_logic_vector(63 downto 0) := (others=>'0');
   
   signal msg2_char_x: std_logic_vector(7 downto 0);
   signal msg2_char_y: std_logic_vector(7 downto 0);
   signal msg2_char: std_logic_vector(7 downto 0);
   signal msg2: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg3_char_x: std_logic_vector(7 downto 0);
   signal msg3_char_y: std_logic_vector(7 downto 0);
   signal msg3_char: std_logic_vector(7 downto 0);
   signal msg3: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg4_char_x: std_logic_vector(7 downto 0);
   signal msg4_char_y: std_logic_vector(7 downto 0);
   signal msg4_char: std_logic_vector(7 downto 0);
   signal msg4: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg5_char_x: std_logic_vector(7 downto 0);
   signal msg5_char_y: std_logic_vector(7 downto 0);
   signal msg5_char: std_logic_vector(7 downto 0);
   signal msg5: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg6_char_x: std_logic_vector(7 downto 0);
   signal msg6_char_y: std_logic_vector(7 downto 0);
   signal msg6_char: std_logic_vector(7 downto 0);
   signal msg6: std_logic_vector(63 downto 0) := (others=>'0');
 
   signal msg7_char_x: std_logic_vector(7 downto 0);
   signal msg7_char_y: std_logic_vector(7 downto 0);
   signal msg7_char: std_logic_vector(7 downto 0);
   signal msg7: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg8_char_x: std_logic_vector(7 downto 0);
   signal msg8_char_y: std_logic_vector(7 downto 0);
   signal msg8_char: std_logic_vector(7 downto 0);
   signal msg8: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg9_char_x: std_logic_vector(7 downto 0);
   signal msg9_char_y: std_logic_vector(7 downto 0);
   signal msg9_char: std_logic_vector(7 downto 0);
   signal msg9: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg10_char_x: std_logic_vector(7 downto 0);
   signal msg10_char_y: std_logic_vector(7 downto 0);
   signal msg10_char: std_logic_vector(7 downto 0);
   signal msg10: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg11_char_x: std_logic_vector(7 downto 0);
   signal msg11_char_y: std_logic_vector(7 downto 0);
   signal msg11_char: std_logic_vector(7 downto 0);
   signal msg11: std_logic_vector(63 downto 0) := (others=>'0');
   
   signal msg12_char_x: std_logic_vector(7 downto 0);
   signal msg12_char_y: std_logic_vector(7 downto 0);
   signal msg12_char: std_logic_vector(7 downto 0);
   signal msg12: std_logic_vector(63 downto 0) := (others=>'0');

   signal msg13_char_x: std_logic_vector(7 downto 0);
   signal msg13_char_y: std_logic_vector(7 downto 0);
   signal msg13_char: std_logic_vector(7 downto 0);
   signal msg13: std_logic_vector(63 downto 0) := (others=>'0');
begin
   param1_bcd_chip: bin24_to_bcd port map (clk,'1',param1(23 downto 0),param1_bcd,param1_bcd_ready);
   param2_bcd_chip: bin24_to_bcd port map (clk,'1',param2(23 downto 0),param2_bcd,param2_bcd_ready);
	res1_bcd_chip: bin24_to_bcd port map (clk,'1',res_out1(23 downto 0),res1_bcd,res1_bcd_ready);
	res2_bcd_chip: bin24_to_bcd port map (clk,'1',res_out2(23 downto 0),res2_bcd,res2_bcd_ready);
---------------------------------------------------

   msg1_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(13,8),
      y => conv_std_logic_vector(0,8),
      msg => string_to_std_logic_vector("  CLOCK "),
      char_x => msg1_char_x,
      char_y => msg1_char_y,
      char_code => msg1_char
   );
   
   msg2_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(21,8),
      y => conv_std_logic_vector(0,8),
      msg => msg2,
      char_x => msg2_char_x,
      char_y => msg2_char_y,
      char_code => msg2_char
   );
   msg2<= string_to_std_logic_vector("OFF     ") when param1=0
     else string_to_std_logic_vector("4 MHz   ") when param1=1
     else string_to_std_logic_vector("16 MHz  ") when param1=2
     else string_to_std_logic_vector("25 Mhz  ") when param1=3
     else string_to_std_logic_vector("ERROR   ");

   msg3_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(30,8),
      y => conv_std_logic_vector(0,8),
      msg => string_to_std_logic_vector(" MODULO "),
      char_x => msg3_char_x,
      char_y => msg3_char_y,
      char_code => msg3_char
   );

   msg4_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(38,8),
      y => conv_std_logic_vector(0,8),
      msg => msg4,
      char_x => msg4_char_x,
      char_y => msg4_char_y,
      char_code => msg4_char
   );
   msg4<= string_to_std_logic_vector("31 vs 64") when param2=0
     else string_to_std_logic_vector("KAFEDRA ") when param2=1
     else string_to_std_logic_vector("PM & MM ") when param2=2
     else string_to_std_logic_vector("NCFU    ") when param2=3
     else string_to_std_logic_vector("ERROR   ");
---------------------------------------------------

   msg5_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(10,8),
      y => conv_std_logic_vector(5,8),
      msg => string_to_std_logic_vector("BRAM spd"),
      char_x => msg5_char_x,
      char_y => msg5_char_y,
      char_code => msg5_char
   );

   msg6_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(20,8),
      y => conv_std_logic_vector(5,8),
      msg => msg6,
      char_x => msg6_char_x,
      char_y => msg6_char_y,
      char_code => msg6_char
   );
   msg6<= (bcd32_to_std_logic_vector(res1_bcd)(63 downto 0));
---------------------------------------------------

   msg7_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(10,8),
      y => conv_std_logic_vector(10,8),
      msg => string_to_std_logic_vector("CLASSIC "),
      char_x => msg7_char_x,
      char_y => msg7_char_y,
      char_code => msg7_char
   );

   msg8_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(20,8),
      y => conv_std_logic_vector(10,8),
      msg => msg8,
      char_x => msg8_char_x,
      char_y => msg8_char_y,
      char_code => msg8_char
   );
   msg8<= (bcd32_to_std_logic_vector(res2_bcd)(63 downto 0));
---------------------------------------------------
   
   msg9_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(30,8),
      y => conv_std_logic_vector(5,8),
      msg => string_to_std_logic_vector("ops/sec "),
      char_x => msg9_char_x,
      char_y => msg9_char_y,
      char_code => msg9_char
   );
      
   msg10_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(30,8),
      y => conv_std_logic_vector(10,8),
      msg => string_to_std_logic_vector("ops/sec "),
      char_x => msg10_char_x,
      char_y => msg10_char_y,
      char_code => msg10_char
   );
---------------------------------------------------

   msg11_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(20,8),
      y => conv_std_logic_vector(16,8),
      msg => string_to_std_logic_vector("COMPARE "),
      char_x => msg11_char_x,
      char_y => msg11_char_y,
      char_code => msg11_char
   );

   msg12_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(28,8),
      y => conv_std_logic_vector(16,8),
      msg => string_to_std_logic_vector("BRAM vs "),
      char_x => msg12_char_x,
      char_y => msg12_char_y,
      char_code => msg12_char
   );

   msg13_chip: msg_box
   port map (
      clk => clk,
      x => conv_std_logic_vector(36,8),
      y => conv_std_logic_vector(16,8),
      msg => string_to_std_logic_vector("CLASSIC "),
      char_x => msg13_char_x,
      char_y => msg13_char_y,
      char_code => msg13_char
   );
---------------------------------------------------

   process (clk)
   variable msg_fsm:natural range 0 to 255 :=0;
   begin
      if rising_edge(clk) then
         if msg_fsm=0 then
            msg_char_x<=msg1_char_x(6 downto 0);
            msg_char_y<=msg1_char_y(4 downto 0);
            msg_char<=msg1_char;
         end if;
         if msg_fsm=8 then
            msg_char_x<=msg2_char_x(6 downto 0);
            msg_char_y<=msg2_char_y(4 downto 0);
            msg_char<=msg2_char;
         end if;
         if msg_fsm=16 then
            msg_char_x<=msg3_char_x(6 downto 0);
            msg_char_y<=msg3_char_y(4 downto 0);
            msg_char<=msg3_char;
         end if;
         if msg_fsm=24 then
            msg_char_x<=msg4_char_x(6 downto 0);
            msg_char_y<=msg4_char_y(4 downto 0);
            msg_char<=msg4_char;
         end if;
         if msg_fsm=32 then
            msg_char_x<=msg5_char_x(6 downto 0);
            msg_char_y<=msg5_char_y(4 downto 0);
            msg_char<=msg5_char;
         end if;
         if msg_fsm=40 then
            msg_char_x<=msg6_char_x(6 downto 0);
            msg_char_y<=msg6_char_y(4 downto 0);
            msg_char<=msg6_char;
         end if;
         if msg_fsm=48 then
            msg_char_x<=msg7_char_x(6 downto 0);
            msg_char_y<=msg7_char_y(4 downto 0);
            msg_char<=msg7_char;
         end if;
         if msg_fsm=56 then
            msg_char_x<=msg8_char_x(6 downto 0);
            msg_char_y<=msg8_char_y(4 downto 0);
            msg_char<=msg8_char;
         end if;
         if msg_fsm=64 then
            msg_char_x<=msg9_char_x(6 downto 0);
            msg_char_y<=msg9_char_y(4 downto 0);
            msg_char<=msg9_char;
         end if;
         if msg_fsm=72 then
            msg_char_x<=msg10_char_x(6 downto 0);
            msg_char_y<=msg10_char_y(4 downto 0);
            msg_char<=msg10_char;
         end if;
         if msg_fsm=80 then
            msg_char_x<=msg11_char_x(6 downto 0);
            msg_char_y<=msg11_char_y(4 downto 0);
            msg_char<=msg11_char;
         end if;
         if msg_fsm=88 then
            msg_char_x<=msg12_char_x(6 downto 0);
            msg_char_y<=msg12_char_y(4 downto 0);
            msg_char<=msg12_char;
         end if;
         if msg_fsm=96 then
            msg_char_x<=msg13_char_x(6 downto 0);
            msg_char_y<=msg13_char_y(4 downto 0);
            msg_char<=msg13_char;
         end if;
         if msg_fsm=104 then msg_fsm:=0; else msg_fsm:=msg_fsm+1; end if;
      end if;
   end process;

end Behavioral;