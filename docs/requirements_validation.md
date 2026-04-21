# Requirements Validation — Lab 7

## Participants / roles
- Client/Stakeholders: Bruno Martinho (Data Steward)
- DevTeam: Duarte Martins (Lead Developer)
- Facilitator: Bruno Martinho
- Scribe: Duarte Martins
- Reviewer: Denivaldo Antonio
- Tester: Diogo Sá

## Selected requirements (min. 6)
- REQ-001 (FR) — Mandatory Base Fields Validation (Variant impact: Yes)
- REQ-002 (FR) — Condicionalidade de Teste de DR (Variant impact: Yes)
- REQ-003 (FR) — DR Inconsistency Detection (Variant impact: Yes)
- REQ-004 (FR) — Evidence Expiration Validation (Variant impact: Yes)
- NFR-002 (NFR) — Performance de Validação (Variant impact: Yes)
- NFR-005 (NFR) — Mensagens de Erro de Consistência (Variant impact: Yes)

## Variant-driven validation questions (min. 3)
1. **[Data Quality / REQ-003]**: Como deve o sistema reagir se o utilizador alterar o campo "DR" para "Não" mas decidir manter uma data de teste que já tinha inserido anteriormente?
2. **[Data Quality / REQ-005]**: Em caso de timeout na resposta da Asset Database, o sistema deve permitir a gravação ou bloquear a submissão para evitar potenciais duplicados?
3. **[Data Quality / REQ-004]**: A rejeição de evidências com mais de 12 meses deve ser baseada na data de modificação do ficheiro ou na data introduzida manualmente?

## Validation results

### REQ-001 — Mandatory Base Fields Validation
- Status: Valid
- Issues found: Necessidade de garantir que campos preenchidos apenas com espaços (" ") são tratados como vazios.
- Proposed fix: Aplicar rotina de `trim()` antes da validação síncrona.
- Expected evidence: Teste unitário com injeção de strings vazias e espaços.

### REQ-003 — DR Inconsistency Detection
- Status: Valid
- Issues found: A transição para o estado "Pronto" deve ser explicitamente bloqueada na presença desta inconsistência.
- Proposed fix: Alteração automática do estado para "Inconsistente" e destaque visual dos campos em conflito.
- Expected evidence: Demonstração do ecrã de erro e bloqueio da transição.