# Requisitos v1 — Equipa CodeTroopers

**Slice:** Intake & Discovery (AMS)
**Variante:** 4 — Qualidade e Consistência de Dados (Data Steward)

## 1. Objetivos e Cadeia de Valor
* **OBJ-1: Garantir a integridade e consistência dos dados de inventário.**
    * **CSF-1.1:** Implementar validações cruzadas obrigatórias entre campos dependentes.
    * **CSF-1.2:** Impedir a entrada de dados contraditórios ou obsoletos.
* **OBJ-2: Assegurar a rastreabilidade e auditoria do processo de Intake.**
    * **CSF-2.1:** Manter registos detalhados de quem alterou dados críticos.

---

## 2. Requisitos Funcionais Detalhados

### REQ-001: Validação de Campos Obrigatórios (Core)
* **Épico:** Validação de Intake
* **Prioridade:** High
* **Descrição:** O sistema deve impedir a submissão de qualquer formulário se os campos fundamentais "Nome do Sistema", "Owner" (Responsável) ou "Modelo de Suporte" estiverem vazios ou nulos.
* **Objetivo:** Garantir o preenchimento mínimo para que um ativo seja gerível (OBJ-1).
* **Impacto da Variante:** **SIM** (Qualidade Básica).
* **Critérios de Aceitação (Rascunho):**
    1.  Dado que o campo "Owner" está vazio, quando clico em "Submeter", o sistema deve mostrar o erro "O campo Owner é obrigatório".
    2.  O formulário não deve ser enviado para o backend enquanto houver erros.

### REQ-002: Condicionalidade de Teste de Disaster Recovery (DR)
* **Épico:** Validação Cruzada
* **Prioridade:** High
* **Descrição:** O sistema deve aplicar lógica condicional: se o utilizador selecionar "Sim" no campo "Disaster Recovery", o campo "Data do Último Teste" torna-se imediatamente obrigatório.
* **Objetivo:** Assegurar que ativos críticos têm prova de teste de recuperação (CSF-1.1).
* **Impacto da Variante:** **SIM** (Regra Dependente).
* **Critérios de Aceitação (Rascunho):**
    1.  Dado que seleciono "Disaster Recovery = Sim", o campo de data deve ficar marcado com asterisco (*).
    2.  Dado que seleciono "Disaster Recovery = Não", o campo de data deve ficar opcional ou desativado.

### REQ-003: Deteção de Inconsistência de DR
* **Épico:** Validação Cruzada
* **Prioridade:** High
* **Descrição:** O sistema deve detetar incoerências lógicas: se "Disaster Recovery" for "Não", mas o utilizador tiver inserido uma "Data do Último Teste", o sistema deve marcar o registo como "Inconsistente" e pedir correção.
* **Objetivo:** Limpar dados contraditórios antes de entrarem na base de dados (CSF-1.2).
* **Impacto da Variante:** **SIM** (Sanidade de Dados).
* **Critérios de Aceitação (Rascunho):**
    1.  Dado DR="Não" e Data="2025-01-01", ao validar, o sistema deve mostrar alerta: "Não pode haver data de teste se não há DR configurado".

### REQ-004: Validação de Caducidade de Evidências
* **Épico:** Gestão de Evidências
* **Prioridade:** High
* **Descrição:** O sistema deve validar a data dos ficheiros ou metadados de evidência carregados. Deve rejeitar evidências operacionais (ex: testes manuais) com data superior a 12 meses face à data atual.
* **Objetivo:** Garantir que o inventário reflete o estado atual e não histórico (CSF-1.2).
* **Impacto da Variante:** **SIM** (Regra Temporal).
* **Critérios de Aceitação (Rascunho):**
    1.  Dado um documento datado de "2023-01-01" e a data atual é "2026-02-10", o sistema deve rejeitar o upload com erro "Evidência expirada (>1 ano)".

### REQ-005: Prevenção de Duplicados (Unicidade)
* **Épico:** Integridade de Dados
* **Prioridade:** High
* **Descrição:** O sistema deve realizar uma verificação síncrona para impedir a criação de um ativo se o "Nome do Sistema" (Hostname) já existir na base de dados ativa.
* **Objetivo:** Evitar a duplicação de registos que distorce a contabilidade de ativos (CSF-1.1).
* **Impacto da Variante:** **SIM** (Unicidade).
* **Critérios de Aceitação (Rascunho):**
    1.  Ao perder o foco do campo "Nome do Sistema", o sistema verifica se o nome existe.
    2.  Se existir, mostra erro "Hostname já em uso" e bloqueia o botão de submissão.

### REQ-006: Gestão de Estados de Submissão (Draft vs Ready)
* **Épico:** Ciclo de Vida
* **Prioridade:** Medium
* **Descrição:** O sistema deve permitir guardar o formulário no estado "Draft" (Rascunho) mesmo com erros de validação, mas só deve permitir a transição para o estado "Ready" após sucesso em todas as regras de qualidade.
* **Objetivo:** Permitir trabalho assíncrono sem poluir a base de dados oficial com dados inválidos.
* **Impacto da Variante:** **SIM** (Gestão de Estado).
* **Critérios de Aceitação (Rascunho):**
    1.  Botão "Guardar Rascunho" funciona sempre, mesmo com campos vazios.
    2.  Botão "Submeter Final" só fica ativo se todas as validações (REQ-001 a REQ-005) estiverem verdes.

---

## 3. Requisitos Não Funcionais (NFR)

| ID | Título | Categoria | Declaração Mensurável | Variante? |
|:---|:---|:---|:---|:---:|
| **NFR-001** | Log de Auditoria | Audit | O sistema deve registar ID de utilizador, data/hora e valor antigo/novo para 100% das alterações em campos críticos. | Não |
| **NFR-002** | Performance de Validação | Eficiência | As validações de consistência (cross-field) devem responder em menos de **500ms** para 95% dos pedidos. | **Sim** |
| **NFR-003** | Disponibilidade | Fiabilidade | O serviço de validação deve garantir um uptime de **99.9%** mensal durante horário laboral. | Não |
| **NFR-004** | Qualidade de Dados | Integridade | **100%** dos registos que transitem para o estado "Ready" devem cumprir todas as regras de consistência cruzada definidas. | **Sim** |
| **NFR-005** | Mensagens de Erro | Usabilidade | O sistema deve identificar explicitamente o campo errado em **menos de 1 segundo** após a validação falhar. | **Sim** |
| **NFR-006** | Retenção de Logs | Legal | Os logs de auditoria devem ser mantidos em armazenamento imutável por um período mínimo de **12 meses**. | Não |
