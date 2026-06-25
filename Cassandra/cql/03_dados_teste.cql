-- =====================================================================
-- 03_dados_teste.cql
-- Populando o catálogo: 10 títulos inseridos nas 3 tabelas denormalizadas
-- =====================================================================
--
-- Cada título é inserido em filmes_por_categoria, filmes_por_ano e
-- filmes_por_titulo. No Cassandra não existe JOIN: como cada tabela foi
-- desenhada para responder a uma consulta específica, é responsabilidade
-- da aplicação (ou de um BATCH, como mostrado no arquivo 04) manter os
-- dados sincronizados entre as tabelas.

USE catalogo_streaming;

-- ---------------------------------------------------------------------
-- Interestelar (2014) — Ficção Científica
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Ficção Científica', 2014, 'Interestelar', fd8c90b3-f8e5-48c4-83e2-19952be495d9, 'Filme', 'Christopher Nolan', 169, 8.6, 'CineStream', 'Um grupo de astronautas viaja através de um buraco de minhoca em busca de um novo lar para a humanidade.', ['Matthew McConaughey', 'Anne Hathaway', 'Jessica Chastain']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2014, 'Interestelar', fd8c90b3-f8e5-48c4-83e2-19952be495d9, 'Ficção Científica', 'Filme', 'Christopher Nolan', 169, 8.6, 'CineStream', 'Um grupo de astronautas viaja através de um buraco de minhoca em busca de um novo lar para a humanidade.', ['Matthew McConaughey', 'Anne Hathaway', 'Jessica Chastain']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Interestelar', fd8c90b3-f8e5-48c4-83e2-19952be495d9, 'Ficção Científica', 2014, 'Filme', 'Christopher Nolan', 169, 8.6, 'CineStream', 'Um grupo de astronautas viaja através de um buraco de minhoca em busca de um novo lar para a humanidade.', ['Matthew McConaughey', 'Anne Hathaway', 'Jessica Chastain']);


-- ---------------------------------------------------------------------
-- Breaking Bad (2008) — Drama
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Drama', 2008, 'Breaking Bad', 6be85191-82dc-44f4-bb84-c5ac7b495274, 'Série', 'Vince Gilligan', 47, 9.5, 'StreamPlus', 'Um professor de química diagnosticado com câncer entra no mundo da fabricação de drogas para garantir o futuro da família.', ['Bryan Cranston', 'Aaron Paul']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2008, 'Breaking Bad', 6be85191-82dc-44f4-bb84-c5ac7b495274, 'Drama', 'Série', 'Vince Gilligan', 47, 9.5, 'StreamPlus', 'Um professor de química diagnosticado com câncer entra no mundo da fabricação de drogas para garantir o futuro da família.', ['Bryan Cranston', 'Aaron Paul']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Breaking Bad', 6be85191-82dc-44f4-bb84-c5ac7b495274, 'Drama', 2008, 'Série', 'Vince Gilligan', 47, 9.5, 'StreamPlus', 'Um professor de química diagnosticado com câncer entra no mundo da fabricação de drogas para garantir o futuro da família.', ['Bryan Cranston', 'Aaron Paul']);


-- ---------------------------------------------------------------------
-- Stranger Things (2016) — Ficção Científica
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Ficção Científica', 2016, 'Stranger Things', 2af3c9c5-1d2e-4245-8826-d91bc52afe37, 'Série', 'The Duffer Brothers', 50, 8.7, 'StreamPlus', 'Em uma pequena cidade dos anos 80, o desaparecimento de um garoto revela experimentos secretos e uma dimensão paralela.', ['Millie Bobby Brown', 'Finn Wolfhard']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2016, 'Stranger Things', 2af3c9c5-1d2e-4245-8826-d91bc52afe37, 'Ficção Científica', 'Série', 'The Duffer Brothers', 50, 8.7, 'StreamPlus', 'Em uma pequena cidade dos anos 80, o desaparecimento de um garoto revela experimentos secretos e uma dimensão paralela.', ['Millie Bobby Brown', 'Finn Wolfhard']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Stranger Things', 2af3c9c5-1d2e-4245-8826-d91bc52afe37, 'Ficção Científica', 2016, 'Série', 'The Duffer Brothers', 50, 8.7, 'StreamPlus', 'Em uma pequena cidade dos anos 80, o desaparecimento de um garoto revela experimentos secretos e uma dimensão paralela.', ['Millie Bobby Brown', 'Finn Wolfhard']);


