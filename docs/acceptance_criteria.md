# Acceptance Criteria — Lab 7

## REQ-001 — Validação de Campos Obrigatórios
- **AC-1:** O sistema deve validar a presença de 'Nome', 'Owner' e 'Suporte' no momento do clique em "Submeter Ready".
- **AC-2:** Caracteres invisíveis (espaços) devem ser ignorados (`trim`).
- **AC-3:** O sistema deve marcar o campo vazio com uma moldura vermelha.

## REQ-002 — Condicionalidade DR (Given/When/Then)
- **Given** que o utilizador selecionou "DR = Sim".
- **When** o utilizador deixa a "Data do Último Teste" vazia.
- **Then** o sistema exibe o erro "Campo obrigatório para sistemas com resiliência" e impede a gravação em estado Ready.

## REQ-003 — Inconsistência DR (Given/When/Then)
- **Given** que o utilizador selecionou "DR = Não".
- **When** o utilizador introduz qualquer data no campo de teste.
- **Then** o sistema altera o estado para "Inconsistent" e bloqueia a finalização até correção.

## REQ-005 — Caducidade (Variante 4)
- **AC-1:** O sistema deve comparar a data do ficheiro com `Date.now()`.
- **AC-2:** Se a diferença > 365 dias, o sistema lança exceção "Evidência Expirada".

## REQ-007 — Unicidade de Hostname
- **AC-1:** Ao perder o foco do campo 'Nome do Sistema', o sistema deve consultar a API de ativos.
- **AC-2:** Se o código de resposta for "Duplicate (409)", o botão "Ready" deve ser desativado.

## NFR-002 — Performance (Variante 4)
- **AC-1:** O processamento das regras REQ-002 e REQ-003 no backend deve ser medido por telemetria.
- **AC-2:** A latência média deve situar-se abaixo dos 500ms.