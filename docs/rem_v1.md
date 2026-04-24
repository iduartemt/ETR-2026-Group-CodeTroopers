# REM v1 — Equipa CodeTroopers (Lab 4)

Este documento detalha os 15 requisitos principais para o módulo de Intake & Discovery, com foco na qualidade de dados e na Variante 4.

---

### REQ-001: Validação de Campos Obrigatórios
* **Requisitante:** Data Steward
* **Descrição:** O sistema impede a submissão se "Nome do Sistema", "Owner" ou "Modelo de Suporte" estiverem vazios.
* **Objetivo:** OBJ-1 / FCS-1
* **Tipo:** Requisito Funcional (FR) | **Prioridade:** Alta
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * Exibição de erro ao tentar submeter com o campo "Owner" vazio.
    * O estado do formulário deve permanecer como "Incompleto".
* **Método de Validação:** Demonstração (Teste de Interface).
* **Pré-condições:** Utilizador autenticado e no formulário de Intake.
* **Pós-condições:** Dados guardados na base de dados apenas se válidos; caso contrário, erro visível ao utilizador.

---

### REQ-002: Condicionalidade de Teste de Disaster Recovery (DR)
* **Requisitante:** Data Steward
* **Descrição:** Se "Disaster Recovery" for marcado como "Sim", o campo "Data do Último Teste" torna-se obrigatório.
* **Objetivo:** OBJ-1 / FCS-1
* **Tipo:** FR | **Prioridade:** Alta
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * A seleção de "Sim" ativa visualmente a obrigatoriedade da data.
    * Submissão bloqueada se a data estiver vazia após selecionar "Sim".
* **Método de Validação:** Teste (Teste Unitário).
* **Pré-condições:** Campo "Disaster Recovery" visível no formulário.
* **Pós-condições:** O sistema atualiza dinamicamente o estado de obrigatoriedade do campo de data.

---

### REQ-003: Deteção de Inconsistência de DR
* **Requisitante:** Data Steward
* **Descrição:** Bloquear a transição para "Pronto" se "DR" for "Não", mas existir uma data preenchida.
* **Objetivo:** OBJ-1 / FCS-1
* **Tipo:** FR | **Prioridade:** Alta
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * Exibição do alerta: "Não pode existir data de teste se não há DR configurado".
    * O estado do Intake é alterado para "Inconsistente".
* **Método de Validação:** Teste (Teste Lógico).
* **Pré-condições:** Formulário em modo de edição ou rascunho.
* **Pós-condições:** O registo é marcado com uma flag de inconsistência na base de dados para auditoria.

---

### REQ-004: Validação de Caducidade de Evidências
* **Requisitante:** Transition Lead
* **Descrição:** Rejeitar evidências operacionais com data superior a 12 meses face à data atual.
* **Objetivo:** OBJ-1 / FCS-1
* **Tipo:** FR | **Prioridade:** Alta
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * Um documento datado de há 13 meses deve ser rejeitado.
    * Mensagem de erro: "Evidência expirada (limite de 1 ano)".
* **Método de Validação:** Análise / Teste Automatizado.
* **Pré-condições:** Utilizador faz upload de um ficheiro de evidência.
* **Pós-condições:** Ficheiro é carregado apenas se a data for válida; caso contrário, é descartado.

---

### REQ-005: Prevenção de Duplicados (Unicidade)
* **Requisitante:** Data Steward
* **Descrição:** Impedir a criação de um ativo se o "Nome do Sistema" já existir na base de dados ativa.
* **Objetivo:** OBJ-3 / FCS-3
* **Tipo:** FR | **Prioridade:** Alta
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * Erro "Nome do sistema já em uso" ao perder o foco do campo.
    * O botão de submissão final fica desativado se for detetado um duplicado.
* **Método de Validação:** Demonstração (Teste de Integração).
* **Pré-condições:** Utilizador preenche o campo "Nome do Sistema".
* **Pós-condições:** O sistema valida contra a CMDB e bloqueia submissões duplicadas.

---

### REQ-006: Gestão de Estados (Rascunho vs Pronto)
* **Requisitante:** Transition Lead
* **Descrição:** Permitir guardar como "Rascunho" mesmo com erros, mas o estado "Pronto" exige sucesso total nas validações.
* **Objetivo:** OBJ-2 / FCS-2
* **Tipo:** FR | **Prioridade:** Média
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * O botão "Guardar Rascunho" está sempre disponível e ignora bloqueios.
    * A transição para "Pronto" só ocorre se todas as regras forem cumpridas.
* **Método de Validação:** Inspeção / Demonstração.
* **Pré-condições:** Formulário possui dados parcialmente preenchidos.
* **Pós-condições:** Registo guardado com a flag `is_draft = true` na base de dados.

---

### REQ-007: Validação de Evidência de Observabilidade
* **Requisitante:** Transition Lead
* **Descrição:** O sistema deve exigir um URL válido (HTTPS) que aponte para o dashboard de monitorização.
* **Objetivo:** OBJ-1 / FCS-1
* **Tipo:** FR | **Prioridade:** Média
* **Impacto da Variante:** Não
* **Critérios de Aceitação:**
    * Rejeição de links que não comecem por "https://".
    * Mensagem de erro caso o formato do URL seja inválido.
* **Método de Validação:** Teste (Regex).
* **Pré-condições:** Utilizador interage com o campo de URL de Observabilidade.
* **Pós-condições:** URL é persistido na base de dados associado ao ativo.

---

