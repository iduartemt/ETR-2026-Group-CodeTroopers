# Use Cases v2 — Lab 6

## UC-01 — Submeter Novo Ativo
- **Primary actor:** End User
- **Supporting actors:** Asset Database
- **Goal:** Registar um ativo garantindo integridade total de dados.
- **Preconditions:** Utilizador autenticado e formulário preenchido.
- **Trigger:** Clique em "Submeter Final".
- **Postconditions (success):** Ativo em estado "Ready" na BD.
- **Postconditions (failure):** Dados não persistidos; erro exibido.
- **Related requirements:** REQ-001, REQ-002, REQ-003, REQ-005, REQ-006

### Main flow (happy path)
1. Actor preenche todos os campos obrigatórios.
2. Actor anexa evidência PDF válida.
3. System executa UC-04 (Validação).
4. System verifica unicidade na Asset Database.
5. System grava registo e confirma sucesso.

### Alternative flows (min. 2)
- **A1: Guardar Rascunho:** O Actor escolhe "Guardar Rascunho"; o Sistema ignora validações de obrigatoriedade e guarda o estado parcial.
- **A2: Submissão por Data Steward:** O Steward submete em nome de um utilizador; o Sistema regista o autor original e o autor da submissão no log.

### Exceptions / errors (min. 2)
- **E1: Falha de Consistência (Variante):** Se UC-04 detetar inconsistência (ex: DR=Não com data preenchida), o Sistema bloqueia a gravação e destaca o erro.
- **E2: Asset DB Offline:** Se o sistema externo não responder, o Sistema informa "Verificação de duplicados indisponível" e não permite a submissão.

---

## UC-04 — Validar Regras de Consistência (Backend)
- **Primary actor:** Data Steward (ao auditar) ou Sistema (na submissão).
- **Goal:** Garantir que não existem dados contraditórios ou obsoletos.
- **Preconditions:** Payload de dados recebido.
- **Trigger:** Invocação automática pelo UC-01 ou manual pelo Steward.
- **Postconditions (success):** Status "Válido" retornado.
- **Postconditions (failure):** Status "Inválido" com lista de erros.
- **Related requirements:** REQ-001, REQ-002, REQ-003, REQ-004, NFR-004

### Main flow (happy path)
1. System verifica preenchimento de campos obrigatórios (REQ-001).
2. System valida lógica "Se X então Y" (REQ-002).
3. System verifica data de caducidade da evidência (REQ-004).
4. System confirma sanidade lógica de datas.

### Alternative flows (min. 2)
- **A1: Auditoria em Lote:** O Data Steward corre a validação sobre múltiplos registos existentes para detetar caducidades retroativas.
- **A2: Validação de Bypass:** O Steward autoriza excecionalmente um campo inconsistente com uma nota de justificação (auditável).

### Exceptions / errors (min. 2)
- **E1: Evidência Expirada (Variante):** O ficheiro tem data superior a 12 meses; o Sistema rejeita o upload (REQ-004).
- **E2: Payload Corrompido:** Os dados recebidos não respeitam o formato JSON; o Sistema retorna erro de sistema "Malformed Request".

## Variant-driven notes (Required)
- A **Variante 4** influenciou a criação de fluxos de auditoria manual no UC-04 e as exceções rigorosas de inconsistência (E1 no UC-01 e E1 no UC-04), garantindo que o Data Steward tem ferramentas para impedir dados "lixo".
