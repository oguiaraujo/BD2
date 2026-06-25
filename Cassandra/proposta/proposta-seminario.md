# PROJETO DE BANCO DE DADOS — TAREFA S1

## Proposta de Seminário: Apache Cassandra
### Introdução e Modelagem Prática em um Banco NoSQL Colunar

**Equipe:**

- Kaio Márcio Araújo Cavalcante Lira
- Jose Guilherme Silva de Araujo
- Leandro Sergio da Silva

---

## 1. Introdução ao Tema

Com o crescimento exponencial do volume de dados em aplicações modernas, os bancos de dados relacionais tradicionais começaram a enfrentar desafios de escalabilidade. Nesse contexto, surgiram as soluções NoSQL (*Not Only SQL*), voltadas para cenários em que a velocidade e a capacidade de expansão horizontal são prioridades.

Este seminário apresentará o **Apache Cassandra**, um Sistema Gerenciador de Banco de Dados (SGBD) NoSQL orientado a colunas. O objetivo é explicar os conceitos fundamentais dessa tecnologia, como ela difere dos bancos relacionais tradicionais, e por que empresas a utilizam para gerenciar grandes volumes de dados distribuídos.

## 2. O SGBD: Apache Cassandra

Originalmente criado pelo Facebook e hoje mantido pela Apache Software Foundation, o Cassandra é um banco de dados distribuído que tem como foco a alta disponibilidade e a leitura rápida, mesmo em escala massiva.

Os principais conceitos que serão abordados incluem:

- **Modelo de Dados Baseado em Colunas:** diferentemente de um banco relacional, a modelagem foca em colunas largas (*wide columns*), priorizando a velocidade de leitura para consultas específicas e previamente conhecidas.
- **Desnormalização (sem JOINs):** explicação sobre como os dados são duplicados de forma proposital e agrupados nas tabelas para evitar operações complexas no momento da leitura.
- **CQL (Cassandra Query Language):** a linguagem usada para interagir com o banco, com sintaxe muito semelhante ao SQL tradicional, o que facilita o uso por desenvolvedores já familiarizados com bancos relacionais.

## 3. Proposta Prática

Para demonstrar o funcionamento do SGBD de forma objetiva, a equipe focará na **modelagem de dados orientada a consultas** e nas **operações básicas de CRUD** (*Create, Read, Update, Delete*).

### 3.1. O Cenário de Aplicação

Será modelado o banco de dados de um pequeno catálogo de filmes e séries (inspirado em plataformas de streaming). O foco será mostrar como as tabelas são pensadas a partir das telas da aplicação e das consultas que o usuário fará — e não a partir de um modelo entidade-relacionamento normalizado, como seria feito em um SGBD relacional.

### 3.2. O que será implementado

- **Ambiente simplificado:** utilização de uma instância local do Cassandra via Docker, ou do DataStax Astra DB (versão gratuita do Cassandra na nuvem, que não exige instalação de infraestrutura).
- **Criação do banco de dados:** construção do *Keyspace* (equivalente ao banco de dados) e das tabelas estruturadas usando a linguagem CQL.
- **Modelagem orientada a consulta:** demonstração de criação de tabelas otimizadas, como `filmes_por_categoria` e `filmes_por_ano`, ilustrando na prática como chaves de partição e chaves de ordenação (*clustering keys*) funcionam.
- **Operações práticas:** execução de comandos de inserção, busca, atualização e exclusão para popular o catálogo e demonstrar as funcionalidades reais do sistema.

## 4. Estrutura de Entrega

Será criado um repositório público no GitHub para concentrar todos os artefatos da pesquisa, contendo:

- O documento final ampliado do seminário;
- Os arquivos contendo os códigos `.cql` das tabelas e dos dados de teste;
- Um guia simples de como executar o banco de dados e reproduzir a demonstração.

## 5. Referências Bibliográficas

APACHE CASSANDRA PROJECT. **Apache Cassandra Documentation**. Disponível em: <https://cassandra.apache.org/doc/latest/>. Acesso em: 25 jun. 2026.
