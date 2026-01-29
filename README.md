# 📚 Colégio Império — Análise de Notas & PAM

**BigQuery (SQL) • Looker Studio (Dashboard)**

Projeto de portfólio focado em **modelagem analítica no Google BigQuery**, **boas práticas em SQL** e **visualização de dados no Looker Studio**, aplicado a um cenário educacional fictício: o **Colégio Império**.

O projeto analisa o desempenho acadêmico dos alunos ao longo dos semestres e investiga a relação entre **Nota** e **PAM (Percepção do Aluno sobre a Matéria)**, apoiando decisões pedagógicas e de gestão.

> **Autor:** Aidano da Silva Filho  
> **Stack:** Google BigQuery (SQL) • Looker Studio  
> **Dataset:** `bqportfolio.colegioimperio`

🔗 **Dashboard interativo (Looker Studio):**  
https://lookerstudio.google.com/reporting/667dd328-6668-4db8-92fd-873c9b2773a8

---

## 🎯 Objetivo de Negócio

A gestão do Colégio Império solicitou uma solução analítica que permitisse:

1. **Acompanhar o desempenho dos alunos** por matéria e semestre  
2. Monitorar metas institucionais:
   - **Média Geral alvo:** 7,5  
   - **% de Aprovação alvo:** 80%  
   - **PAM alvo:** 7,5  
3. Avaliar se existe relação entre **Nota acadêmica** e **PAM**

### Regras de Status Acadêmico

- **Aprovado:** nota ≥ 7  
- **Recuperação:** 4 ≤ nota < 7  
- **Reprovado:** nota < 4  

---

## 📁 Estrutura do Projeto

```text
colegio-imperio-bq-looker/
├── README.md
├── sql/
│   ├── bronze/
│   │   ├── Tabelas_Colegio_Imperio.sql
│   │   └── Carregamento_Nota.sql
│   │
│   ├── silver/
│   │   ├── Tabela_Ajuste_Notas.sql
│   │   └── Atualizacao_Nota.sql
│   │
│   └── gold/
│       ├── Nota_Alunos_Materia.sql
│       └── Media_Alunos.sql
│
├── looker_studio/
│   └── dashboard_link.md
│
├── docs/
│   ├── data_dictionary.md
│   └── assumptions.md
│
└── images/
    ├── bigquery/
    └── dashboard/
```
---

## 🧱 Modelagem de Dados (BigQuery)

O projeto utiliza uma **modelagem em estrela**, adequada para ambientes analíticos e dashboards.

### 🔹 Tabelas Dimensão

**`estudante`**

- `estudante_id` (PK lógica)
- `nome_estudante`

**`materia`**

- `materia_id` (PK lógica)
- `nome_materia`

### 🔸 Tabela Fato

**`notas`**

- `estudante_id` (FK lógica)
- `materia_id` (FK lógica)
- `nota`
- `semestre`
- `data` *(particionamento)*
- `pam`

### ✅ Boas práticas aplicadas

- **PARTITION BY `data`** para redução de custo em consultas temporais  
- **CLUSTER BY (`estudante_id`, `materia_id`)** para otimização de filtros e joins  
- **PRIMARY KEY / FOREIGN KEY NOT ENFORCED** como documentação e metadado no BigQuery  
- Scripts **reexecutáveis**, com `TRUNCATE` antes das cargas  
- Uso de **tabela staging** e **`MERGE`** para ajustes controlados de dados  

---

## 🔁 Pipeline do Projeto (SQL)

Fluxo lógico do projeto no BigQuery:

1. Criação das tabelas:
   - `estudante`
   - `materia`
   - `notas`
2. Carga de dados simulados (dimensões e fato)
3. Criação da tabela de staging:
   - `atualizacao_nota`
4. Aplicação de ajustes via `MERGE` (staging → fato)
5. Criação de tabelas consolidadas para BI:
   - `notas_alunos`
   - `media_alunos`

Essas tabelas finais são consumidas diretamente pelo **Looker Studio**.

---

## 📊 Dashboard (Looker Studio)

O dashboard permite análise dinâmica através de filtros por:

- **Aluno**
- **Matéria**
- **Semestre**

### Principais Visões

- **Cards de metas:**  
  - Média Geral  
  - % Aprovação  
  - PAM  
- **Média por Matéria**
- **Média por Semestre**
- **Tabela dinâmica de notas por semestre**
- **Ranking de alunos (média geral)**
- **Gráfico de dispersão PAM × Nota**

### 📌 Principais Insights

- **Maior gap identificado:** % de Aprovação abaixo da meta  
- **Matéria ofensor:** Geografia, com menor média geral  
- **Alunos com pior desempenho médio:** Bruno e Diego  
- Evidência de **relação positiva moderada** entre PAM e Nota, com dispersão relevante  

---

## 🖼️ Dashboard – Visão Geral

![Dashboard Colégio Império](https://github.com/AidanoFilho/colegio-imperio-bq-looker/blob/main/imagem/dashboard/Dashbord%200.png)

---

## ▶️ Como Reproduzir o Projeto

1. **BigQuery**

Execute os scripts SQL **na ordem abaixo**, respeitando as camadas do pipeline:

**Camada Bronze**

- `Tabelas_Colegio_Imperio.sql`
- `Carregamento_Nota.sql`

**Camada Silver**

- `Tabela_Ajuste_Notas.sql`
- `Atualizacao_Nota.sql`

**Camada Gold**

- `Nota_Alunos_Materia.sql`
- `Media_Alunos.sql`

![Fluxo de execução no BigQuery](https://github.com/AidanoFilho/colegio-imperio-bq-looker/blob/main/imagem/bigquery/Fluxo%20de%20execu%C3%A7%C3%A3o%20queries.jpg)

2. **Looker Studio**
   - Conecte às tabelas:
     - `notas_alunos`
     - `media_alunos`
   - Recrie os gráficos e filtros conforme o dashboard publicado

---

## 🚀 Próximos Passos (Roadmap)

- Implementar **validações de dados**:
  - Nota entre 0 e 10  
  - PAM entre 0 e 10  
  - Semestre entre 1 e 4  
- Criar tabela de **metas parametrizáveis** no BigQuery  
- Calcular e exibir **correlação de Pearson** entre Nota e PAM  
- Criar visões por **status acadêmico** (Aprovado / Recuperação / Reprovado)  
- Evoluir o projeto para **dados reais ou incremental load**

---

## 📎 Licença

Este projeto está licenciado sob a **MIT License**.  

---

## 👤 Autor

**Aidano da Silva Filho**  
Analista de Dados | SQL | BigQuery | Looker Studio  

🔗 LinkedIn:  
https://www.linkedin.com/in/aidanofilho/
