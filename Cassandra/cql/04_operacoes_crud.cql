-- =====================================================================
-- 04_operacoes_crud.cql
-- Demonstração das operações de CRUD (Create, Read, Update, Delete)
-- =====================================================================
--
-- Este arquivo é o roteiro sugerido para a demonstração em vídeo/aula.
-- Execute os blocos na ordem abaixo e mostre o resultado de cada SELECT.

USE catalogo_streaming;

-- =====================================================================
-- 1) CREATE — inserindo um novo título nas 3 tabelas de uma só vez
-- =====================================================================
--
-- Como as 3 tabelas guardam os MESMOS dados em formatos diferentes
-- (desnormalização), o ideal é inserir nas 3 de forma atômica usando
-- um BATCH. Importante: BATCH no Cassandra não é uma "transação" como
-- no SQL tradicional — ele só garante que todas as instruções dentro
-- dele sejam aplicadas (ou nenhuma, em caso de falha de nó), mas não
-- existe rollback manual nem isolamento entre transações concorrentes.
-- Use BATCH para manter poucas tabelas relacionadas em sincronia, e
-- evite usá-lo para inserir grandes volumes de dados não relacionados.

BEGIN BATCH
  INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
  VALUES ('Ficção Científica', 2021, 'Duna', 9b1d1a4a-2b3d-4c8e-9b0a-1f6f7c2a55d1, 'Filme', 'Denis Villeneuve', 155, 8.5, 'EpicFlix', 'Um jovem herdeiro se vê no centro de uma disputa pelo controle de um planeta deserto, rico no recurso mais valioso do universo.', ['Timothée Chalamet', 'Zendaya']);

  INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
  VALUES (2021, 'Duna', 9b1d1a4a-2b3d-4c8e-9b0a-1f6f7c2a55d1, 'Ficção Científica', 'Filme', 'Denis Villeneuve', 155, 8.5, 'EpicFlix', 'Um jovem herdeiro se vê no centro de uma disputa pelo controle de um planeta deserto, rico no recurso mais valioso do universo.', ['Timothée Chalamet', 'Zendaya']);

  INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
  VALUES ('Duna', 9b1d1a4a-2b3d-4c8e-9b0a-1f6f7c2a55d1, 'Ficção Científica', 2021, 'Filme', 'Denis Villeneuve', 155, 8.5, 'EpicFlix', 'Um jovem herdeiro se vê no centro de uma disputa pelo controle de um planeta deserto, rico no recurso mais valioso do universo.', ['Timothée Chalamet', 'Zendaya']);
APPLY BATCH;

-- Confirme a inserção:
SELECT titulo, ano, categoria, avaliacao FROM filmes_por_titulo WHERE titulo = 'Duna';


-- =====================================================================
-- 2) READ — consultas aproveitando partition key e clustering key
-- =====================================================================

-- 2.1 Todos os títulos de uma categoria, já ordenados por ano (desc)
--     graças ao CLUSTERING ORDER BY definido na tabela.
SELECT titulo, ano, avaliacao, diretor
FROM filmes_por_categoria
WHERE categoria = 'Ficção Científica';

-- 2.2 Filtrando também pela clustering key (ano) dentro da partição
SELECT titulo, ano, avaliacao
FROM filmes_por_categoria
WHERE categoria = 'Drama' AND ano = 2019;

-- 2.3 Range query na clustering key (funciona pois "ano" é a 1ª clustering key)
SELECT titulo, ano
FROM filmes_por_categoria
WHERE categoria = 'Ficção Científica' AND ano >= 2014;

-- 2.4 Todos os títulos lançados em um determinado ano
SELECT titulo, categoria, tipo
FROM filmes_por_ano
WHERE ano = 2017;

-- 2.5 Detalhe completo de um título específico
SELECT *
FROM filmes_por_titulo
WHERE titulo = 'Matrix';

-- 2.6 ANTI-PADRÃO (apenas para fins didáticos — não execute em produção):
-- buscar por uma coluna que NÃO é partition key obriga a fazer um scan
-- distribuído em todos os nós do cluster. O Cassandra bloqueia isso por
-- padrão, e só permite se você explicitamente aceitar o custo da operação:
--
-- SELECT * FROM filmes_por_titulo WHERE categoria = 'Drama';                 -- ERRO
-- SELECT * FROM filmes_por_titulo WHERE categoria = 'Drama' ALLOW FILTERING; -- funciona, mas é ineficiente


-- =====================================================================
-- 3) UPDATE — alterando dados e mantendo as tabelas sincronizadas
-- =====================================================================

-- 3.1 Atualizando um valor simples (nota do filme) nas 3 tabelas
BEGIN BATCH
  UPDATE filmes_por_categoria SET avaliacao = 9.0 WHERE categoria = 'Ficção Científica' AND ano = 1999 AND titulo = 'Matrix';
  UPDATE filmes_por_ano       SET avaliacao = 9.0 WHERE ano = 1999 AND titulo = 'Matrix';
  UPDATE filmes_por_titulo    SET avaliacao = 9.0 WHERE titulo = 'Matrix';
APPLY BATCH;

-- Confirme:
SELECT titulo, avaliacao FROM filmes_por_titulo WHERE titulo = 'Matrix';

-- 3.2 Atualizando uma coleção (list<text>): adicionando um ator ao elenco
-- sem precisar reescrever a lista inteira.
UPDATE filmes_por_titulo
SET elenco = elenco + ['Carrie-Anne Moss']
WHERE titulo = 'Matrix';

SELECT titulo, elenco FROM filmes_por_titulo WHERE titulo = 'Matrix';


-- =====================================================================
-- 4) DELETE — removendo um título das 3 tabelas
-- =====================================================================

BEGIN BATCH
  DELETE FROM filmes_por_categoria WHERE categoria = 'Comédia' AND ano = 2005 AND titulo = 'The Office';
  DELETE FROM filmes_por_ano       WHERE ano = 2005 AND titulo = 'The Office';
  DELETE FROM filmes_por_titulo    WHERE titulo = 'The Office';
APPLY BATCH;

-- Confirme que o título não existe mais:
SELECT * FROM filmes_por_titulo WHERE titulo = 'The Office';   -- deve retornar 0 linhas

-- É possível também excluir apenas uma coluna específica de uma linha
-- (mantendo a linha), por exemplo, removendo a sinopse de um título:
-- DELETE sinopse FROM filmes_por_titulo WHERE titulo = 'Duna';
