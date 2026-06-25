-- =====================================================================
-- 01_keyspace.cql
-- Criação do Keyspace (equivalente a um "banco de dados" no Cassandra)
-- =====================================================================
--
-- IMPORTANTE:
-- * Se estiver usando Cassandra LOCAL (Docker), execute este script
--   normalmente via cqlsh.
-- * Se estiver usando o DataStax Astra DB (plano Serverless/gratuito),
--   NÃO é possível criar Keyspaces via CQL. Nesse caso, crie o Keyspace
--   chamado "catalogo_streaming" diretamente na interface web do Astra
--   (botão "Create Keyspace" ao criar o banco) e pule este arquivo.
--   Veja o guia em docs/guia-execucao.md para o passo a passo.
--
-- SimpleStrategy + replication_factor 1 é adequado para um único nó
-- de demonstração. Em um cluster de produção com múltiplos datacenters,
-- o ideal seria NetworkTopologyStrategy com fator de replicação por DC.

CREATE KEYSPACE IF NOT EXISTS catalogo_streaming
WITH replication = {
    'class': 'SimpleStrategy',
    'replication_factor': 1
};

-- Seleciona o keyspace para a sessão atual do cqlsh
USE catalogo_streaming;
