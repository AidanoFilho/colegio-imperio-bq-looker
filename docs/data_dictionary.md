# 📘 Dicionário de Dados – Colégio Império

Este documento descreve as tabelas, colunas, tipos de dados e regras de negócio
utilizadas no projeto analítico do **Colégio Império**, desenvolvido em BigQuery
e consumido via Looker Studio.

O objetivo deste dicionário é facilitar o entendimento, manutenção e uso correto
dos dados por analistas, engenheiros de dados e stakeholders.

---

## 🧱 Visão Geral da Arquitetura

O projeto segue uma arquitetura em camadas, inspirada no modelo **Medallion**:

- **Bronze:** carga inicial de dados
- **Silver:** ajustes e atualizações via staging e MERGE
- **Gold:** tabelas consolidadas e métricas para consumo analítico e BI

---

## 🧑‍🎓 Tabela: `estudante` (Dimensão)

Tabela de dimensão que armazena os dados cadastrais dos estudantes.

| Coluna         | Tipo   | Descrição                        |
| -------------- | ------ | -------------------------------- |
| estudante_id   | INT64  | Identificador único do estudante |
| nome_estudante | STRING | Nome completo do estudante       |

---

## 📚 Tabela: `materia` (Dimensão)

Tabela de dimensão que armazena as disciplinas oferecidas pelo colégio.

| Coluna       | Tipo   | Descrição                      |
| ------------ | ------ | ------------------------------ |
| materia_id   | INT64  | Identificador único da matéria |
| nome_materia | STRING | Nome da disciplina             |

---

## 📝 Tabela: `notas` (Fato)

Tabela fato que armazena as notas dos estudantes por matéria, semestre e data.

| Coluna       | Tipo    | Descrição                                                        |
| ------------ | ------- | ---------------------------------------------------------------- |
| estudante_id | INT64   | Identificador do estudante (FK para `estudante`)                 |
| materia_id   | INT64   | Identificador da matéria (FK para `materia`)                     |
| nota         | NUMERIC | Nota obtida pelo aluno (escala de 0 a 10)                        |
| semestre     | INT64   | Semestre letivo                                                  |
| data         | DATE    | Data de lançamento da nota                                       |
| pam          | NUMERIC | Avaliação do aluno sobre a disciplina (PAM – percepção do aluno) |

---

## 🛠️ Tabela: `atualizacao_nota` (Silver – Staging)

Tabela de **staging** utilizada para registrar ajustes pontuais de notas antes
de aplicá-los na tabela fato `notas`.

Essa abordagem evita alterações diretas na tabela fato e permite cargas
incrementais seguras via operação de MERGE.

| Coluna       | Tipo    | Descrição                              |
| ------------ | ------- | -------------------------------------- |
| estudante_id | INT64   | Identificador do estudante             |
| materia_id   | INT64   | Identificador da matéria               |
| nota         | NUMERIC | Nova nota a ser inserida ou atualizada |
| semestre     | INT64   | Semestre letivo                        |
| data         | DATE    | Data associada à atualização da nota   |
| pam          | NUMERIC | Avaliação PAM atualizada               |

📌 **Observação:**  
Os registros desta tabela são consumidos pela operação de `MERGE`, que realiza
UPDATE ou INSERT na tabela `notas` conforme a existência do registro.

---

## 📊 Tabela: `notas_alunos` (Gold)

Tabela consolidada para consumo analítico e visualização em BI, resultante do
join entre a tabela fato `notas` e as dimensões `estudante` e `materia`.

| Coluna   | Tipo    | Descrição         |
| -------- | ------- | ----------------- |
| nome     | STRING  | Nome do estudante |
| materia  | STRING  | Nome da matéria   |
| nota     | NUMERIC | Nota obtida       |
| semestre | INT64   | Semestre letivo   |
| data     | DATE    | Data da nota      |
| pam      | NUMERIC | Avaliação PAM     |

---

## 🎓 Tabela: `media_alunos` (Gold)

Tabela de métricas acadêmicas que calcula a média de notas por estudante e
matéria, aplicando regras de negócio para classificação do desempenho.

| Coluna   | Tipo    | Descrição                                               |
| -------- | ------- | ------------------------------------------------------- |
| aluno    | STRING  | Nome do estudante                                       |
| materia  | STRING  | Nome da matéria                                         |
| media    | NUMERIC | Média das notas do aluno (2 casas decimais)             |
| situacao | STRING  | Situação acadêmica (Aprovado, Recuperação ou Reprovado) |

---

## 📐 Regras de Negócio

- A média é calculada por **estudante e matéria**
- Classificação do desempenho:
  - Média ≥ 7,0 → **Aprovado**
  - Média ≥ 4,0 → **Recuperação**
  - Média < 4,0 → **Reprovado**
- Ajustes de notas são feitos via tabela de staging (`atualizacao_nota`)
- Atualizações aplicadas com `MERGE`, garantindo idempotência e rastreabilidade

---

## ℹ️ Observações Finais

- As tabelas da camada **Gold** são utilizadas diretamente no Looker Studio
- Transformações e regras de negócio são centralizadas no SQL
- O modelo foi projetado para facilitar manutenção, auditoria e escalabilidade
