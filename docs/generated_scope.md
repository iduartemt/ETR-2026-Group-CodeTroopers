# Generated Scope — Lab 8

## Selected slice
- **Epic/Area:** Intake & Data Quality (Módulo de Inventário)
- **Slice:** A — Intake & Discovery (Data Capture & Validation)
- **Short description:** Protótipo funcional do formulário de recolha de ativos, focado no motor de regras de Data Quality e na lógica de consistência cruzada entre campos dependentes.

## Actors / roles
- **Primary actor:** Transition Lead (Utilizador final responsável pela submissão)
- **Secondary actor:** Data Steward (Gestor de qualidade responsável pela definição das regras de integridade)

## Use Cases implemented
- **UC-01:** Submeter Novo Ativo (Implementação da lógica de transição entre estados "Draft" e "Ready").
- **UC-04:** Validar Regras de Consistência (Motor de regras síncrono que impede a entrada de dados inconsistentes ou obsoletos).

## Requirements implemented (10 items)
1.  **REQ-001:** Validação de Campos Obrigatórios (Nome do Sistema, Owner, Modelo de Suporte).
2.  **REQ-002:** Condicionalidade de Teste de Disaster Recovery (Se DR="Sim", a data de teste torna-se obrigatória).
3.  **REQ-003:** Deteção de Inconsistência de DR (Bloqueio se DR="Não" mas o utilizador preenche uma data de teste).
4.  **REQ-004:** Validação de URL de Dashboard (Exigência de formato HTTPS válido para evidência de observabilidade).
5.  **REQ-005:** Validação de Caducidade de Evidências (Rejeição de ficheiros/metadados com data superior a 365 dias).
6.  **REQ-006:** Identificação de Owner em Integrações (Validação de formato de email/ID para cada integração).
7.  **REQ-007:** Prevenção de Duplicados (Simulação de verificação de unicidade de Hostname na Asset Database).
8.  **REQ-008:** Gestão de Estados de Submissão (Permitir guardar como "Draft" ignorando validações cruzadas).
9.  **REQ-009:** Transição Final "Ready to Proceed" (Gatekeeper que exige 100% de sucesso nas regras de consistência).
10. **NFR-001:** Log de Auditoria (Simulação de registo de alteração de campos críticos: UserID, Timestamp, Old/New Value).

## Variant constraints implemented (min. 2)
- **Constraint 1: Sanidade Lógica (Cross-field Validation).** O sistema garante a integridade dos dados através de lógica dependente (Variante 4), onde a seleção de um campo altera dinamicamente a obrigatoriedade ou validade de outros (ex: regras de DR).
- **Constraint 2: Integridade Temporal e Qualidade.** Atuação como filtro ativo ("Lixo não entra"), rejeitando automaticamente evidências expiradas ou dados contraditórios antes de permitir a transição para o estado operacional.

## Out of scope (explicit)
- Persistência real em Base de Dados (SQL/NoSQL) no Backend.
- Integração real via API com sistemas externos (Active Directory ou CMDB real).
- Sistema de Autenticação e Gestão de Permissões de utilizadores.
- Dashboards de monitorização global ou exportação de relatórios (Slices B e C).