-- ================================================================================
-- Projeto: Colégio Império — Notas & PAM
-- Arquivo: Tabela_Ajuste_Notas.sql
-- Tipo: Tabela Staging (Ajustes Manuais)
-- Objetivo: 
--  - Criar uma tabela de staging para ajustes pontuais de notas;
--  -  Permitir correções e inclusões controladas antes do MERGE na tabela fato de notas.
--
-- Caso de uso:
--   1) Correção da nota de Física da estudante Anna
--   2) Inclusão da nota de História do estudante Aidano
--
-- Observação:
--   -Este padrão evita updates diretos na tabela fato e
--   -segue boas práticas de pipelines analíticos.
-- ================================================================================

CREATE OR REPLACE TABLE `bqportfolio.colegioimperio.atualizacao_nota`
(
  estudante_id INT64,
  materia_id INT64,
  nota NUMERIC,
  semestre INT64,
  data DATE,
  pam NUMERIC
 
);

-- Correção da nota de Física da Anna e inclusão da nota de História do Aidano
INSERT INTO `bqportfolio.colegioimperio.atualizacao_nota` (estudante_id, materia_id, nota, semestre, data, pam) VALUES
(1,10,7,1,DATE '2026-03-08',8),
(2,40,10,1,DATE '2026-03-08',10);
