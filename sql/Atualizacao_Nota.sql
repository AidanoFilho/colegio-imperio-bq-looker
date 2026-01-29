--=====================================================================
-- Projeto: Colégio Império — Notas & PAM
-- Arquivo: Atualizacao_Nota.sql
-- Tipo: MERGE (Upsert incremental)
-- Objetivo:
--   -Aplicar ajustes pontuais na tabela fato `notas` usando a tabela de staging atualizacao_nota`, realizando:
--     1) UPDATE quando o registro já existe e algum campo mudou
--     2) INSERT quando o registro não existe na tabela destino
--
-- Observação:
--  -Este padrão torna a carga reexecutável (idempotente) e evita alterações manuais
--  -diretas na tabela fato.
-- Autor: Aidano da Silva Filho
--=====================================================================

MERGE `bqportfolio.colegioimperio.notas` AS T
USING `bqportfolio.colegioimperio.atualizacao_nota` AS S

ON T.estudante_id = S.estudante_id
AND T.materia_id = S.materia_id
AND T.semestre = S.semestre

-- 1) Quando houver correspondência (UPDATE)
WHEN MATCHED AND (T.nota != S.nota OR T.data != S.data OR T.pam != S.pam) THEN
  UPDATE SET 
    T.nota = S.nota,
    T.data = S.data,
    T.pam = S.pam

-- 2) Quando o registro existir na origem mas não no destino (INSERT)
WHEN NOT MATCHED BY TARGET THEN
INSERT (estudante_id, materia_id, nota, semestre, data, pam)
VALUES (S.estudante_id, S.materia_id, S.nota, S.semestre, S.data, S.pam);
