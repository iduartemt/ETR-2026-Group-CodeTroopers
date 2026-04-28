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
- **A1: Guardar Rascunho (Draft):** O Actor clica em "Guardar Rascunho" invocando o **UC-02**. O Sistema permite a gravação mesmo com campos obrigatórios em falta ou inconsistências lógicas.
- **A2: Correção de Inconsistência:** Após um erro detetado pelo UC-04, o Actor corrige os dados contraditórios e re-submete o formulário com sucesso.

### Exceptions / errors
- **E1: Ativo Duplicado:** A Asset DB informa que o Hostname já existe. O Sistema destaca o campo a vermelho em < 1s (NFR-005) e bloqueia a submissão (REQ-007).
- **E2: Falha de Validação Síncrona:** O motor de regras deteta que campos obrigatórios foram preenchidos apenas com espaços. O Sistema aplica `trim()` e rejeita a submissão (REQ-001).

---

## UC-02 — Guardar Rascunho (Draft)
- **Primary actor:** Transition Lead (End User)
- **Goal:** Guardar o progresso do preenchimento do formulário de forma segura, contornando intencionalmente o motor de regras estrito.
- **Preconditions:** Formulário de Intake aberto e parcialmente preenchido.
- **Trigger:** Clique no botão "Guardar Rascunho".
- **Postconditions (success):** Registo persistido na base de dados com a flag de estado `is_draft=True`.
- **Related requirements:** REQ-008.

### Main flow (happy path)
1. O Actor clica em "Guardar Rascunho".
2. O System suspende temporariamente o motor de validação cruzada (UC-04).
3. O System guarda os dados inseridos até ao momento na tabela temporária.
4. O System apresenta a mensagem de "Rascunho guardado com sucesso".

### Alternative flows
- **A1: Retomar Rascunho:** O Actor acede à lista de rascunhos num dia posterior, carrega os dados no formulário e prossegue com o preenchimento.

### Exceptions / errors
- **E1: Perda de Conectividade:** Ocorreu uma falha de rede; o Sistema avisa que não foi possível guardar o rascunho de forma segura.

---

## UC-03 — Upload de Evidências
- **Primary actor:** Transition Lead (End User)
- **Goal:** Anexar ficheiros comprovativos (ex: Teste DR) garantindo que a informação operacional não está obsoleta.
- **Preconditions:** Utilizador no ecrã de upload de documentos.
- **Trigger:** Seleção de um ficheiro no explorador do sistema operativo.
- **Postconditions (success):** Ficheiro anexado e associado ao ativo.
- **Related requirements:** REQ-005.

### Main flow (happy path)
1. O Actor seleciona o ficheiro PDF a anexar.
2. O System extrai a data de modificação/criação dos metadados do ficheiro (ou do input do utilizador).
3. O System calcula a diferença face ao relógio atual (`Date.now()`).
4. O System verifica que a idade é inferior a 365 dias (REQ-005).
5. O System anexa o ficheiro com sucesso.

### Alternative flows
- **A1: Substituição de Evidência:** O Actor faz upload de um novo documento que substitui automaticamente o anterior.

### Exceptions / errors
- **E1: Evidência Expirada (Variante 4):** A data do documento excede os 365 dias. O Sistema cancela o upload imediatamente com o alerta visual "Evidência Expirada (>1 ano)".

---

## UC-04 — Validar Regras de Consistência (Motor de Backend)
- **Primary actor:** Sistema (Automático) / Data Steward (Manual)
- **Supporting actors:** Motor de Regras de Qualidade
- **Goal:** Executar a validação cruzada de 100% dos campos dependentes para garantir integridade (NFR-004).
- **Preconditions:** Payload de dados do ativo disponível para processamento.
- **Trigger:** Invocação automática pelo UC-01 ou solicitação de auditoria pelo Steward.
- **Postconditions (success):** Status "Válido" retornado em menos de 500ms (NFR-002).
- **Postconditions (failure):** Status "Inconsistente" com mapeamento detalhado de erros.
- **Related requirements:** REQ-001, REQ-002, REQ-003, REQ-005, REQ-007, REQ-009, NFR-002, NFR-004, NFR-005.

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
- **E1: Inconsistência Lógica (Variante 4):** O utilizador declarou não ter DR mas forneceu uma data de teste. O Sistema marca o registo como "Inconsistent" e bloqueia o estado "Ready" (REQ-003).

---

## UC-05 — Resolver Inconsistências de Dados
- **Primary actor:** Data Steward
- **Goal:** Analisar e intervir sobre ativos que ficaram bloqueados no estado "Inconsistent".
- **Preconditions:** O Steward tem permissões de auditoria; existem ativos em estado de erro.
- **Trigger:** Acesso ao Dashboard de Controlo de Qualidade.
- **Postconditions (success):** Registo corrigido e transitado para "Ready".
- **Related requirements:** REQ-003, REQ-009.

### Main flow (happy path)
1. O Actor acede à lista de ativos sinalizados como "Inconsistent".
2. O Actor abre o detalhe de um ativo.
3. O System destaca especificamente a regra que falhou (ex: conflito no DR).
4. O Actor ajusta o dado consoante investigação manual (ex: remove a data fantasma).
5. O Actor clica em aprovar. O System re-executa o **UC-04**.
6. O System transita o ativo para "Ready to Proceed" (REQ-009).

### Alternative flows
- **A1: Rejeição Definitiva:** O Steward decide que os dados são irrecuperáveis e apaga o registo.

### Exceptions / errors
- **E1: Falha Reincidente:** O Steward tenta submeter mas outra validação cruzada falha. O ativo permanece "Inconsistent".

---

## UC-06 — Exportar Logs de Auditoria
- **Primary actor:** Auditor / Data Steward
- **Goal:** Extrair o *Audit Trail* de alterações críticas para reportar conformidade.
- **Preconditions:** O utilizador tem perfil de Auditor. Existem logs gravados no sistema.
- **Trigger:** Clique no botão "Exportar Relatório de Auditoria".
- **Postconditions (success):** Ficheiro estruturado descarregado com sucesso.
- **Related requirements:** NFR-001, NFR-006.

### Main flow (happy path)
1. O Actor seleciona o período temporal desejado (ex: últimos 6 meses).
2. O System extrai todos os logs referentes à criação ou edição de campos críticos (Owner, Nome, DR).
3. O System compila a informação com UserID, Timestamp, Valor Antigo e Valor Novo (NFR-001).
4. O System disponibiliza o download do ficheiro (CSV/JSON).

### Alternative flows
- **A1: Consulta em Ecrã:** Em vez de descarregar, o Actor escolhe apenas visualizar o histórico daquele ativo na grelha da interface.

### Exceptions / errors
- **E1: Tentativa de Eliminação:** O Actor tenta apagar um log. O Sistema bloqueia a operação garantindo que o armazenamento imutável preserva a retenção de 12 meses (NFR-006).

---

## Variant-driven notes (Required)
- **Impacto da Variante 4:** A restrição de "Qualidade e Consistência" é o motor principal do **UC-04**, que atua como o *gatekeeper* de todo o sistema. A criação do **UC-05** existe estritamente para lidar com o "lixo" que a variante previne de entrar no fluxo normal. 
- **Separação de Estados:** O **UC-02** permite uma experiência de utilizador fluida (Draft), enquanto o **UC-01** (associado ao REQ-009) garante que a base de dados final (*Ready*) é 100% íntegra, cumprindo o **NFR-004**.