# REM v1 — Equipa CodeTroopers (Lab 4)

Este documento detalha os 8 requisitos principais para o módulo de Intake & Discovery, com foco na qualidade de dados.

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

---

### REQ-006: Gestão de Estados (Rascunho vs Pronto)
* **Requisitante:** Transition Lead
* **Descrição:** Permitir guardar como "Rascunho" mesmo com erros, mas o estado "Pronto" exige sucesso total nas validações.
* **Objetivo:** OBJ-2 / FCS-2
* **Tipo:** FR | **Prioridade:** Média
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * O botão "Guardar Rascunho" está sempre disponível.
    * A transição para "Pronto" só ocorre se todas as regras (REQ-001 a REQ-005) forem cumpridas.
* **Método de Validação:** Inspeção / Demonstração.

---

### NFR-001: Log de Auditoria
* **Requisitante:** Auditor
* **Descrição:** Registar ID de utilizador, data/hora e valores (antigo e novo) para alterações em campos críticos.
* **Objetivo:** OBJ-2 / FCS-2
* **Tipo:** Requisito Não Funcional (NFR) | **Prioridade:** Média
* **Impacto da Variante:** Não.
* **Critérios de Aceitação:**
    * O log é gerado automaticamente após a alteração do campo "Owner".
    * O registo do log deve ser imutável.
* **Método de Validação:** Inspeção (Auditoria de Base de Dados).

---

### NFR-002: Performance de Validação
* **Requisitante:** Data Steward
* **Descrição:** As validações de consistência cruzada devem responder em menos de 500ms para a maioria dos pedidos.
* **Objetivo:** OBJ-3 / FCS-3
* **Tipo:** NFR | **Prioridade:** Eficiência
* **Impacto da Variante:** Sim
* **Critérios de Aceitação:**
    * 95% dos pedidos de validação cumprem o tempo limite de 500ms.
* **Método de Validação:** Teste de Performance (Teste de Carga).