-- ---------------------------------------------------------------------
-- Parasita (2019) — Drama
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Drama', 2019, 'Parasita', 25849e2e-2e1c-4100-b4eb-39026140813f, 'Filme', 'Bong Joon-ho', 132, 8.5, 'CineStream', 'A relação entre duas famílias de classes sociais opostas se transforma em uma espiral de tensão e tragédia.', ['Song Kang-ho', 'Lee Sun-kyun']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2019, 'Parasita', 25849e2e-2e1c-4100-b4eb-39026140813f, 'Drama', 'Filme', 'Bong Joon-ho', 132, 8.5, 'CineStream', 'A relação entre duas famílias de classes sociais opostas se transforma em uma espiral de tensão e tragédia.', ['Song Kang-ho', 'Lee Sun-kyun']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Parasita', 25849e2e-2e1c-4100-b4eb-39026140813f, 'Drama', 2019, 'Filme', 'Bong Joon-ho', 132, 8.5, 'CineStream', 'A relação entre duas famílias de classes sociais opostas se transforma em uma espiral de tensão e tragédia.', ['Song Kang-ho', 'Lee Sun-kyun']);


-- ---------------------------------------------------------------------
-- O Senhor dos Anéis: A Sociedade do Anel (2001) — Fantasia
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Fantasia', 2001, 'O Senhor dos Anéis: A Sociedade do Anel', 43178c76-0c6f-4eec-9160-e4dec1262c8f, 'Filme', 'Peter Jackson', 178, 8.8, 'EpicFlix', 'Um hobbit recebe a missão de destruir um anel mágico capaz de dar poder absoluto a um senhor das trevas.', ['Elijah Wood', 'Ian McKellen']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2001, 'O Senhor dos Anéis: A Sociedade do Anel', 43178c76-0c6f-4eec-9160-e4dec1262c8f, 'Fantasia', 'Filme', 'Peter Jackson', 178, 8.8, 'EpicFlix', 'Um hobbit recebe a missão de destruir um anel mágico capaz de dar poder absoluto a um senhor das trevas.', ['Elijah Wood', 'Ian McKellen']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('O Senhor dos Anéis: A Sociedade do Anel', 43178c76-0c6f-4eec-9160-e4dec1262c8f, 'Fantasia', 2001, 'Filme', 'Peter Jackson', 178, 8.8, 'EpicFlix', 'Um hobbit recebe a missão de destruir um anel mágico capaz de dar poder absoluto a um senhor das trevas.', ['Elijah Wood', 'Ian McKellen']);


-- ---------------------------------------------------------------------
-- Dark (2017) — Ficção Científica
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Ficção Científica', 2017, 'Dark', 618fe434-311b-413d-b595-48d3b869f0c6, 'Série', 'Baran bo Odar', 55, 8.8, 'StreamPlus', 'O desaparecimento de crianças em uma pequena cidade alemã expõe segredos ligados a viagens no tempo.', ['Louis Hofmann', 'Karoline Eichhorn']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2017, 'Dark', 618fe434-311b-413d-b595-48d3b869f0c6, 'Ficção Científica', 'Série', 'Baran bo Odar', 55, 8.8, 'StreamPlus', 'O desaparecimento de crianças em uma pequena cidade alemã expõe segredos ligados a viagens no tempo.', ['Louis Hofmann', 'Karoline Eichhorn']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Dark', 618fe434-311b-413d-b595-48d3b869f0c6, 'Ficção Científica', 2017, 'Série', 'Baran bo Odar', 55, 8.8, 'StreamPlus', 'O desaparecimento de crianças em uma pequena cidade alemã expõe segredos ligados a viagens no tempo.', ['Louis Hofmann', 'Karoline Eichhorn']);


-- ---------------------------------------------------------------------
-- Cidade de Deus (2002) — Drama
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Drama', 2002, 'Cidade de Deus', 54943843-a11e-4760-a688-45cd28f8d96e, 'Filme', 'Fernando Meirelles', 130, 8.6, 'CineStream', 'A trajetória de jovens em uma comunidade carioca marcada pela violência e pelo crime organizado, ao longo de duas décadas.', ['Alexandre Rodrigues', 'Leandro Firmino']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2002, 'Cidade de Deus', 54943843-a11e-4760-a688-45cd28f8d96e, 'Drama', 'Filme', 'Fernando Meirelles', 130, 8.6, 'CineStream', 'A trajetória de jovens em uma comunidade carioca marcada pela violência e pelo crime organizado, ao longo de duas décadas.', ['Alexandre Rodrigues', 'Leandro Firmino']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Cidade de Deus', 54943843-a11e-4760-a688-45cd28f8d96e, 'Drama', 2002, 'Filme', 'Fernando Meirelles', 130, 8.6, 'CineStream', 'A trajetória de jovens em uma comunidade carioca marcada pela violência e pelo crime organizado, ao longo de duas décadas.', ['Alexandre Rodrigues', 'Leandro Firmino']);


