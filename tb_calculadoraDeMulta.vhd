library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_calculadoraDeMulta is
end tb_calculadoraDeMulta;

architecture arch of tb_calculadoraDeMulta is
component calculadoraDeMulta is
 port(
	 tempo_a: in std_logic_vector(15 downto 0);
    tempo_b: in std_logic_vector(15 downto 0);
    velocidade_permitida : in std_logic_vector(15 downto 0);
	 bit_a: in std_logic;
	 bit_b: in std_logic;
	 bit_v: in std_logic;
	 clk: in std_logic;
	 clr: in std_logic;
	 velocidade : out std_logic_vector(15 downto 0);
    multa : out std_logic_vector(31 downto 0);
	 led_verde: out std_logic;
	 led_vermelho: out std_logic;
	 led_amarelo: out std_logic
	 );
end component;

signal sTempo_a, sTempo_b, sVelocidade_permitida, sVelocidade: std_logic_vector(15 downto 0);
signal sMulta: std_logic_vector(31 downto 0);
signal sBit_a, sBit_b, sBit_v, sClk, sClr, sLed_verde, sLed_vermelho, sLed_amarelo: std_logic;

   -- Clock period definitions
   constant PERIOD     : time := 6 ns;
   constant DUTY_CYCLE : real := 0.5;
   constant OFFSET     : time := 2 ns;

begin

instanceCalculadoraDeMulta: calculadoraDeMulta port map(
	 tempo_a => sTempo_a,
    tempo_b => sTempo_b,
    velocidade_permitida => sVelocidade_permitida, ---
	 bit_a => sBit_a,
	 bit_b => sBit_b,
	 bit_v => sBit_v,
	 clk => sClk,
	 clr => sClr, 
	 velocidade => sVelocidade,
    multa => sMulta,
	 led_verde => sLed_verde,
	 led_vermelho => sLed_vermelho,
	 led_amarelo => sLed_amarelo
);

--------------- Multa Máxima ------------------------
--sBit_a <= '0', '1' after 19 ns, '0' after 29 ns;
--sTempo_a <= x"0000", x"0001" after 20 ns;
--sBit_b <= '0', '1' after 29 ns, '0' after 39 ns;
--sTempo_b<= x"0000", x"0002" after 30 ns;
--sBit_v <= '0', '1' after 39 ns, '0' after 49 ns;
--sVelocidade_permitida<= x"0000", x"0005" after 40 ns;
--sClr <= '0', '0' after 10 ns, '0' after 20 ns;


--------------- Calcula Multa -----------------------
--sBit_a <= '0', '1' after 19 ns, '0' after 29 ns;
--sTempo_a <= x"0000", x"0001" after 20 ns;
--sBit_b <= '0', '1' after 29 ns, '0' after 39 ns;
--sTempo_b<= x"0000", x"0002" after 30 ns;
--sBit_v <= '0', '1' after 39 ns, '0' after 49 ns;
--sVelocidade_permitida<= x"0000", x"0009" after 40 ns;
--sClr <= '0', '0' after 10 ns, '0' after 20 ns;


--------------- Sem Multa -----------------------
--sBit_a <= '0', '1' after 19 ns, '0' after 29 ns;
--sTempo_a <= x"0000", x"0001" after 20 ns;
--sBit_b <= '0', '1' after 29 ns, '0' after 39 ns;
--sTempo_b<= x"0000", x"0002" after 30 ns;
--sBit_v <= '0', '1' after 39 ns, '0' after 49 ns;
--sVelocidade_permitida<= x"0000", x"000A" after 40 ns;
--sClr <= '0', '0' after 10 ns, '0' after 20 ns;

------------ Reporta Problema -----------------
sBit_a <= '0', '1' after 19 ns, '0' after 29 ns;
sTempo_a <= x"0000", x"0001" after 20 ns;
sTempo_b<= x"0000", x"0002" after 30 ns;
sBit_v <= '0', '1' after 39 ns, '0' after 49 ns;
sVelocidade_permitida<= x"0000", x"000A" after 40 ns;
sClr <= '0', '0' after 10 ns, '0' after 20 ns;

------------------------------------------------------------------------------------
----------------- process para gerar o sinal de clock ------------------------------
------------------------------------------------------------------------------------		
        PROCESS    -- clock process for clock
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                sClk <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                sClk <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;
end arch;
