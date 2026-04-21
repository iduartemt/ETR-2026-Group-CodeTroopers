# Generated Scope — Lab 8 (Vibe Coding)

## Implementation Target
**Selected Slice:** Slice A: Intake session → capture answers (with a focus on Validation)
**Epic Area:** Validação de Intake & Validação Cruzada
**Variant Focus:** Variant 4 — Data Quality & Consistency (Data Steward)

## Selected Use Cases
* **UC-01 — Submeter Novo Ativo:** Registar um ativo garantindo integridade total de dados.
* **UC-04 — Validar Regras de Consistência (Backend):** Garantir que não existem dados contraditórios ou obsoletos.

## Selected Requirements (Scope Lock)
1.  **REQ-001 (Mandatory Base Fields):** Block submission if "Nome do Sistema", "Owner", or "Criticidade" are empty/null.
2.  **REQ-002 (DR Conditionality):** If "Disaster Recovery" is "Sim", then "Data do Último Teste" becomes mandatory.
3.  **REQ-003 (DR Inconsistency):** If "Disaster Recovery" is "Não", but a date is provided (or RTO/RPO is left empty for Tier 1/2), mark as inconsistent.
4.  **REQ-004 (Evidence Expiration):** Reject evidence files older than 365 days.
5.  **REQ-006 (Submission State Management):** Allow "Guardar Rascunho" (Draft) to bypass validations, but block "Submeter Final" (Ready) if errors exist.
