------------------------------------------------------------------
--Copyright 2017 Andrey S. Ionisyan (anserion@gmail.com)
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
end full_adder;

architecture Behavioral of full_adder is
signal s1,c1,c2: std_logic;
begin
	s1<=a xor b; c1<=a and b;        --half_adder(a,b,s1,c1);
	s<=s1 xor c_in; c2<=s1 and c_in; --half_adder(s1,c_in,s,c2);
	c_out<=c1 or c2;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add_6bit is
	port (
		clk: in std_logic;
		a,b: in std_logic_vector(5 downto 0);
		res: out std_logic_vector(5 downto 0)
	);
end add_6bit;

architecture Behavioral of add_6bit is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(5 downto 0);
signal p:std_logic_vector(5 downto 0);
begin
	FA0: full_adder port map(a(0),b(0),'0',res_reg(0),p(0));
	FA1: full_adder port map(a(1),b(1),p(0),res_reg(1),p(1));
	FA2: full_adder port map(a(2),b(2),p(1),res_reg(2),p(2));
	FA3: full_adder port map(a(3),b(3),p(2),res_reg(3),p(3));
	FA4: full_adder port map(a(4),b(4),p(3),res_reg(4),p(4));
	FA5: full_adder port map(a(5),b(5),p(4),res_reg(5),p(5));
	process (clk)
	begin
		if rising_edge(clk) then
            res<=res_reg;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity add_16bit is
	port (
		clk: in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
end add_16bit;

architecture Behavioral of add_16bit is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(15 downto 0);
signal p:std_logic_vector(15 downto 0);
begin
	FA0: full_adder port map(a(0),b(0),'0',res_reg(0),p(0));
	FA1: full_adder port map(a(1),b(1),p(0),res_reg(1),p(1));
	FA2: full_adder port map(a(2),b(2),p(1),res_reg(2),p(2));
	FA3: full_adder port map(a(3),b(3),p(2),res_reg(3),p(3));
	FA4: full_adder port map(a(4),b(4),p(3),res_reg(4),p(4));
	FA5: full_adder port map(a(5),b(5),p(4),res_reg(5),p(5));
	FA6: full_adder port map(a(6),b(6),p(5),res_reg(6),p(6));
	FA7: full_adder port map(a(7),b(7),p(6),res_reg(7),p(7));
	FA8: full_adder port map(a(8),b(8),p(7),res_reg(8),p(8));
	FA9: full_adder port map(a(9),b(9),p(8),res_reg(9),p(9));
	FA10: full_adder port map(a(10),b(10),p(9),res_reg(10),p(10));
	FA11: full_adder port map(a(11),b(11),p(10),res_reg(11),p(11));
	FA12: full_adder port map(a(12),b(12),p(11),res_reg(12),p(12));
	FA13: full_adder port map(a(13),b(13),p(12),res_reg(13),p(13));
	FA14: full_adder port map(a(14),b(14),p(13),res_reg(14),p(14));
	FA15: full_adder port map(a(15),b(15),p(14),res_reg(15),p(15));
	
	process (clk)
	begin
		if rising_edge(clk) then
            res<=res_reg;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sub_16bit is
	port (
		clk: in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
end sub_16bit;

architecture Behavioral of sub_16bit is
	component full_adder is
	port (
		a,b,c_in: in std_logic;
		s,c_out : out std_logic
	);
	end component;
signal res_reg: std_logic_vector(15 downto 0);
signal p:std_logic_vector(15 downto 0);
begin
	FA0: full_adder port map(a(0),not(b(0)),'1',res_reg(0),p(0));
	FA1: full_adder port map(a(1),not(b(1)),p(0),res_reg(1),p(1));
	FA2: full_adder port map(a(2),not(b(2)),p(1),res_reg(2),p(2));
	FA3: full_adder port map(a(3),not(b(3)),p(2),res_reg(3),p(3));
	FA4: full_adder port map(a(4),not(b(4)),p(3),res_reg(4),p(4));
	FA5: full_adder port map(a(5),not(b(5)),p(4),res_reg(5),p(5));
	FA6: full_adder port map(a(6),not(b(6)),p(5),res_reg(6),p(6));
	FA7: full_adder port map(a(7),not(b(7)),p(6),res_reg(7),p(7));
	FA8: full_adder port map(a(8),not(b(8)),p(7),res_reg(8),p(8));
	FA9: full_adder port map(a(9),not(b(9)),p(8),res_reg(9),p(9));
	FA10: full_adder port map(a(10),not(b(10)),p(9),res_reg(10),p(10));
	FA11: full_adder port map(a(11),not(b(11)),p(10),res_reg(11),p(11));
	FA12: full_adder port map(a(12),not(b(12)),p(11),res_reg(12),p(12));
	FA13: full_adder port map(a(13),not(b(13)),p(12),res_reg(13),p(13));
	FA14: full_adder port map(a(14),not(b(14)),p(13),res_reg(14),p(14));
	FA15: full_adder port map(a(15),not(b(15)),p(14),res_reg(15),p(15));
	
	process (clk)
	begin
		if rising_edge(clk) then
            res<=res_reg;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mul_8bit is
	port (
		clk: in std_logic;
		a_sgn: in std_logic_vector(7 downto 0);
      b  : in std_logic_vector(7 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
end mul_8bit;

architecture Behavioral of mul_8bit is
	component add_16bit is
	port (
		clk: in std_logic;
		a,b: in std_logic_vector(15 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
	end component;

	signal res_reg: std_logic_vector(15 downto 0);
   signal a0,a1,a2,a3,a4,a5,a6,a7: std_logic_vector(15 downto 0);
	signal s01,s23,s45,s67,s0123,s4567:std_logic_vector(15 downto 0);
begin
	a0(15 downto 8)<=(others=>a_sgn(7)) when b(0)='1' else (others=>'0'); a0(7 downto 0)<=a_sgn when b(0)='1' else (others=>'0');
	a1(15 downto 9)<=(others=>a_sgn(7)) when b(1)='1' else (others=>'0'); a1(8 downto 1)<=a_sgn when b(1)='1' else (others=>'0'); a1(0)<='0';
	a2(15 downto 10)<=(others=>a_sgn(7)) when b(2)='1' else (others=>'0'); a2(9 downto 2)<=a_sgn when b(2)='1' else (others=>'0'); a2(1 downto 0)<=(others=>'0');
	a3(15 downto 11)<=(others=>a_sgn(7)) when b(3)='1' else (others=>'0'); a3(10 downto 3)<=a_sgn when b(3)='1' else (others=>'0'); a3(2 downto 0)<=(others=>'0');
	a4(15 downto 12)<=(others=>a_sgn(7)) when b(4)='1' else (others=>'0'); a4(11 downto 4)<=a_sgn when b(4)='1' else (others=>'0'); a4(3 downto 0)<=(others=>'0');
	a5(15 downto 13)<=(others=>a_sgn(7)) when b(5)='1' else (others=>'0'); a5(12 downto 5)<=a_sgn when b(5)='1' else (others=>'0'); a5(4 downto 0)<=(others=>'0');
	a6(15 downto 14)<=(others=>a_sgn(7)) when b(6)='1' else (others=>'0'); a6(13 downto 6)<=a_sgn when b(6)='1' else (others=>'0'); a6(5 downto 0)<=(others=>'0');
	a7(15)<=a_sgn(7) when b(7)='1' else '0'; a7(14 downto 7)<=a_sgn when b(7)='1' else (others=>'0'); a7(6 downto 0)<=(others=>'0');

	s01_chip: add_16bit port map(clk,a0,a1,s01);
	s23_chip: add_16bit port map(clk,a2,a3,s23);
	s45_chip: add_16bit port map(clk,a4,a5,s45);
	s67_chip: add_16bit port map(clk,a6,a7,s67);
	
	s0123_chip: add_16bit port map(clk,s01,s23,s0123);
	s4567_chip: add_16bit port map(clk,s45,s67,s4567);
	
	res_chip: add_16bit port map(clk,s0123,s4567,res_reg);
	
	process (clk)
	begin
		if rising_edge(clk) then
            res<=res_reg;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mulmod_6bit is
	port (
		clk: in std_logic;
      ask: in std_logic;
      ready: out std_logic;
		a  : in std_logic_vector(5 downto 0);
      b  : in std_logic_vector(5 downto 0);
		res: out std_logic_vector(5 downto 0)
	);
end mulmod_6bit;

architecture Behavioral of mulmod_6bit is
   component mul_8bit is
	port (
		clk: in std_logic;
		a_sgn: in std_logic_vector(7 downto 0);
      b  : in std_logic_vector(7 downto 0);
		res: out std_logic_vector(15 downto 0)
	);
   end component;
   
   signal a_8bit,b_8bit:std_logic_vector(7 downto 0):=(others=>'0');
   signal res_16bit:std_logic_vector(15 downto 0):=(others=>'0');
begin
   a_8bit(7)<='0'; a_8bit(6)<='0'; a_8bit(5 downto 0)<=a;
   b_8bit(7)<='0'; b_8bit(6)<='0'; b_8bit(5 downto 0)<=b;
   res<=res_16bit(5 downto 0);
   
   mul_8bit_chip: mul_8bit port map (clk,a_8bit,b_8bit,res_16bit);
   process (clk)
   variable fsm: integer range 0 to 7:=0;
	begin
		if rising_edge(clk) then
      case fsm is
      when 0 => ready<='0'; if ask='1' then fsm:=1; end if;
      when 1 => fsm:=2;
      when 2 => fsm:=7;
      when 7 => ready<='1'; if ask='0' then fsm:=0; end if;
      when others => fsm:=0;
      end case;
		end if;
	end process;
end Behavioral;
----------------------------------------------------------------------------------