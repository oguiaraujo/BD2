-- =====================================================================
-- 02_tabelas.cql
-- Modelagem orientada a consulta (query-first modeling)
-- =====================================================================
--
-- No Cassandra não modelamos pensando em entidades normalizadas e
-- relacionamentos (como faríamos em um SGBD relacional). Em vez disso,
-- pensamos primeiro nas CONSULTAS que a aplicação vai precisar fazer,
-- e criamos uma tabela otimizada para cada uma delas — mesmo que isso
-- signifique duplicar os mesmos dados em tabelas diferentes
-- (desnormalização proposital).
--
-- Cenário: um pequeno catálogo de filmes e séries de streaming, com
-- 3 consultas principais que a aplicação precisa responder:
--
--   Consulta 1: "Quais títulos existem em determinada categoria?"
--                -> tabela filmes_por_categoria
--   Consulta 2: "Quais títulos foram lançados em determinado ano?"
--                -> tabela filmes_por_ano
--   Consulta 3: "Quero ver os detalhes de um título específico"
--                -> tabela filmes_por_titulo
--
-- Em todas elas, a PRIMARY KEY é composta por:
--   * Partition Key (1ª coluna): define em qual nó físico do cluster
--     os dados ficam armazenados. Todo SELECT eficiente no Cassandra
--     DEVE informar a partition key na cláusula WHERE.
--   * Clustering Key (colunas seguintes): define a ORDENAÇÃO dos dados
--     dentro de uma mesma partição (não exige índice adicional).

USE catalogo_streaming;

-- ---------------------------------------------------------------------
-- Tabela 1: filmes_por_categoria
-- Partition Key:  categoria
-- Clustering Key: ano (DESC), titulo
-- Responde: "liste os títulos da categoria X, do mais recente p/ o mais antigo"
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS filmes_por_categoria (
    categoria     text,
    ano           int,
    titulo        text,
    id            uuid,
    tipo          text,        -- 'Filme' ou 'Série'
    diretor       text,
    duracao_min   int,         -- duração em minutos (ou duração média de episódio)
    avaliacao     decimal,     -- nota de 0 a 10
    plataforma    text,
    sinopse       text,
    elenco        list<text>,
    PRIMARY KEY (categoria, ano, titulo)
) WITH CLUSTERING ORDER BY (ano DESC, titulo ASC)
  AND comment = 'Otimizada para listar títulos por categoria, do mais recente ao mais antigo';

-- ---------------------------------------------------------------------
-- Tabela 2: filmes_por_ano
-- Partition Key:  ano
-- Clustering Key: titulo
-- Responde: "quais títulos foram lançados no ano X?"
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS filmes_por_ano (
    ano           int,
    titulo        text,
    id            uuid,
    categoria     text,
    tipo          text,
    diretor       text,
    duracao_min   int,
    avaliacao     decimal,
    plataforma    text,
    sinopse       text,
    elenco        list<text>,
    PRIMARY KEY (ano, titulo)
) WITH CLUSTERING ORDER BY (titulo ASC)
  AND comment = 'Otimizada para listar títulos lançados em um ano específico';

-- ---------------------------------------------------------------------
-- Tabela 3: filmes_por_titulo
-- Partition Key: titulo  (chave única, sem clustering key)
-- Responde: "quero ver os detalhes completos do título X"
-- Também é a tabela base usada nas demonstrações de UPDATE e DELETE.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS filmes_por_titulo (
    titulo        text,
    id            uuid,
    categoria     text,
    ano           int,
    tipo          text,
    diretor       text,
    duracao_min   int,
    avaliacao     decimal,
    plataforma    text,
    sinopse       text,
    elenco        list<text>,
    PRIMARY KEY (titulo)
) WITH comment = 'Otimizada para busca direta dos detalhes de um título';

-- ---------------------------------------------------------------------
-- Conferindo a criação:
--   DESCRIBE TABLES;
--   DESCRIBE TABLE filmes_por_categoria;
-- ---------------------------------------------------------------------
