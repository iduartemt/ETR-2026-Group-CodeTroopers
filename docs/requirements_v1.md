# Requisitos v1 — Equipa CodeTroopers

**Slice:** Intake & Discovery (AMS)  
**Variante:** 4 — Qualidade e Consistência de Dados (Data Steward)

## 1. Objetivos e Cadeia de Valor
* **OBJ-1: Garantir a integridade e consistência dos dados de inventário.**
* **OBJ-2: Assegurar a rastreabilidade e auditoria do processo de Intake.**

---

## 2. Requisitos Funcionais (FR)

### REQ-001: Validação de Campos Obrigatórios
* **Fonte:** Data Steward / Transition Lead
* **Descrição:** O sistema impede a submissão se "Nome do Sistema", "Owner" ou "Modelo de Suporte" estiverem vazios.
* **Racional:** Evitar o registo de ativos "órfãos" ou sem identificação básica na CMDB.
* **Prioridade:** Alta (H) | **Impacto da Variante:** Sim
* **Método de Validação:** Demonstração (Teste de Interface).
* **Critérios de Aceitação:** - Bloqueio de submissão com campos vazios.
    - Estado do Intake permanece "Incomplete".

### REQ-002: Condicionalidade de Teste de Disaster Recovery (DR)
* **Fonte:** Data Steward / Auditor
* **Descrição:** Se "Disaster Recovery" = "Sim", a "Data do Último Teste" é obrigatória.
* **Racional:** Garantir que sistemas críticos têm evidência de resiliência.
* **Prioridade:** Alta (H) | **Impacto da Variante:** Sim
* **Método de Validação:** Teste de Unidade / Lógica de Interface.

### REQ-003: Deteção de Inconsistência de DR
* **Fonte:** Data Steward (Variante 4)
* **Descrição:** Bloquear estado "Ready" se DR = "Não" mas existir uma data de teste preenchida.
* **Racional:** Manter a sanidade lógica dos dados (evitar contradições).
* **Prioridade:** Alta (H) | **Impacto da Variante:** Sim (Crucial)

### REQ-004: Evidência de Observabilidade (Dashboard URL)
* **Fonte:** Transition Lead
* **Descrição:** Exigir um URL HTTPS válido para o dashboard de monitorização.
* **Racional:** Validar que o ativo está a ser monitorizado antes da transição operacional.
* **Prioridade:** Média (M) | **Impacto da Variante:** Não

### REQ-005: Validação de Caducidade de Evidências
* **Fonte:** Data Steward / Transition Lead
* **Descrição:** Rejeitar evidências operacionais com data superior a 12 meses (365 dias).
* **Racional:** Garantir que o inventário reflete o estado atual e não histórico obsoleto.
* **Prioridade:** Alta (H) | **Impacto da Variante:** Sim (Temporal)

### REQ-006: Identificação de Owner em Integrações
* **Fonte:** Transition Lead
* **Descrição:** Cada integração deve ter um ID de utilizador ou email válido associado.
* **Prioridade:** Média (M) | **Impacto da Variante:** Não

### REQ-007: Prevenção de Duplicados (Unicidade)
* **Fonte:** Data Steward
* **Descrição:** Impedir a criação de ativo se o Hostname já existir na base de dados ativa.
* **Racional:** Evitar distorção na contabilidade de ativos e custos.
* **Prioridade:** Alta (H) | **Impacto da Variante:** Sim (Integridade)

### REQ-008: Gestão de Estados (Rascunho / Draft)
* **Fonte:** Transition Lead
* **Descrição:** Permitir guardar o formulário sem validações cruzadas.
* **Prioridade:** Média (M) | **Impacto da Variante:** Sim (Flexibilidade)

### REQ-009: Transição para "Ready to Proceed"
* **Fonte:** Data Steward
* **Descrição:** O estado "Ready" exige 100% de sucesso em todas as regras de consistência.
* **Prioridade:** Alta (H) | **Impacto da Variante:** Sim

---

## 3. Requisitos Não Funcionais (NFR)

### NFR-001: Log de Auditoria
* **Descrição:** Registar UserID, Timestamp, Old/New value para campos críticos.
* **Racional:** Compliance e rastreabilidade de alterações.

### NFR-002: Performance de Validação
* **Declaração Mensurável:** Resposta < 500ms para 95% dos pedidos de validação cruzada.
* **Impacto da Variante:** Sim (Eficiência).

### NFR-003: Disponibilidade
* **Declaração Mensurável:** O serviço de validação deve garantir um uptime de 99.9% mensal durante horário laboral.
* **Impacto da Variante:** Não.

### NFR-004: Qualidade de Dados Garantida
* **Declaração Mensurável:** 100% dos ativos em "Ready" devem cumprir as regras do motor de consistência.

### NFR-005: Tempo de Resposta da UI (Feedback)
* **Declaração Mensurável:** Identificação visual do erro em < 1s após falha de validação.

### NFR-006: Retenção de Logs
* **Declaração Mensurável:** Manter logs de auditoria num formato WORM (Write Once Read Many) por um período mínimo de 12 meses.
* **Impacto da Variante:** Não.