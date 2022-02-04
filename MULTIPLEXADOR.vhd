library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MULTIPLEXADOR is
port(
	 PORCENTAGEM: in std_logic_vector(15 downto 0);
	 SET_MUX: in std_logic;
	 PORCENTAGEM_FINAL: out std_logic_vector(15 downto 0)
);
end MULTIPLEXADOR;

architecture RTL of MULTIPLEXADOR is
begin 
	process(PORCENTAGEM, SET_MUX )
	begin
		if( SET_MUX = '0') then
			PORCENTAGEM_FINAL <= x"00C8";
		elsif ( SET_MUX = '1') then
			PORCENTAGEM_FINAL <= PORCENTAGEM;
		end if;
	end process;
end RTL;
	