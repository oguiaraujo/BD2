// init/init.js
// Script de inicialização do banco AtividadesProj
// Executado automaticamente pelo MongoDB na primeira inicialização do container

db = db.getSiblingDB("AtividadesProj");

// Criar usuário de aplicação
db.createUser({
  user: "app_user",
  pwd: "app_senha123",
  roles: [{ role: "readWrite", db: "AtividadesProj" }],
});

// ─────────────────────────────────────────
// Inserir Departamentos
// ─────────────────────────────────────────
db.departamentos.insertMany([
  {
    nome: "Tecnologia da Informação",
    sigla: "TI",
    responsavel_id: null,
  },
  {
    nome: "Recursos Humanos",
    sigla: "RH",
    responsavel_id: null,
  },
  {
    nome: "Engenharia de Software",
    sigla: "ES",
    responsavel_id: null,
  },
]);

// ─────────────────────────────────────────
// Inserir Empregados
// ─────────────────────────────────────────
db.empregados.insertMany([
  {
    nome: "Ana Souza",
    email: "ana.souza@empresa.com",
    cargo: "Gerente de Projetos",
    departamento: "TI",
    data_admissao: new Date("2020-03-15"),
  },
  {
    nome: "Bruno Lima",
    email: "bruno.lima@empresa.com",
    cargo: "Desenvolvedor Backend",
    departamento: "ES",
    data_admissao: new Date("2021-07-01"),
  },
  {
    nome: "Carla Menezes",
    email: "carla.menezes@empresa.com",
    cargo: "Analista de QA",
    departamento: "ES",
    data_admissao: new Date("2022-01-10"),
  },
  {
    nome: "Diego Ferreira",
    email: "diego.ferreira@empresa.com",
    cargo: "DevOps Engineer",
    departamento: "TI",
    data_admissao: new Date("2019-09-20"),
  },
  {
    nome: "Elisa Rocha",
    email: "elisa.rocha@empresa.com",
    cargo: "Gestora de RH",
    departamento: "RH",
    data_admissao: new Date("2018-05-05"),
  },
]);

// Buscar IDs para referência nas atividades
const ana   = db.empregados.findOne({ nome: "Ana Souza" });
const bruno = db.empregados.findOne({ nome: "Bruno Lima" });
const carla = db.empregados.findOne({ nome: "Carla Menezes" });
const diego = db.empregados.findOne({ nome: "Diego Ferreira" });

// ─────────────────────────────────────────
// Inserir Projetos com Atividades embutidas
// ─────────────────────────────────────────
db.projetos.insertMany([
  {
    nome: "Portal do Colaborador",
    descricao: "Desenvolvimento de um portal interno para gestão de colaboradores.",
    status: "ativo",
    lider_id: ana._id,
    data_inicio: new Date("2024-01-10"),
    data_fim_prevista: new Date("2024-12-31"),
    atividades: [
      {
        titulo: "Levantamento de Requisitos",
        descricao: "Reuniões com stakeholders para mapear funcionalidades.",
        responsavel_id: ana._id,
        status: "concluida",
        prioridade: "alta",
        data_inicio: new Date("2024-01-10"),
        data_fim_prevista: new Date("2024-01-31"),
      },
      {
        titulo: "Desenvolvimento da API REST",
        descricao: "Criação dos endpoints de autenticação e gestão de usuários.",
        responsavel_id: bruno._id,
        status: "em_andamento",
        prioridade: "alta",
        data_inicio: new Date("2024-02-01"),
        data_fim_prevista: new Date("2024-04-30"),
      },
      {
        titulo: "Testes de Integração",
        descricao: "Execução de testes automatizados nos módulos desenvolvidos.",
        responsavel_id: carla._id,
        status: "pendente",
        prioridade: "media",
        data_inicio: new Date("2024-05-01"),
        data_fim_prevista: new Date("2024-05-31"),
      },
    ],
  },
  {
    nome: "Migração para Cloud",
    descricao: "Migração da infraestrutura on-premise para AWS.",
    status: "ativo",
    lider_id: diego._id,
    data_inicio: new Date("2024-03-01"),
    data_fim_prevista: new Date("2024-09-30"),
    atividades: [
      {
        titulo: "Inventário de Servidores",
        descricao: "Catalogar todos os servidores físicos e suas dependências.",
        responsavel_id: diego._id,
        status: "concluida",
        prioridade: "alta",
        data_inicio: new Date("2024-03-01"),
        data_fim_prevista: new Date("2024-03-15"),
      },
      {
        titulo: "Configuração do Ambiente AWS",
        descricao: "Provisionamento de VPC, subnets, grupos de segurança e IAM.",
        responsavel_id: diego._id,
        status: "em_andamento",
        prioridade: "alta",
        data_inicio: new Date("2024-03-16"),
        data_fim_prevista: new Date("2024-04-30"),
      },
      {
        titulo: "Pipeline de CI/CD",
        descricao: "Configuração do GitHub Actions para deploy automatizado.",
        responsavel_id: bruno._id,
        status: "pendente",
        prioridade: "media",
        data_inicio: new Date("2024-05-01"),
        data_fim_prevista: new Date("2024-06-30"),
      },
    ],
  },
  {
    nome: "Sistema de Avaliação de Desempenho",
    descricao: "Implementação de módulo de avaliação 360° para colaboradores.",
    status: "ativo",
    lider_id: ana._id,
    data_inicio: new Date("2024-04-01"),
    data_fim_prevista: new Date("2025-03-31"),
    atividades: [
      {
        titulo: "Definição do Fluxo de Avaliação",
        descricao: "Modelagem do processo de avaliação e aprovação.",
        responsavel_id: ana._id,
        status: "concluida",
        prioridade: "alta",
        data_inicio: new Date("2024-04-01"),
        data_fim_prevista: new Date("2024-04-15"),
      },
      {
        titulo: "Desenvolvimento do Formulário Online",
        descricao: "Criação do formulário de avaliação responsivo.",
        responsavel_id: bruno._id,
        status: "em_andamento",
        prioridade: "media",
        data_inicio: new Date("2024-04-16"),
        data_fim_prevista: new Date("2024-06-30"),
      },
      {
        titulo: "Relatórios Gerenciais",
        descricao: "Dashboard com métricas de desempenho por departamento.",
        responsavel_id: carla._id,
        status: "pendente",
        prioridade: "baixa",
        data_inicio: new Date("2024-07-01"),
        data_fim_prevista: new Date("2024-09-30"),
      },
    ],
  },
]);

print("✅ Banco AtividadesProj inicializado com sucesso!");
print("   - Departamentos: " + db.departamentos.countDocuments());
print("   - Empregados:    " + db.empregados.countDocuments());
print("   - Projetos:      " + db.projetos.countDocuments());
