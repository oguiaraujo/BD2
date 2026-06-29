# Guia de Execução — Demonstração Prática (Apache Cassandra)

Este guia explica como subir um ambiente Cassandra e reproduzir toda a
demonstração do seminário (criação do keyspace, tabelas, carga de dados
de teste e operações de CRUD).

Existem **duas opções de ambiente**. Escolha apenas uma:

- **Opção A — Cassandra local via Docker** (recomendada para gravar a
  demonstração com calma, sem depender de internet).
- **Opção B — DataStax Astra DB** (versão gratuita do Cassandra na
  nuvem, sem precisar instalar nada na máquina).

---

## Opção A — Cassandra local com Docker

### A.1 Pré-requisitos
- [Docker](https://www.docker.com/) instalado e em execução.

### A.2 Subindo o container
```bash
docker run --name cassandra-seminario -p 9042:9042 -d cassandra:4.1
```

### A.3 Aguardando o Cassandra iniciar
O Cassandra demora cerca de 30–60 segundos para ficar pronto. Acompanhe o log:
```bash
docker logs -f cassandra-seminario
```
Quando aparecer uma linha parecida com `Startup complete`, pressione
`Ctrl+C` para sair do log (o container continua rodando em segundo plano).

### A.4 Copiando os scripts para dentro do container
```bash
docker cp ./cql cassandra-seminario:/cql
```

### A.5 Executando os scripts em ordem, via cqlsh
```bash
docker exec -it cassandra-seminario cqlsh -f /cql/01_keyspace.cql
docker exec -it cassandra-seminario cqlsh -f /cql/02_tabelas.cql
docker exec -it cassandra-seminario cqlsh -f /cql/03_dados_teste.cql
docker exec -it cassandra-seminario cqlsh -f /cql/04_operacoes_crud.cql
```

### A.6 Explorando interativamente (para a gravação/apresentação)
```bash
docker exec -it cassandra-seminario cqlsh -k catalogo_streaming
```
Dentro do `cqlsh`, use comandos como:
```sql
DESCRIBE TABLES;
SELECT * FROM filmes_por_categoria WHERE categoria = 'Drama';
```

### A.7 Encerrando o ambiente
```bash
docker stop cassandra-seminario
docker rm cassandra-seminario
```

---

## Opção B — DataStax Astra DB (gratuito, na nuvem)

### B.1 Criando a conta e o banco
1. Crie uma conta em <https://astra.datastax.com> (login gratuito).
2. Clique em **Create Database**, escolha o plano **Serverless**.
3. Em **Keyspace name**, digite exatamente: `catalogo_streaming`
   *(no plano Serverless não é possível criar Keyspace via comando `CREATE KEYSPACE`
   pelo CQL — por isso ele precisa ser criado aqui, na criação do banco.
   Por esse motivo, o arquivo `cql/01_keyspace.cql` pode ser pulado neste cenário.)*
4. Aguarde alguns minutos até o status do banco ficar **Active**.

### B.2 Conectando via CQL Console (mais simples, direto do navegador)
1. Abra o banco criado e clique na aba **CQL Console**.
2. Cole o conteúdo de `cql/02_tabelas.cql` e execute.
3. Repita para `cql/03_dados_teste.cql` e `cql/04_operacoes_crud.cql`.

### B.3 Conectando via cqlsh local (alternativa)
1. Na aba **Connect** do banco, baixe o **Secure Connect Bundle** (.zip)
   e siga o link para baixar o pacote `cqlsh` específico do Astra.
2. Descompacte e execute:
   ```bash
   ./cqlsh -b "/caminho/para/secure-connect-catalogo-streaming.zip" -u token -p <SEU_TOKEN>
   ```
3. Execute os arquivos na mesma ordem da Opção A (pulando o `01_keyspace.cql`):
   ```bash
   ./cqlsh -b "secure-connect-catalogo-streaming.zip" -u token -p <SEU_TOKEN> -f cql/02_tabelas.cql
   ./cqlsh -b "secure-connect-catalogo-streaming.zip" -u token -p <SEU_TOKEN> -f cql/03_dados_teste.cql
   ./cqlsh -b "secure-connect-catalogo-streaming.zip" -u token -p <SEU_TOKEN> -f cql/04_operacoes_crud.cql
   ```

---

## Roteiro sugerido para a apresentação/demonstração

1. Mostrar o `CREATE KEYSPACE` e explicar a ideia de *replication factor*.
2. Mostrar a criação das 3 tabelas (`02_tabelas.cql`) e explicar a diferença
   entre **partition key** e **clustering key**, reforçando que a modelagem
   parte das consultas (e não de um modelo normalizado).
3. Rodar `03_dados_teste.cql` e mostrar o catálogo populado com `SELECT * FROM filmes_por_titulo;`.
4. Rodar, passo a passo, o roteiro de CRUD em `04_operacoes_crud.cql`:
   - **Create**: inserir "Duna" nas 3 tabelas via `BATCH`.
   - **Read**: mostrar consultas eficientes (por partition key) e o
     contraste com uma consulta que exigiria `ALLOW FILTERING`.
   - **Update**: atualizar a nota do filme "Matrix" e adicionar um ator
     à lista de elenco.
   - **Delete**: remover o título "The Office" das 3 tabelas.
5. Encerrar reforçando o ponto central do seminário: no Cassandra, a
   **desnormalização e a duplicação de dados são uma escolha de design**,
   feita em troca de leituras extremamente rápidas e alta disponibilidade
   em grande escala — o oposto da lógica de normalização do modelo relacional.

## Solução de problemas comuns

| Sintoma | Causa provável | Solução |
|---|---|---|
| `ConnectionRefused` ao rodar cqlsh | Cassandra ainda não terminou de iniciar | Aguarde e verifique `docker logs -f cassandra-seminario` |
| `InvalidRequest: Keyspace does not exist` | Script `02_tabelas.cql` rodou antes do keyspace existir | Execute `01_keyspace.cql` primeiro (Docker) ou crie o keyspace na UI (Astra) |
| `InvalidRequest` ao filtrar por coluna que não é chave | Tentativa de busca sem usar a partition key | Use a partition key na cláusula `WHERE`, ou adicione `ALLOW FILTERING` apenas para fins de teste |