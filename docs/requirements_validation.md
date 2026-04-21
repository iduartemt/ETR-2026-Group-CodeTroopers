# Requirements Validation — Lab 7

## Participants / roles
- Client/Stakeholders: Bruno Martinho (Data Steward)
- DevTeam: Duarte Martins (Lead Developer)
- Facilitator: Bruno Martinho
- Scribe: Duarte Martins
- Reviewer: Equipa em conjunto
- Tester: Duarte Martins

## Selected requirements (min. 6)
- REQ-001 (FR) — Mandatory Base Fields Validation (Variant impact: Yes)
- REQ-003 (FR) — DR Inconsistency Detection (Variant impact: Yes)
- REQ-004 (FR) — Evidence Expiration Validation (Variant impact: Yes)
- REQ-006 (FR) — Submission State Management (Variant impact: Yes)
- REQ-007 (NFR) — Validation API Performance (Variant impact: Yes)
- REQ-008 (NFR) — Audit Logging for Data Quality (Variant impact: Yes)

## Variant-driven validation questions (min. 3)
1. **[Data Quality / REQ-005 & 007]** Se a Asset Database externa demorar muito tempo a responder durante a verificação de unicidade, como é que o sistema garante que a qualidade dos dados não é comprometida por um "falso positivo"?
2. **[Data Quality / REQ-003]** No caso da deteção de inconsistência de Disaster Recovery, o que acontece se o utilizador submeter um sistema *Tier 1*, mas introduzir propositadamente a *string* "N/A" nos campos de RTO/RPO para contornar a obrigatoriedade?
3. **[Data Quality / REQ-004]** A validação de caducidade de evidências (>12 meses) corre apenas no momento do upload, ou o sistema tem um *job* contínuo que despromove ativos para "Draft" quando as evidências expiram na base de dados?

## Validation results (one block per requirement)

### REQ-001 — Mandatory Base Fields Validation
- Status: Valid
- Issues found:
  - Faltava clarificar se os utilizadores podem usar espaços em branco ("   ") para contornar a validação de campos obrigatórios.
- Proposed fix (rewrite/split/clarify):
  - Clarificar nos critérios de aceitação que a função `trim()` deve ser aplicada e valores nulos ou compostos apenas por espaços devem ser rejeitados.
- Expected evidence (how to verify):
  - Test / Measurement
  - Notes: Criar um teste unitário que injete *strings* vazias e espaços.

### REQ-003 — DR Inconsistency Detection
- Status: Needs rewrite
- Issues found:
  - O requisito não especifica se a inconsistência (ex: Tier 1 sem DR) é um bloqueio rígido (*Hard Block*) ou se permite um aviso com justificação (*Soft Warning*).
- Proposed fix (rewrite/split/clarify):
  - Reescrever para clarificar que, na Variante 4 (Data Quality), trata-se de um bloqueio absoluto (*Hard Block*) sem exceções.
- Expected evidence (how to verify):
  - Demo
  - Notes: Demonstrar na UI o botão "Submeter" bloqueado perante esta inconsistência.

### REQ-004 — Evidence Expiration Validation
- Status: Valid
- Issues found:
  - A métrica "12 meses" pode ser ambígua devido a fusos horários e anos bissextos (365 vs 366 dias).
- Proposed fix (rewrite/split/clarify):
  - Ajustar a definição técnica para "diferença entre Data de Criação do ficheiro e Sysdate do Servidor (UTC) estritamente superior a 365 dias".
- Expected evidence (how to verify):
  - Test
  - Notes: Mock de ficheiros com datas exatas de T-364 dias e T-366 dias.

### REQ-006 — Submission State Management (Draft vs Ready)
- Status: Valid
- Issues found:
  - Se os utilizadores guardarem demasiados "Drafts" inválidos e nunca os corrigirem, a base de dados vai encher-se de lixo.
- Proposed fix (rewrite/split/clarify):
  - O requisito é válido para a transição de estado, mas precisamos de anotar uma dependência para um futuro requisito de *Garbage Collection* (purga de Drafts > 30 dias).
- Expected evidence (how to verify):
  - Review / Demo
  - Notes: Rever fluxo de base de dados e garantir flag isolada de 'Draft'.

### REQ-007 — Validation API Performance (NFR)
- Status: Needs rewrite
- Issues found:
  - O termo "O sistema deve validar os dados rapidamente" contém ambiguidade e falha o critério de testabilidade.
- Proposed fix (rewrite/split/clarify):
  - Reescrever para: "O tempo de resposta do motor de validação de Data Quality e chamada API não pode exceder os 2000 milissegundos (2 segundos)."
- Expected evidence (how to verify):
  - Measurement
  - Notes: Teste de carga/performance via Postman/JMeter.

### REQ-008 — Audit Logging for Data Quality (NFR)
- Status: Valid
- Issues found:
  - O formato do log não estava especificado (TXT vs JSON).
- Proposed fix (rewrite/split/clarify):
  - Adicionar restrição de arquitetura: Os eventos de rejeição por Data Quality devem ser registados em formato JSON para fácil ingestão por sistemas de monitorização (ex: Splunk/Elastic).
- Expected evidence (how to verify):
  - Review
  - Notes: Inspecionar o ficheiro/tabela de logs gerado após uma submissão rejeitada.