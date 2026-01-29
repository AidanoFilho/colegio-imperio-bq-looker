# 📌 Premissas do Projeto – Colégio Império

Este documento descreve as principais premissas adotadas
no projeto analítico do Colégio Império.

---

## 📊 Premissas sobre os Dados

- Cada estudante possui apenas uma nota por matéria e semestre
- As notas variam de 0 a 10
- O campo PAM representa a avaliação do aluno sobre a disciplina
- Não existem valores nulos nas chaves primárias lógicas

---

## 🧱 Premissas de Modelagem

- A tabela `notas` é a tabela fato do modelo
- As tabelas `estudante` e `materia` são dimensões
- A tabela `atualizacao_nota` é utilizada apenas como staging
- Ajustes são aplicados via MERGE incremental

---

## 📐 Premissas de Regras de Negócio

- A média é calculada por estudante e matéria
- Critérios de situação:
  - Nota ≥ 7,0 → Aprovado
  - Nota ≥ 4,0 → Recuperação
  - Nota < 4,0 → Reprovado

---

## ⚙️ Premissas Técnicas

- BigQuery como data warehouse
- Looker Studio como ferramenta de BI
- Transformações concentradas no SQL

---

## ⚠️ Limitações Conhecidas

- Não há controle histórico de mudanças de notas
- Projeto desenvolvido para fins educacionais e demonstrativos
