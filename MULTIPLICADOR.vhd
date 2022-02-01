library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MULTIPLICADOR is
port (
	PORCENTAGEM: in std_logic_vector(7 downto 0);
	MULTA : out std_logic_vector(16 downto 0)
);
end entity;

architecture rtl of MULTIPLICADOR is
signal MULTIPLICACAO : std_logic_vector(24 downto 0);
signal RESULTADO : std_logic_vector(16 downto 0);
constant VALOR_MAX_MULTA: unsigned(16 downto 0):= "01000000000000000";
begin
MULTIPLICACAO <= std_logic_vector((unsigned(PORCENTAGEM) * VALOR_MAX_MULTA)/100 );
RESULTADO <= MULTIPLICACAO(16 downto 0);
MULTA <= std_logic_vector(unsigned(RESULTADO));
end rtl;
