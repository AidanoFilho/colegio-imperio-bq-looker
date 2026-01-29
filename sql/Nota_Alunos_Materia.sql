-- ================================================================
-- Projeto: Colégio Império — Notas & PAM
-- Arquivo: Nota_Alunos_Materia.sql
-- Tipo: Gold / Tavela de consumo para BI
-- Objetivo:
--  -Consolidar as notas por estudante e matéria em uma tabela única e pronta
--  -para consumo no Looker Studio (ou outras ferramentas de BI).
--
-- Fonte:
--  - fato: `bqportfolio.colegioimperio.notas`
-- - dimensões: `bqportfolio.colegioimperio.estudante`, `bqportfolio.colegioimperio.materia`
-- ================================================================

CREATE OR REPLACE TABLE `bqportfolio.colegioimperio.notas_alunos` AS

SELECT
E.nome_estudante AS nome,
M.nome_materia AS materia,
N.nota,
N.semestre,
N.data,
N.pam

FROM `bqportfolio.colegioimperio.notas` AS N

JOIN `bqportfolio.colegioimperio.estudante` AS E
ON N.estudante_id = E.estudante_id

JOIN `bqportfolio.colegioimperio.materia` AS M
ON N.materia_id = M.materia_id

ORDER BY 
 E.nome_estudante,
 M.nome_materia,
 N.semestre;
