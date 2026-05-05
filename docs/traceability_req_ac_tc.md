# Matriz de Rastreabilidade Integrada (REQ → AC → TC/Cenário)

Esta matriz vincula os Requisitos Funcionais da **Variante 4 (Data Steward)** aos seus Critérios de Aceitação, Casos de Teste (TC) e Cenários de Comportamento (BDD).

| ID REQ | Descrição | Critérios de Aceitação (AC) | Caso de Teste (TC) | Cenário BDD (Comportamento) |
| :--- | :--- | :--- | :--- | :--- |
| **REQ-001** | Validação de Campos Obrigatórios | **AC-1:** Bloqueio de campos vazios.<br>**AC-2:** Uso de `trim()` para evitar espaços.<br>**AC-3:** Destaque visual (moldura vermelha). | **TC-001** (Boundary) | - |
| **REQ-002** | Condicionalidade de DR | **AC-1:** Data obrigatória se DR=Sim.<br>**AC-2:** Exibir marcador de obrigatoriedade.<br>**AC-3:** Aceitar transição se data preenchida. | **TC-002** (Happy Path) | - |
| **REQ-003** | Inconsistência Lógica de DR | **AC-1:** Bloquear se DR=Não e houver data.<br>**AC-2:** Marcar como "Inconsistent".<br>**AC-3:** Limpeza automática (auto-clean) de data. | **TC-003** (Negative) | **SCEN-001:** Prevenir informações contraditórias de Disaster Recovery |
| **REQ-005** | Caducidade de Evidências | **AC-1:** Rejeitar data > 365 dias.<br>**AC-2:** Notificação "Evidência Expirada". | **TC-004** (Boundary) | **SCEN-004:** Validação de caducidade temporal de evidências |
| **REQ-007** | Prevenção de Duplicados | **AC-1:** Validação via `onBlur` contra DB.<br>**AC-2:** Desativar botão de submissão. | **TC-005** (Integration) | **SCEN-003:** Detetar nome de ativo duplicado através da Base de Dados |
| **REQ-008** | Gestão de Estados (Draft) | **AC-1:** Ignorar validações cruzadas.<br>**AC-2:** Persistir com flag `is_draft=True`. | **TC-006** (Alternative) | **SCEN-002:** Permitir progresso parcial através do modo Rascunho (Draft) |
| **REQ-009** | Transição para "Ready" | **AC-1:** Exigir 100% de sucesso nas regras.<br>**AC-2:** Logar transição com timestamp.<br>**AC-3:** Forçar reexecução total do motor. | **TC-003** e **TC-009** | - |

---

