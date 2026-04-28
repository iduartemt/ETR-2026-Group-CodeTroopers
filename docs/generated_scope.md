# Generated Scope — Lab 8

## Selected slice
- **Epic/Area:** Intake & Data Quality (Módulo de Inventário)
- **Slice:** A — Intake & Discovery (Data Capture & Validation)
- **Short description:** Protótipo funcional do formulário de recolha de ativos, focado no motor de regras de Data Quality e na lógica de consistência cruzada entre campos dependentes para a Variante 4.

## Actors / roles
- **Primary actor:** Transition Lead (Utilizador responsável pela submissão inicial e correção de dados)
- **Secondary actor:** Data Steward (Persona da Variante 4, responsável por validar a integridade final dos dados)

## Use Cases implemented
- **UC-01:** Submeter Novo Ativo (Focado na transição lógica entre "Draft" e "Ready to Proceed").
- **UC-04:** Validar Regras de Consistência (Implementação do motor de validação que atua como Gatekeeper).

## Requirements implemented (10 items)
1.  **REQ-001:** Validação de Campos Obrigatórios (Nome do Sistema, Owner, Modelo de Suporte).
2.  **REQ-002:** Condicionalidade de Disaster Recovery (Data de teste torna-se obrigatória se DR="Sim").
3.  **REQ-003:** Deteção de Inconsistência de DR (Bloqueio se houver data de teste com DR="Não").
4.  **REQ-004:** Validação de URL de Dashboard (Formato HTTPS obrigatório para evidências).
5.  **REQ-005:** Validação de Caducidade de Evidências (Bloqueio de ficheiros/metadados com mais de 365 dias).
6.  **REQ-006:** Identificação de Owner (Validação de formato e simulação de verificação no diretório/AD).
7.  **REQ-007:** Prevenção de Duplicados (Simulação de erro se o Hostname já existir na base de dados).
8.  **REQ-008:** Gestão de Estados (Permitir guardar rascunhos incompletos para terminar mais tarde).
9.  **REQ-009:** Transição Final "Ready to Proceed" (Apenas permitida com 0 erros de validação ativa).
10. **NFR-001:** Log de Auditoria (Registo cronológico de quem alterou o quê e quando).

## Variant constraints implemented (min. 2)
- **Constraint 1: Sanidade Lógica Cross-field (Variante 4).** A validade de um campo depende do valor de outro (ex: Tier vs RTO/RPO), impedindo dados contraditórios.
- **Constraint 2: Filtro de Integridade Temporal.** O sistema rejeita ativamente evidências obsoletas, garantindo que o inventário está sempre atualizado (Data Freshness).

## Out of scope (explicit)
- Ligação real a uma Base de Dados persistente (armazenamento em LocalStorage/Memória).
- Integração real via API com o Active Directory (simulado por Regex/Mock).
- Gestão de permissões de utilizador (Auth/RBAC).
- Exportação de ficheiros físicos (apenas visualização em ecrã).
- Dashboards de monitorização global ou exportação de relatórios (Slices B e C).
