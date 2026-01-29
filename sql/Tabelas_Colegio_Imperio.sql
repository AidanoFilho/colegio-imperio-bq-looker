-- =================================================================================================
-- Projeto: Notas Colégio Império 
-- Dataset: bqportfolio.colegioimperio
-- Arquivo: Tabelas_Colegio_Imperio.sql
-- Tipo: Tabela DDL (cria a estrutura das tabelas principais)
-- Objetivo: 
--  - Criar tabelas com boas práticas de modelagem analítica no BigQuery;
--  - Definir chaves lógicas (NOT ENFORCED)
--  - Aplicar particionamento e clusterização
-- Autor: Aidano da Silva Filho
-- =================================================================================================

-- ---------- TABELA ESTUDANTES ------------------
CREATE TABLE IF NOT EXISTS `bqportfolio.colegioimperio.estudante`
(
  estudante_id INT64 NOT NULL OPTIONS (description = "id único do estudante"),
  nome_estudante STRING OPTIONS (description ="Nome do estudante"),
  PRIMARY KEY (estudante_id) NOT ENFORCED 
);

--Observação: 
--PRIMARY KEY ... NOT ENFORCED Serve como metadado/documentação e pode ajudar o otimizador em alguns cenários.

-- ---------- TABELA MATÉRIA ------------------
CREATE TABLE IF NOT EXISTS `bqportfolio.colegioimperio.materia`
(
  materia_id INT64 NOT NULL OPTIONS (description= "id único da matéria"),
  nome_materia STRING OPTIONS (description= "Nome da matéria"),
  PRIMARY KEY (materia_id) NOT ENFORCED
);

-- ---------- TABELA NOTAS ------------------
CREATE TABLE IF NOT EXISTS `bqportfolio.colegioimperio.notas`
(
  estudante_id INT64 NOT NULL OPTIONS(description= "Foreign Key lógica para estudante.estudante_id"),
  materia_id INT64 NOT NULL OPTIONS (description = "Foreign Key lógica para materia.materia_id"),
  nota NUMERIC OPTIONS (description = "Nota do estudante na matéria em um determinado semestre") ,
  semestre INT64 OPTIONS (description= "Semestre em que a nota foi registrada, ela deve ser preenchida como 1 para Primeiro, 2 para o Segundo, 3 para Terceiro e 4 para o Quarto semestre"),
  data DATE OPTIONS (description= "Data do lançamento da nota"),
    pam NUMERIC OPTIONS (description = "Essa métrica representa a percepção do aluno sobre a matéria que varia de 0 a 10. PAM -> Percepção do Aluno Sobre a Matéria")
)
PARTITION BY data
CLUSTER BY estudante_id, materia_id;

--Observações:
--Particionamento por data ajuda a reduzir custo/performance ao filtrar por período.
-- Cluster por estudante_id e materia_id melhora performance em joins e filtros nessas colunas.
