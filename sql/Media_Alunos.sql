-- =========================================================================
-- Projeto: Colégio Império — Notas & PAM
-- Arquivo: Media_Alunos.sql
-- Tipo: Gold (camada final com regras de negócio)
-- Objetivo:
--  -Calcular a média de notas por estudante e matéria;
--  -classificar o desempenho acadêmico em Aprovado, Recuperação ou Reprovado.
-- Autor: Aidano da Silva Filho
-- =========================================================================

CREATE OR REPLACE TABLE `bqportfolio.colegioimperio.media_alunos` AS

SELECT
E.nome_estudante AS aluno,
M.nome_materia AS materia,

ROUND(AVG(N.nota),2) AS media,

CASE
  WHEN ROUND(AVG(N.nota),2) >= 7 THEN 'Aprovado'
  WHEN ROUND(AVG(N.nota),2) >= 4 THEN 'Recuperação'
  ELSE 'Reprovado'
END AS situacao 
 
FROM `bqportfolio.colegioimperio.notas` AS N

JOIN `bqportfolio.colegioimperio.estudante` AS E
ON E.estudante_id = N.estudante_id

JOIN `bqportfolio.colegioimperio.materia` AS M
ON M.materia_id = N.materia_id

GROUP BY aluno,materia
ORDER BY aluno, materia;