### REQ-008: Identificação de Owner em Integrações
* **Requisitante:** Transition Lead
* **Descrição:** O sistema deve exigir a identificação explícita de um Owner (ID ou Email) para cada integração declarada.
* **Objetivo:** OBJ-2 / FCS-2
* **Tipo:** FR | **Prioridade:** Média
* **Impacto da Variante:** Não
* **Critérios de Aceitação:**
    * Não é possível adicionar uma integração sem preencher o campo do Owner.
    * O sistema valida o formato de e-mail corporativo.
* **Método de Validação:** Teste de Interface.
* **Pré-condições:** Utilizador clica em "Adicionar Integração".
* **Pós-condições:** A relação de integração é guardada com a responsabilidade (Owner) mapeada.

---

### REQ-009: Transição Final para "Ready to Proceed"
* **Requisitante:** Data Steward
* **Descrição:** O sistema transita o Intake para "Pronto" estritamente após o motor de backend validar 100% das regras.
* **Objetivo:** OBJ-1 / FCS-1
* **Tipo:** FR | **Prioridade:** Alta
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * O botão de "Submeter Final" aciona o motor completo (UC-04).
    * Se existir 1 aviso de qualidade, a transição é cancelada.
* **Método de Validação:** Teste de Sistema (E2E).
* **Pré-condições:** O formulário não apresenta erros locais e o utilizador tenta finalizar.
* **Pós-condições:** O ativo entra no fluxo operacional do sistema.

---

### NFR-001: Log de Auditoria
* **Requisitante:** Auditor
* **Descrição:** Registar ID de utilizador, data/hora e valores (antigo e novo) para alterações em campos críticos.
* **Objetivo:** OBJ-2 / FCS-2
* **Tipo:** Requisito Não Funcional (NFR) | **Prioridade:** Média
* **Impacto da Variante:** Não
* **Critérios de Aceitação:**
    * O log é gerado automaticamente após a alteração do campo "Owner".
    * O registo do log deve ser imutável.
* **Método de Validação:** Inspeção (Auditoria de Base de Dados).
* **Pré-condições:** Uma alteração bem sucedida (Update) num ativo existente.
* **Pós-condições:** Registo de log armazenado na tabela de auditoria.

---

### NFR-002: Performance de Validação
* **Requisitante:** Data Steward
* **Descrição:** As validações de consistência cruzada devem responder em menos de 500ms para a maioria dos pedidos.
* **Objetivo:** OBJ-3 / FCS-3
* **Tipo:** NFR | **Prioridade:** Alta (Eficiência)
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * 95% dos pedidos de validação cumprem o tempo limite de 500ms.
* **Método de Validação:** Teste de Performance (Teste de Carga).
* **Pré-condições:** O sistema recebe o payload JSON para validação.
* **Pós-condições:** O resultado da validação é entregue ao cliente dentro do SLA estipulado.

---

### NFR-003: Disponibilidade do Serviço
* **Requisitante:** Gestor de IT
* **Descrição:** O serviço de validação deve garantir um uptime de 99.9% mensal durante o horário laboral.
* **Objetivo:** OBJ-3 / FCS-3
* **Tipo:** NFR | **Prioridade:** Alta (Fiabilidade)
* **Impacto da Variante:** Não
* **Critérios de Aceitação:**
    * O dashboard de monitorização reporta falhas inferiores a 43 minutos por mês.
* **Método de Validação:** Medição de Telemetria.
* **Pré-condições:** O sistema está em ambiente de produção.
* **Pós-condições:** N/A.

---

### NFR-004: Qualidade de Dados Garantida
* **Requisitante:** Data Steward
* **Descrição:** 100% dos registos que transitem para o estado "Pronto" devem cumprir todas as regras lógicas sem exceções.
* **Objetivo:** OBJ-1 / FCS-1
* **Tipo:** NFR | **Prioridade:** Máxima (Integridade)
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * Impossibilidade de forçar a criação de um registo inválido através de chamadas de API (Postman/Curl).
* **Método de Validação:** Auditoria e Penetration Testing Lógico.
* **Pré-condições:** Registo tentar gravar estado "Ready".
* **Pós-condições:** Apenas dados 100% validados residem no estado final.

---

### NFR-005: Tempo de Resposta de Mensagens de Erro
* **Requisitante:** Transition Lead
* **Descrição:** O sistema deve identificar explicitamente o campo errado na interface gráfica em menos de 1 segundo.
* **Objetivo:** OBJ-3 / FCS-3
* **Tipo:** NFR | **Prioridade:** Média (Usabilidade)
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * O elemento visual a vermelho aparece sob o campo afetado em < 1000ms após o evento de validação.
* **Método de Validação:** Teste de Performance UI.
* **Pré-condições:** O utilizador insere um dado logicamente inválido.
* **Pós-condições:** Feedback visual imediato fornecido ao utilizador.

---

### NFR-006: Retenção de Logs
* **Requisitante:** Auditor
* **Descrição:** Os logs de auditoria (NFR-001) devem ser mantidos em armazenamento imutável por um período mínimo de 12 meses.
* **Objetivo:** OBJ-2 / FCS-2
* **Tipo:** NFR | **Prioridade:** Média (Compliance)
* **Impacto da Variante:** Não
* **Critérios de Aceitação:**
    * Tentativas de eliminação de logs com menos de 365 dias são rejeitadas pelo sistema.
* **Método de Validação:** Inspeção de Políticas de Retenção (Storage).
* **Pré-condições:** Logs gerados pelo sistema.
* **Pós-condições:** Acesso garantido a histórico de 1 ano.