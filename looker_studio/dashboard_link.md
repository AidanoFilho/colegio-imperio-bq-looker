# 📊 Dashboard Educacional – Colégio Império

🔗 **Acesse o dashboard interativo no Looker Studio:**
👉 https://lookerstudio.google.com/reporting/667dd328-6668-4db8-92fd-873c9b2773a8

## 🎯 Objetivo

Analisar o desempenho acadêmico dos alunos do Colégio Império por meio
de indicadores de notas, médias e situação acadêmica.

## 🗄️ Fonte dos Dados

Os dados são provenientes do BigQuery e seguem uma arquitetura em camadas:

- Bronze: carga inicial de dados
- Silver: ajustes via staging e MERGE
- Gold: tabelas consolidadas para BI (`notas_alunos`, `media_alunos`)

## 📈 Principais Métricas

- Média Geral
- Taxa de aprovação
- PAM
- Nota por Matéria
- Distribuição de notas por semestre
- Avaliação PAM

## 🎛️ Filtros Disponíveis

- Aluno
- Matéria
- Semestre

## 🔍 O que observar

- Aplicação de regras de negócio no SQL
- Separação entre transformação de dados e visualização
- Estrutura pensada para escalabilidade e manutenção

## 🖼️ Visão Geral do Dashboard

![Dashboard – Visão Geral](https://github.com/AidanoFilho/colegio-imperio-bq-looker/blob/main/imagem/dashboard/Dashbord%200.png)

## 🛠️ Tecnologias Utilizadas

- BigQuery
- SQL
- Looker Studio
- GitHub
