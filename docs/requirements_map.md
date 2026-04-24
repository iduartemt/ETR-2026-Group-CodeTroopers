# Requirements Map — Lab 3 (Atualizado)

Este documento organiza os requisitos do sistema em Épicos lógicos e destaca a cobertura da Variante 4 (Qualidade e Consistência de Dados).

## EPIC-1: Intake Session & Lifecycle
*Foco na interface de recolha de dados e gestão do estado da submissão.*
- **REQ-001:** Validação de Campos Obrigatórios (Nome, Owner, Modelo de Suporte)
- **REQ-008:** Gestão de Estados de Submissão (Gravação em estado "Draft")
- **REQ-009:** Transição Final de Estado (Gatekeeper para estado "Ready to Proceed")

## EPIC-2: Data Quality & Consistency (Variant Focus)
*Foco nas regras de integridade, sanidade lógica e prevenção de dados obsoletos.*
- **REQ-002:** Condicionalidade de Teste de Disaster Recovery (DR)
- **REQ-003:** Deteção de Inconsistência de DR (Lógica Cruzada)
- **REQ-005:** Validação de Caducidade de Evidências (> 365 dias)
- **REQ-007:** Prevenção de Duplicados (Unicidade de Hostname na CMDB)
- **NFR-002:** Performance de Validação Cruzada (< 500ms)
- **NFR-004:** Qualidade de Dados Garantida (100% compliance para ativos "Ready")
- **NFR-005:** Tempo de Resposta de Feedback de Erro na UI (< 1s)

## EPIC-3: Evidence & Integrations
*Foco em metadados externos e identificação de responsabilidades.*
- **REQ-004:** Validação de URL de Dashboard de Observabilidade
- **REQ-006:** Identificação de Owner em Integrações (Formato de ID/Email)

## EPIC-4: Audit & Compliance (NFR)
*Foco na rastreabilidade histórica e conformidade legal.*
- **NFR-001:** Log de Auditoria (UserID, Timestamp, Antigo/Novo)
- **NFR-003:** Disponibilidade do Serviço (Uptime de 99.9%)
- **NFR-006:** Retenção de Logs de Auditoria (Mínimo 12 meses)

---

## Variant Coverage Summary
* **Variant number:** 4 — Data Quality & Consistency
* **Variant-driven requirements (FR):** REQ-001, REQ-002, REQ-003, REQ-005, REQ-007, REQ-008, REQ-009
* **Variant-driven NFRs:** NFR-002, NFR-004, NFR-005

---

## Traceability Overview
| Epic | Total FRs | Total NFRs | Variant Focus |
|:---|:---:|:---:|:---:|
| EPIC-1 | 3 | 0 | Alta |
| EPIC-2 | 4 | 3 | Máxima |
| EPIC-3 | 2 | 0 | Baixa |
| EPIC-4 | 0 | 3 | Média (Audit) |