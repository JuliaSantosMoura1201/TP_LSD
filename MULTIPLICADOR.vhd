library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MULTIPLICADOR is
port (
	PORCENTAGEM: in std_logic_vector(15 downto 0);
	MULTA : out std_logic_vector(31 downto 0)
);
end entity;

architecture rtl of MULTIPLICADOR is
signal MULTIPLICACAO : std_logic_vector(31 downto 0);
constant VALOR_MAX_MULTA: unsigned(15 downto 0):= x"8000";
begin
MULTIPLICACAO <= std_logic_vector(( unsigned(PORCENTAGEM) * VALOR_MAX_MULTA)/100 );
MULTA <= std_logic_vector(resize(unsigned(MULTIPLICACAO), MULTIPLICACAO'length));
end rtl;
