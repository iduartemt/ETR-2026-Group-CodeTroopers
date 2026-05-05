# Test Cases — Lab 9 (CodeTroopers)

## TC-001 — Bloqueio de submissão com campos invisíveis [Boundary]
- **Type:** Unit / UI
- **Related requirements:** REQ-001 (AC-2)
- **Preconditions:** Formulário de Intake aberto.
- **Steps:**
  1. Inserir apenas espaços ("   ") no campo "Nome do Sistema".
  2. Preencher os restantes campos obrigatórios.
  3. Clicar em "Submeter Final".
- **Expected results:** O sistema executa o `trim()`, reconhece o campo como vazio, bloqueia a submissão e destaca o campo a vermelho.

## TC-002 — Validação condicional de DR ativa [Happy Path]
- **Type:** Integration
- **Related requirements:** REQ-002 (AC-1)
- **Steps:**
  1. Selecionar "Sim" no campo "Disaster Recovery".
  2. Verificar se o campo "Data do Último Teste" exibe um marcador de obrigatoriedade (asterisco).
  3. Preencher uma data válida e submeter.
- **Expected results:** O sistema aceita a transição para "Ready" após validar a presença da data.

## TC-003 — Inconsistência Lógica de DR [Negative]
- **Type:** Logic / Variant 4 Focus
- **Related requirements:** REQ-003, REQ-009
- **Steps:**
  1. Selecionar "Não" no campo "Disaster Recovery".
  2. Inserir uma data no campo "Data do Último Teste".
  3. Tentar clicar em "Submeter Final".
- **Expected results:** O sistema bloqueia a transição, exibe o erro "Campo proibido para sistemas sem resiliência" e marca o estado como "Inconsistent".

## TC-004 — Caducidade de Evidência (366 dias) [Boundary]
- **Type:** Functional / Temporal
- **Related requirements:** REQ-005
- **Steps:**
  1. Carregar uma evidência com data de 366 dias atrás face a `Date.now()`.
- **Expected results:** O sistema rejeita o ficheiro com a notificação "Evidência Expirada".

## TC-005 — Unicidade de Hostname (onBlur) [Integration]
- **Type:** Integration
- **Related requirements:** REQ-007
- **Steps:**
  1. Inserir o nome "PROD-DB" (já existente no Mock do Asset Database).
  2. Retirar o foco do campo (onBlur).
- **Expected results:** O sistema sinaliza o erro "Ativo já existe" e desativa o botão de submissão.

## TC-006 — Gravação de Rascunho com Dados em Falta [Alternative]
- **Type:** System
- **Related requirements:** REQ-008
- **Steps:**
  1. Deixar campos obrigatórios vazios.
  2. Clicar em "Guardar Rascunho".
- **Expected results:** O sistema ignora as validações cruzadas e persiste os dados com a flag `is_draft=True`.

## TC-007 — Performance do Motor de Regras [Performance]
- **Type:** Non-Functional
- **Related requirements:** NFR-002
- **Steps:** Submeter um payload complexo de validação cruzada.
- **Expected results:** O motor de backend processa todas as regras em menos de 500ms (P95).

## TC-008 — Auditoria de Alterações Críticas [Acceptance]
- **Type:** Non-Functional / Compliance
- **Related requirements:** NFR-001
- **Steps:** Alterar o campo "Owner" de um ativo existente e submeter.
- **Expected results:** O sistema gera um registo imutável no Log de Auditoria com UserID, Timestamp e valores antigo/novo.