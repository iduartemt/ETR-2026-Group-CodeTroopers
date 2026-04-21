# Acceptance Criteria — Lab 7

## REQ-001 — Mandatory Base Fields Validation
- AC-1: O sistema deve validar e rejeitar o formulário se os campos 'Nome do Sistema', 'Owner' ou 'Criticidade' estiverem vazios, nulos ou apenas contiverem espaços em branco.
- AC-2: [Variante-Driven] O sistema deve apresentar a mensagem de erro específica associada à regra de Data Quality (ex: "O campo Owner é estritamente obrigatório para efeitos de Governance").
- AC-3: A validação deve ocorrer no momento em que o utilizador perde o foco do campo (OnBlur) e ser reforçada no momento da submissão final.

## REQ-003 — DR Inconsistency Detection (Given/When/Then)
- Given que o utilizador selecionou a Criticidade de Negócio como "Tier 1" ou "Tier 2"
- When o utilizador deixa os campos de Disaster Recovery (RTO/RPO) vazios ou anexa um documento de DR inválido
- Then o motor de validação de Data Quality deve gerar um erro bloqueante impendido a transição de estado.
- AC-Extra:
  - Given que o utilizador tenta introduzir "N/A" nos campos de RTO/RPO para contornar a obrigatoriedade
  - When o sistema processa a string
  - Then o sistema deve reconhecer "N/A" como um valor inválido para dados numéricos de horas e rejeitar a entrada.

## REQ-004 — Evidence Expiration Validation
- AC-1: O sistema deve extrair nativamente a data de criação/modificação dos metadados do ficheiro (PDF/Word) submetido.
- AC-2: O anexo deve ser liminarmente rejeitado se a data extraída for anterior a 365 dias face ao relógio do servidor (UTC).
- AC-3: [Variante-Driven] Ficheiros rejeitados não devem ser temporariamente guardados na *storage* da plataforma; a transferência deve ser abortada na camada de rede para proteger a pureza e segurança do repositório de evidências.

## REQ-006 — Submission State Management (Given/When/Then)
- Given que um utilizador tem o formulário de Intake aberto com dados incompletos ou que violam as regras de Data Quality
- When o utilizador clica na ação "Guardar Rascunho"
- Then o sistema deve contornar as validações, persistir os dados na base de dados e atribuir-lhes o estado "Draft".
- AC-Extra:
  - Given que um registo possui o estado "Draft"
  - When o utilizador clica em "Submeter Final" sem corrigir os erros
  - Then a máquina de estados deve abortar a transição para "Ready" e redirecionar o utilizador para o primeiro erro visualizado.

## REQ-007 — Validation API Performance (NFR)
- AC-1: O tempo de resposta total entre o clique em "Submeter" e o retorno do resultado das regras de Data Quality deve ser inferior ou igual a 2.0 segundos no percentil 95 (P95).
- AC-2: Em caso de degradação da rede externa que exceda os 5 segundos (timeout), o sistema deve interromper a espera e apresentar um erro explícito de "Timeout de Validação", impedindo a gravação do ativo.

## REQ-008 — Audit Logging for Data Quality (NFR)
- AC-1: Todas as tentativas de submissão falhadas devido a regras de Data Quality (REQ-001 a REQ-005) devem gerar um registo (log) automático.
- AC-2: O log de auditoria deve ser exportado em formato JSON e conter os campos: `Timestamp`, `UserID`, `AttemptedAction`, `FailedRuleID` e `ValidationMessage`.
- AC-3: O ficheiro/tabela de logs deve ser do tipo *append-only* (apenas adição), garantindo a sua imutabilidade para efeitos de auditoria.