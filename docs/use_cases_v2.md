# Use Cases v2 — Lab 6 (Completo)

Este documento detalha os Casos de Uso do sistema AMS, focando na lógica de negócio e nas restrições impostas pela **Variante 4 — Qualidade e Consistência de Dados**.

---

## UC-01 — Submeter Novo Ativo
- **Primary actor:** Transition Lead (End User)
- **Supporting actors:** Asset Database (CMDB), Active Directory (AD)
- **Goal:** Registar um novo ativo de inventário garantindo que os dados são únicos, consistentes e completos.
- **Preconditions:** Utilizador autenticado no sistema e acesso ao formulário de Intake.
- **Trigger:** O utilizador clica no botão "Submeter Final" (Transition to Ready).
- **Postconditions (success):** Ativo registado na base de dados com estado "Ready to Proceed" e log de auditoria gerado.
- **Postconditions (failure):** Submissão bloqueada; erros destacados na UI; estado permanece "Incomplete" ou "Inconsistent".
- **Related requirements:** REQ-001, REQ-002, REQ-004, REQ-006, REQ-007, REQ-008, REQ-009, NFR-004, NFR-005.

### Main flow (happy path)
1. O Actor preenche os campos base: Nome do Sistema, Owner e Modelo de Suporte (REQ-001).
2. O Actor identifica os Owners de cada integração através de uma pesquisa no AD (REQ-006).
3. O Actor insere o URL HTTPS do dashboard de monitorização (REQ-004).
4. O Actor anexa a evidência de teste de Disaster Recovery (UC-03).
5. O System invoca o motor de validação (UC-04) para verificar a sanidade dos dados.
6. O System consulta a Asset Database para garantir que o Hostname é único (REQ-007).
7. O System confirma o sucesso e transita o ativo para o estado "Ready to Proceed" (REQ-009).
8. O System gera um registo no Log de Auditoria (NFR-001).

### Alternative flows
- **A1: Guardar Rascunho (Draft):** O Actor clica em "Guardar Rascunho". O Sistema permite a gravação mesmo com campos obrigatórios em falta ou inconsistências lógicas, atribuindo o estado "Draft" (REQ-008).
- **A2: Correção de Inconsistência:** Após um erro detetado pelo UC-04, o Actor corrige os dados contraditórios e re-submete o formulário com sucesso.

### Exceptions / errors
- **E1: Ativo Duplicado:** A Asset DB informa que o Hostname já existe. O Sistema destaca o campo a vermelho em < 1s (NFR-005) e bloqueia a submissão (REQ-007).
- **E2: Falha de Validação Síncrona:** O motor de regras deteta que campos obrigatórios foram preenchidos apenas com espaços. O Sistema aplica `trim()` e rejeita a submissão (REQ-001).

---

## UC-04 — Validar Regras de Consistência (Motor de Backend)
- **Primary actor:** Sistema (Automático) / Data Steward (Manual)
- **Supporting actors:** Motor de Regras de Qualidade
- **Goal:** Executar a validação cruzada de 100% dos campos dependentes para garantir integridade (NFR-004).
- **Preconditions:** Payload de dados do ativo disponível para processamento.
- **Trigger:** Invocação automática pelo UC-01 ou solicitação de auditoria pelo Steward.
- **Postconditions (success):** Status "Válido" retornado em menos de 500ms (NFR-002).
- **Postconditions (failure):** Status "Inconsistente" com mapeamento detalhado de erros.
- **Related requirements:** REQ-002, REQ-003, REQ-005, REQ-007, REQ-009, NFR-002, NFR-004, NFR-005.

### Main flow (happy path)
1. O System valida a lógica condicional de DR: se DR="Sim", exige data; se DR="Não", proíbe data (REQ-002, REQ-003).
2. O System extrai a data dos metadados da evidência e verifica se tem menos de 365 dias (REQ-005).
3. O System verifica se o Hostname cumpre as regras de nomenclatura e unicidade (REQ-007).
4. O System valida se todos os requisitos da Variante 4 foram cumpridos com sucesso.
5. O System retorna a confirmação de integridade total (NFR-004).

### Alternative flows
- **A1: Auditoria Preventiva:** O Data Steward corre este Caso de Uso sobre registos em estado "Draft" para gerar relatórios de qualidade de dados pendentes.
- **A2: Timeout de Validação Externa:** Se a verificação de duplicados exceder o tempo limite, o Sistema retorna um aviso de "Validação Pendente" em vez de erro de inconsistência.

### Exceptions / errors
- **E1: Evidência Expirada (Variante):** O System deteta que a prova de teste tem data superior a 12 meses. O upload é rejeitado com a mensagem "Evidência Expirada" (REQ-005).
- **E2: Inconsistência Lógica (Variante):** O utilizador declarou não ter DR mas forneceu uma data de teste. O Sistema marca o registo como "Inconsistent" e bloqueia o estado "Ready" (REQ-003).

---

## Variant-driven notes (Required)
- **Impacto da Variante 4:** A restrição de "Qualidade e Consistência" é o motor principal do **UC-04**. O sistema não é apenas um repositório, mas um filtro ativo que impede a transição para estados operacionais (**REQ-009**) se houver qualquer desvio lógico (E2 no UC-04) ou obsolescência de dados (E1 no UC-04). 
- **User Experience:** Para não prejudicar a performance operacional, o **NFR-002** e o **NFR-005** garantem que as validações complexas da variante ocorrem de forma quase instantânea para o utilizador final.