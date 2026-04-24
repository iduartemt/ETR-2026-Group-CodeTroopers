# Acceptance Criteria — Lab 7

## REQ-001 — Validação de Campos Obrigatórios
- **AC-1:** O sistema deve validar a presença dos campos 'Nome', 'Owner' e 'Suporte' no momento do clique em "Submeter Final".
- **AC-2:** Caracteres invisíveis (espaços) inseridos pelo utilizador devem ser limpos (`trim()`) e rejeitados como campos vazios.
- **AC-3:** O sistema deve destacar o campo vazio com uma moldura vermelha e manter o estado em "Incomplete".

## REQ-002 — Condicionalidade DR (Given/When/Then)
- **Given** que o utilizador selecionou a opção "DR = Sim".
- **When** o utilizador deixa a "Data do Último Teste" vazia e tenta submeter.
- **Then** o sistema exibe o erro "Campo obrigatório para sistemas com resiliência" e impede a gravação em estado "Ready".

## REQ-003 — Inconsistência DR (Given/When/Then)
- **Given** que o utilizador selecionou "DR = Não".
- **When** o utilizador introduz qualquer data no campo de teste de DR.
- **Then** o sistema altera o estado da transação para "Inconsistent" e bloqueia a finalização até a contradição ser corrigida.

## REQ-004 — Validação de URL de Dashboard
- **AC-1:** O campo de URL deve rejeitar ativamente strings que não comecem por `https://`.
- **AC-2:** A submissão falha se o URL apresentar erro de sintaxe padrão de domínio (Regex falhada).

## REQ-005 — Caducidade de Evidências (Variante 4)
- **AC-1:** O sistema deve extrair a data dos metadados do ficheiro (ou do input) e comparar com o relógio do servidor `Date.now()`.
- **AC-2:** Se a diferença for estritamente superior a 365 dias, o sistema deve abortar o upload e exibir a notificação "Evidência Expirada".

## REQ-006 — Identificação de Owner em Integrações
- **AC-1:** O campo de identificação do Owner da integração deve validar o formato de um e-mail corporativo válido (ex: `@empresa.com`).

## REQ-007 — Unicidade de Hostname (Variante 4)
- **AC-1:** Ao perder o foco (*onBlur*) do campo 'Nome do Sistema', o sistema deve consultar a API de ativos via `GET`.
- **AC-2:** Se a API devolver o código "409 Conflict" (Duplicado), o botão de transição para "Ready" deve ser automaticamente desativado.

## REQ-008 — Gestão de Estados (Draft) (Given/When/Then)
- **Given** que o formulário tem campos obrigatórios em falta ou falha em validações cruzadas.
- **When** o utilizador clica em "Guardar Rascunho".
- **Then** o sistema grava os dados parcialmente na tabela e atribui a *flag* de estado `is_draft=True`.

## REQ-009 — Transição para "Ready to Proceed"
- **AC-1:** A transição de estado na base de dados para "Ready" só ocorre se o payload do motor de regras retornar 0 erros lógicos.

## NFR-001 — Log de Auditoria
- **AC-1:** Qualquer alteração (update) aos campos "Nome", "Owner" ou "Disaster Recovery" num ativo já existente gera um registo em tabela *append-only*.

## NFR-002 — Performance (Variante 4)
- **AC-1:** O processamento interno das regras lógicas REQ-002 e REQ-003 deve ser executado no percentil 95 (P95) abaixo de 500ms.

## NFR-004 — Qualidade de Dados Garantida (Variante 4)
- **AC-1:** Tentativas de chamadas diretas (via Postman/cURL) à API para criar ativos no estado "Ready" com dados inconsistentes devem ser rejeitadas pelo backend.