-- ---------------------------------------------------------------------
-- The Office (2005) — Comédia
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Comédia', 2005, 'The Office', 80e7bfa5-a630-4735-acd0-1991b578aa87, 'Série', 'Greg Daniels', 22, 9.0, 'StreamPlus', 'O cotidiano absurdo dos funcionários de uma empresa de papel é registrado em formato de falso documentário.', ['Steve Carell', 'Rainn Wilson']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2005, 'The Office', 80e7bfa5-a630-4735-acd0-1991b578aa87, 'Comédia', 'Série', 'Greg Daniels', 22, 9.0, 'StreamPlus', 'O cotidiano absurdo dos funcionários de uma empresa de papel é registrado em formato de falso documentário.', ['Steve Carell', 'Rainn Wilson']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('The Office', 80e7bfa5-a630-4735-acd0-1991b578aa87, 'Comédia', 2005, 'Série', 'Greg Daniels', 22, 9.0, 'StreamPlus', 'O cotidiano absurdo dos funcionários de uma empresa de papel é registrado em formato de falso documentário.', ['Steve Carell', 'Rainn Wilson']);


-- ---------------------------------------------------------------------
-- Matrix (1999) — Ficção Científica
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Ficção Científica', 1999, 'Matrix', 8e66d0d5-7743-471f-9f5d-fbcf75417133, 'Filme', 'Lana e Lilly Wachowski', 136, 8.7, 'EpicFlix', 'Um programador descobre que a realidade em que vive é uma simulação controlada por máquinas.', ['Keanu Reeves', 'Laurence Fishburne']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (1999, 'Matrix', 8e66d0d5-7743-471f-9f5d-fbcf75417133, 'Ficção Científica', 'Filme', 'Lana e Lilly Wachowski', 136, 8.7, 'EpicFlix', 'Um programador descobre que a realidade em que vive é uma simulação controlada por máquinas.', ['Keanu Reeves', 'Laurence Fishburne']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Matrix', 8e66d0d5-7743-471f-9f5d-fbcf75417133, 'Ficção Científica', 1999, 'Filme', 'Lana e Lilly Wachowski', 136, 8.7, 'EpicFlix', 'Um programador descobre que a realidade em que vive é uma simulação controlada por máquinas.', ['Keanu Reeves', 'Laurence Fishburne']);


-- ---------------------------------------------------------------------
-- Round 6 (2021) — Drama
-- ---------------------------------------------------------------------
INSERT INTO filmes_por_categoria (categoria, ano, titulo, id, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Drama', 2021, 'Round 6', 05aed92f-4c34-442d-b6ab-843bdf99c23b, 'Série', 'Hwang Dong-hyuk', 55, 8.0, 'StreamPlus', 'Centenas de pessoas em dificuldades financeiras disputam jogos infantis mortais por um prêmio milionário.', ['Lee Jung-jae', 'Park Hae-soo']);

INSERT INTO filmes_por_ano (ano, titulo, id, categoria, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES (2021, 'Round 6', 05aed92f-4c34-442d-b6ab-843bdf99c23b, 'Drama', 'Série', 'Hwang Dong-hyuk', 55, 8.0, 'StreamPlus', 'Centenas de pessoas em dificuldades financeiras disputam jogos infantis mortais por um prêmio milionário.', ['Lee Jung-jae', 'Park Hae-soo']);

INSERT INTO filmes_por_titulo (titulo, id, categoria, ano, tipo, diretor, duracao_min, avaliacao, plataforma, sinopse, elenco)
VALUES ('Round 6', 05aed92f-4c34-442d-b6ab-843bdf99c23b, 'Drama', 2021, 'Série', 'Hwang Dong-hyuk', 55, 8.0, 'StreamPlus', 'Centenas de pessoas em dificuldades financeiras disputam jogos infantis mortais por um prêmio milionário.', ['Lee Jung-jae', 'Park Hae-soo']);


-- ---------------------------------------------------------------------
-- Conferindo a carga de dados:
--   SELECT COUNT(*) FROM filmes_por_titulo;   -- esperado: 10
--   SELECT titulo, ano, avaliacao FROM filmes_por_categoria WHERE categoria = 'Drama';
-- ---------------------------------------------------------------------
