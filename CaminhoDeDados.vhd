LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CAMINHO_DE_DADOS is
    port ( tempo_a: in std_logic_vector(15 downto 0);
           tempo_b: in std_logic_vector(15 downto 0);
			  clk: in std_logic;
           velocidade_permitida : in std_logic_vector(15 downto 0);
           velocidade : out std_logic_vector(15 downto 0);
           multa : out std_logic_vector(31 downto 0);
			  
			  -- Sinais da/para controladora
			  sr_a: in std_logic;
			  sr_b: in std_logic;
			  sr_v: in std_logic;
			  sr_vc: in std_logic;
			  sr_m: in std_logic;
			  set_mux: in std_logic;
			  set_count: in std_logic;
			  c_01: out std_logic;
			  c_03: out std_logic;
			  clear: in std_logic;
			  reset: out std_logic
        );
end entity;
architecture RTL OF CAMINHO_DE_DADOS is

--SIGNALS--
signal sTempoA: std_logic_vector(15 downto 0);
signal sTempoB: std_logic_vector(15 downto 0);
signal sVelocidadePermitida: std_logic_vector(15 downto 0);
signal sTempoDeslocamento: std_logic_vector(15 downto 0);
signal sVelocidade: std_logic_vector(15 downto 0);
signal sVelocidadeFinal: std_logic_vector(15 downto 0);
signal sPorcentagem: std_logic_vector(15 downto 0);
signal sMenorIgual1_1: std_logic;
signal sMenorIgual1_3: std_logic;
signal sPorcentagemFinal: std_logic_vector(15 downto 0);
signal sMulta: std_logic_vector(31 downto 0);

------------------------------------- Declaração dos componentes que formam o caminho de dadoss ----------------------------------

component MULTIPLEXADOR is
port(
	 PORCENTAGEM: in std_logic_vector(15 downto 0);
	 SET_MUX: in std_logic;
	 PORCENTAGEM_FINAL: out std_logic_vector(15 downto 0)
);
end component;

component MULTIPLICADOR is
port (
	PORCENTAGEM: in std_logic_vector(15 downto 0);
	MULTA : out std_logic_vector(31 downto 0)
);
end component;

component COMPARADOR is 
	port (
				PORCENTAGEM_VELOCIDADE : in std_logic_vector(15 downto 0);
				PORCENTAGEM: in std_logic_vector(15 downto 0);
				MENOR_IGUAL: out std_logic );
end component;

component subtrator is
port( 
     TempoA, TempoB : in std_logic_vector (15 downto 0);
     TempoDesl:  out std_logic_vector (15 downto 0)
);
end component;

component divisaoVelocidade is
port
  (
    divisor: in std_logic_vector(15 downto 0);
    dividendo: in std_logic_vector(15 downto 0);
    valor : out std_logic_vector (15 downto 0)
  );
end component;

component divisaoPorcentagem is
    port
    (
    velocidade: in std_logic_vector(15 downto 0);
    velocidadeSetada: in std_logic_vector(15 downto 0);
    porcentagem : out std_logic_vector (15 downto 0)
    );
end component;

component FFD is
port( 
    D: in std_logic_vector (15 downto 0);
    registra,rst: in std_logic;
    clock: in std_logic;
    Q: out std_logic_vector (15 downto 0)
);
end component;

component contador is
port(
		clock, rst, load: in std_logic;
		saida: out std_logic
);
end component;

component FFD_32 is
port( 
	D: in std_logic_vector (31 downto 0);
	registra,rst: in std_logic;
	clock: in std_logic;
	Q: out std_logic_vector (31 downto 0)
);
end component;
--component divisorDeFreq is
--port ( 
--frequencia : in(50MHz)
-- a cada 1 periodo (20ns) incrementa i, quando i = x  clock = !clock, f final = 1/2 hz
--frquencia_saida: out  ( 20ns)
--)
--end component;

begin
velocidade <= sVelocidade;
c_01 <= sMenorIgual1_1;
c_03 <= sMenorIgual1_3;
regTempoA: FFD port map(clock=>clk, registra=>sr_a, rst=>clear, D=>tempo_a, Q=>sTempoA);
regTempoB: FFD port map(clock=>clk, registra=>sr_b, rst=>clear, D=>tempo_b, Q=>sTempoB);
regVelocidadeSetada: FFD port map(clock=>clk, registra=>sr_v, rst=>clear, D=>velocidade_permitida, Q=>sVelocidadePermitida);
sub: subtrator port map(TempoA=>sTempoA, TempoB=>sTempoB, TempoDesl=>sTempoDeslocamento);
divVelocidade: divisaoVelocidade port map(divisor=>x"000A", dividendo=>sTempoDeslocamento, valor=>sVelocidade);
regVelocidade: FFD port map(clock=>clk, registra=>sr_vc, rst=>clear, D=>sVelocidade, Q=>sVelocidadeFinal);
divPorcentagem: divisaoPorcentagem port map(velocidade=>sVelocidadeFinal, velocidadeSetada=>sVelocidadePermitida, porcentagem=>sPorcentagem);
comparador1_1: COMPARADOR port map(PORCENTAGEM_VELOCIDADE=>sPorcentagem, PORCENTAGEM=>x"006E", MENOR_IGUAL=>sMenorIgual1_1);
comparador1_3: COMPARADOR port map(PORCENTAGEM_VELOCIDADE=>sPorcentagem, PORCENTAGEM=>x"0082", MENOR_IGUAL=>sMenorIgual1_3);
mux: MULTIPLEXADOR port map(PORCENTAGEM=>sPorcentagem, SET_MUX=>set_mux, PORCENTAGEM_FINAL=>sPorcentagemFinal);
mult: MULTIPLICADOR port map(PORCENTAGEM=>sPorcentagemFinal, MULTA=>sMulta);
regMulta: FFD_32 port map(clock=>clk, registra=>sr_m, rst=>clear, D=>sMulta, Q=>multa);
count: contador port map(clock=>clk, rst=>clear, load=>set_count, saida=>reset);
end RTL;