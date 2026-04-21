# Acceptance Criteria — Lab 7

## REQ-001 — Mandatory Base Fields Validation
- AC-1: O sistema deve bloquear a submissão se 'Nome do Sistema', 'Owner' ou 'Modelo de Suporte' estiverem vazios ou contiverem apenas espaços.
- AC-2: [Variante-Driven] Devem ser exibidas mensagens de erro específicas (ex: "O campo [Nome] é obrigatório") junto ao campo em falta.
- AC-3: A regra deve ser verificada tanto na interface (UI) como no servidor (API) para evitar contornos.

## REQ-002 — Condicionalidade de Teste de DR (Given/When/Then)
- Given que o utilizador selecionou a opção "Sim" no campo "Disaster Recovery (DR)"
- When tenta submeter o formulário sem preencher a "Data do Último Teste"
- Then o sistema deve interromper o processo e exibir um alerta visual a vermelho.

## REQ-003 — DR Inconsistency Detection (Given/When/Then)
- Given que o utilizador marcou o campo "DR" como "Não"
- When existe um valor preenchido no campo "Data do Último Teste"
- Then o sistema deve impedir a transição para "Pronto" e alterar o estado para "Inconsistente".

## REQ-004 — Evidence Expiration Validation
- AC-1: O sistema deve extrair a data dos metadados do ficheiro ou do input manual.
- AC-2: [Variante-Driven] O ficheiro deve ser rejeitado se a data for superior a 12 meses face à data atual.
- AC-3: O sistema deve emitir o erro específico "Evidência expirada (>1 ano)".

## NFR-002 — Performance de Validação
- AC-1: 95% dos pedidos de validação cruzada devem responder em menos de 500ms.

## NFR-005 — Mensagens de Erro de Consistência
- AC-1: O sistema deve identificar o campo exato com erro em menos de 1 segundo após a falha.