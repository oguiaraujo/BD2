# Seminário de Projeto de Banco de Dados — Apache Cassandra

**Tarefa:** S1 — Definição da Proposta de Seminários
**Tema:** Apache Cassandra — Introdução e Modelagem Prática em um Banco NoSQL Colunar

**Equipe:**
- Kaio Márcio Araújo Cavalcante Lira
- Jose Guilherme Silva de Araujo
- Leandro Sergio da Silva

---

## Sobre o projeto

Este repositório reúne a proposta e toda a parte prática do seminário sobre
o **Apache Cassandra**, um SGBD NoSQL orientado a colunas. A demonstração
prática consiste na modelagem e implementação de um pequeno catálogo de
filmes e séries (inspirado em plataformas de streaming), usado para ilustrar:

- Modelagem de dados **orientada a consultas** (e não a entidades normalizadas);
- O conceito de **partition key** e **clustering key**;
- **Desnormalização proposital** (a mesma informação guardada em mais de uma tabela);
- Operações de **CRUD** (Create, Read, Update, Delete) usando CQL.

## Estrutura do repositório

```
seminario-cassandra/
├── README.md                      <- este arquivo
├── proposta/
│   ├── proposta-seminario.md      <- proposta do seminário (Markdown)
│   └── proposta-seminario.pdf     <- mesma proposta, em PDF, para envio na tarefa
├── cql/
│   ├── 01_keyspace.cql            <- criação do Keyspace (banco de dados)
│   ├── 02_tabelas.cql             <- criação das 3 tabelas desnormalizadas
│   ├── 03_dados_teste.cql         <- carga de 10 títulos de teste
│   └── 04_operacoes_crud.cql      <- roteiro de demonstração de CRUD
├── docs/
│   └── guia-execucao.md           <- passo a passo para rodar tudo (Docker ou Astra DB)
└── apresentacao/
    └── Apache-Cassandra-Seminario.pptx   <- slides da apresentação (com notas do apresentador)
```

## Como executar a demonstração

Veja o passo a passo completo em [`docs/guia-execucao.md`](docs/guia-execucao.md).
Resumo rápido (ambiente local via Docker):

```bash
docker run --name cassandra-seminario -p 9042:9042 -d cassandra:4.1
docker cp ./cql cassandra-seminario:/cql
docker exec -it cassandra-seminario cqlsh -f /cql/01_keyspace.cql
docker exec -it cassandra-seminario cqlsh -f /cql/02_tabelas.cql
docker exec -it cassandra-seminario cqlsh -f /cql/03_dados_teste.cql
docker exec -it cassandra-seminario cqlsh -f /cql/04_operacoes_crud.cql
```

## Referências

APACHE CASSANDRA PROJECT. **Apache Cassandra Documentation**. Disponível em:
<https://cassandra.apache.org/doc/latest/>. Acesso em: 25 jun. 2026.