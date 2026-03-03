# Requirements v1 — Lab 3 (CodeTroopers) 

## 1. Objetivos e CSFs (Cadeia de Valor)
* **OBJ-1: Garantir a integridade e consistência dos dados de inventário.**
    * **CSF-1.1:** Implementar validações cruzadas obrigatórias entre campos dependentes.
    * **CSF-1.2:** Impedir a entrada de dados contraditórios ou obsoletos (evidência caducada).
* **OBJ-2: Assegurar a rastreabilidade e auditoria do processo de Intake.**
    * **CSF-2.1:** Manter registos detalhados de quem alterou dados críticos.

## 2. Requisitos Funcionais Detalhados (Top 6)

| ID | Título | Tipo | Prioridade | Descrição | Objetivo/CSF | Variante? |
|:---|:---|:---|:---:|:---|:---|:---:|
| **REQ-001** | Validação de Campos Obrigatórios | FR | H | O sistema deve impedir a submissão se "Nome do Sistema", "Owner" ou "Modelo de Suporte" estiverem vazios. | OBJ-1 / CSF-1.1 | Sim |
| **REQ-002** | Condicionalidade de Teste DR | FR | H | Se o campo "Disaster Recovery" for "Sim", o campo "Data do Último Teste" torna-se obrigatório. | OBJ-1 / CSF-1.1 | Sim |
| **REQ-003** | Deteção de Inconsistência de DR | FR | H | Se "Disaster Recovery" for "Não" e existir uma data de teste, o sistema deve marcar como "Inconsistent". | OBJ-1 / CSF-1.2 | Sim |
| **REQ-004** | Validação de Caducidade | FR | H | O sistema deve rejeitar evidências operacionais com data superior a 12 meses face à data atual. | OBJ-1 / CSF-1.2 | Sim |
| **REQ-005** | Prevenção de Duplicados | FR | H | O sistema deve impedir a criação de um ativo se o "Nome do Sistema" já existir na base de dados ativa. | OBJ-1 / CSF-1.1 | Sim |
| **REQ-006** | Gestão de Estados de Submissão | FR | M | O sistema deve permitir guardar como "Draft" sem validações, mas só transitar para "Ready" após sucesso total. | OBJ-1 / CSF-1.1 | Sim |

## 3. Requisitos Não Funcionais (NFR)

| ID | Título | Categoria | Mensurável / Verificável | Variante? |
|:---|:---|:---|:---|:---:|
| **NFR-001** | Log de Auditoria | Audit | O sistema deve registar ID de utilizador, data/hora e valor antigo/novo para alterações em campos críticos. | Não |
| **NFR-002** | Performance de Validação | Eficiência | As validações de consistência devem responder em menos de 500ms para 95% dos pedidos. | Sim |
| **NFR-003** | Disponibilidade | Fiabilidade | O serviço de validação deve ter um uptime de 99.9% mensal. | Não |
| **NFR-004** | Qualidade de Dados | Integridade | 100% dos registos no estado "Ready" devem cumprir as regras de consistência cruzada. | Sim |
| **NFR-005** | Mensagens de Erro | Usabilidade | O sistema deve identificar explicitamente qual o campo e a regra que causou a inconsistência. | Sim |
| **NFR-006** | Retenção de Logs | Legal | Os logs de auditoria devem ser mantidos por um período mínimo de 12 meses. | Não |
