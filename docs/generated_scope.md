# Generated Scope — Lab 8

## Selected slice
- Slice: A 
- Short description: Intake session → capture answers (com foco estrito no formulário de recolha, Data Quality e validações cruzadas).

## Actors / roles
- Primary actor: End User
- Secondary actor (optional): Data Steward / Quality Manager

## Use Cases implemented
- UC-01: Submeter Novo Ativo (com simulação de estado "Ready" ou erro/bloqueio)
- UC-04: Validar Regras de Consistência (Simulação das validações no Frontend para efeitos de protótipo)

## Requirements implemented (max 10)
- REQ-001: Validação de Campos Obrigatórios (Nome do Sistema, Owner, Criticidade)
- REQ-002: Condicionalidade de Teste de Disaster Recovery (Se DR="Sim", data é obrigatória)
- REQ-003: Deteção de Inconsistência de DR (Bloqueio se DR="Não" mas tem data; bloqueio de "N/A" em RTO/RPO para Tiers 1 e 2)
- REQ-004: Validação de Caducidade de Evidências (Rejeitar metadados/ficheiros com data > 365 dias)
- REQ-006: Gestão de Estados de Submissão (Guardar Rascunho permite bypass; Submeter Final bloqueia com erros)

## Variant constraints implemented (min. 2)
- Constraint 1: Validação cruzada e consistência de dados (Cross-field validation). O formulário garante que dados dependentes "batem certo" lógicamente antes da submissão (ex: regras de DR e datas).
- Constraint 2: Estados de incompletude explícitos ("Lixo não entra"). O sistema lida com o estado "Rascunho" sem validações, mas aplica regras rigorosas (rejeição de "N/A", datas expiradas) para transitar para o estado validado.

## Out of scope (explicit)
- Backend real, base de dados persistente ou chamadas a APIs externas (ex: NFR-007).
- Verificação real de unicidade do Hostname na Asset DB (REQ-005).
- Autenticação de utilizadores.
- Slices B, C ou D (Dashboards, listas de revisão ou exportação de ficheiros).
