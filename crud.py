"""
crud.py — Operações CRUD no banco AtividadesProj (MongoDB)
Disciplina: Projeto e Administração de Banco de Dados

Dependência: pip install pymongo

Uso: python crud.py
"""

from datetime import datetime
from pymongo import MongoClient
from pymongo.errors import ConnectionFailure, OperationFailure

MONGO_URI = "mongodb://app_user:app_senha123@localhost:27017/AtividadesProj"


# ─────────────────────────────────────────
# Conexão
# ─────────────────────────────────────────

def conectar():
    """Retorna (client, db). Lança exceção se a conexão falhar."""
    client = MongoClient(MONGO_URI, serverSelectionTimeoutMS=5000)
    client.admin.command("ping")
    return client, client["AtividadesProj"]


# ─────────────────────────────────────────
# CREATE — Inserir nova atividade em um projeto existente
# ─────────────────────────────────────────

def criar_atividade(db, nome_projeto: str, atividade: dict) -> bool:
    """
    Insere uma nova atividade no array 'atividades' de um projeto.

    Parâmetros:
        db           -- banco de dados MongoDB
        nome_projeto -- nome do projeto alvo
        atividade    -- dicionário com os dados da atividade
    """
    resultado = db.projetos.update_one(
        {"nome": nome_projeto},
        {"$push": {"atividades": atividade}},
    )
    if resultado.matched_count == 0:
        print(f"  ✗ Projeto '{nome_projeto}' não encontrado.")
        return False
    print(f"  ✓ Atividade '{atividade['titulo']}' adicionada ao projeto '{nome_projeto}'.")
    return True


# ─────────────────────────────────────────
# READ — Listar todos os projetos e suas atividades
# ─────────────────────────────────────────

def listar_projetos_e_atividades(db) -> None:
    """Lista todos os projetos com nome, status e suas atividades."""
    projetos = list(db.projetos.find({}, {"nome": 1, "status": 1, "atividades": 1}))
    if not projetos:
        print("  Nenhum projeto encontrado.")
        return
    for proj in projetos:
        print(f"\n  📁 {proj['nome']}  [status: {proj['status']}]")
        atividades = proj.get("atividades", [])
        if not atividades:
            print("     (sem atividades)")
        for i, atv in enumerate(atividades, 1):
            print(
                f"     {i}. [{atv.get('status','?'):12}] {atv['titulo']}"
                f"  (prioridade: {atv.get('prioridade','?')})"
            )


# ─────────────────────────────────────────
# UPDATE — Atualizar o líder de um projeto específico
# ─────────────────────────────────────────

def atualizar_lider(db, nome_projeto: str, nome_novo_lider: str) -> bool:
    """
    Atualiza o campo 'lider_id' de um projeto com base no nome do novo líder.

    Parâmetros:
        db              -- banco de dados MongoDB
        nome_projeto    -- nome do projeto a atualizar
        nome_novo_lider -- nome do empregado que será o novo líder
    """
    lider = db.empregados.find_one({"nome": nome_novo_lider})
    if not lider:
        print(f"  ✗ Empregado '{nome_novo_lider}' não encontrado.")
        return False
    resultado = db.projetos.update_one(
        {"nome": nome_projeto},
        {"$set": {"lider_id": lider["_id"]}},
    )
    if resultado.matched_count == 0:
        print(f"  ✗ Projeto '{nome_projeto}' não encontrado.")
        return False
    print(f"  ✓ Líder do projeto '{nome_projeto}' atualizado para '{nome_novo_lider}'.")
    return True


# ─────────────────────────────────────────
# DELETE — Remover uma atividade de um projeto
# ─────────────────────────────────────────

def remover_atividade(db, nome_projeto: str, titulo_atividade: str) -> bool:
    """
    Remove uma atividade (por título) do array 'atividades' de um projeto.

    Parâmetros:
        db               -- banco de dados MongoDB
        nome_projeto     -- nome do projeto
        titulo_atividade -- título exato da atividade a remover
    """
    resultado = db.projetos.update_one(
        {"nome": nome_projeto},
        {"$pull": {"atividades": {"titulo": titulo_atividade}}},
    )
    if resultado.matched_count == 0:
        print(f"  ✗ Projeto '{nome_projeto}' não encontrado.")
        return False
    if resultado.modified_count == 0:
        print(f"  ✗ Atividade '{titulo_atividade}' não encontrada no projeto '{nome_projeto}'.")
        return False
    print(f"  ✓ Atividade '{titulo_atividade}' removida do projeto '{nome_projeto}'.")
    return True


# ─────────────────────────────────────────
# MAIN
# ─────────────────────────────────────────

def main():
    sep = "=" * 60
    print(sep)
    print("  CRUD — AtividadesProj (MongoDB)")
    print(sep)

    try:
        client, db = conectar()
        print("\n  ✓ Conexão estabelecida com sucesso!")
    except (ConnectionFailure, OperationFailure) as e:
        print(f"\n  ✗ Falha na conexão: {e}")
        return

    # ── READ: estado inicial ─────────────────────────────────
    print("\n[READ] Listando projetos e atividades (estado inicial):")
    print("-" * 60)
    listar_projetos_e_atividades(db)

    # ── CREATE: nova atividade ───────────────────────────────
    print("\n\n[CREATE] Inserindo nova atividade em 'Portal do Colaborador'...")
    print("-" * 60)
    nova_atividade = {
        "titulo": "Deploy em Produção",
        "descricao": "Publicação da versão 1.0 no ambiente de produção.",
        "responsavel_id": None,
        "status": "pendente",
        "prioridade": "alta",
        "data_inicio": datetime(2024, 6, 1),
        "data_fim_prevista": datetime(2024, 6, 15),
    }
    criar_atividade(db, "Portal do Colaborador", nova_atividade)

    # ── UPDATE: novo líder ───────────────────────────────────
    print("\n[UPDATE] Atualizando líder do projeto 'Migração para Cloud'...")
    print("-" * 60)
    atualizar_lider(db, "Migração para Cloud", "Bruno Lima")

    # ── DELETE: remover atividade ────────────────────────────
    print("\n[DELETE] Removendo atividade 'Relatórios Gerenciais'...")
    print("-" * 60)
    remover_atividade(db, "Sistema de Avaliação de Desempenho", "Relatórios Gerenciais")

    # ── READ: estado final ───────────────────────────────────
    print("\n\n[READ] Listando projetos e atividades (estado final):")
    print("-" * 60)
    listar_projetos_e_atividades(db)

    client.close()
    print(f"\n\n  ✓ Conexão encerrada.")
    print(sep)


if __name__ == "__main__":
    main()
