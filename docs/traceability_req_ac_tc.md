# Matriz de Rastreabilidade Integrada (REQ → AC → TC/Cenário)


| ID REQ | Descrição Curta | Critérios de Aceitação (AC) | Validação (TC / Cenário BDD) |
| :--- | :--- | :--- | :--- |
| **REQ-001** | Validação de Campos Obrigatórios | **AC-1:** Validar Nome, Owner e Suporte no envio.<br>**AC-2:** Uso de `trim()` para rejeitar espaços vazios. | **TC-001:** Bloqueio de submissão com campos invisíveis (Boundary) |
| **REQ-002** | Condicionalidade de DR | **AC-1:** Exibir e marcar data como obrigatória se DR=Sim.<br>**AC-2:** Bloquear envio se DR=Sim e data estiver vazia. | **TC-002:** Validação condicional de DR ativa (Happy Path) |
| **REQ-003** | Inconsistência Lógica de DR | **AC-1:** Desativar campo de data se DR=Não.<br>**AC-3:** Rejeitar via API se houver data com DR=Não. | **TC-003:** Inconsistência Lógica de DR (Negative)<br>**SCEN-001:** Prevenir informações contraditórias de Disaster Recovery |
| **REQ-005** | Caducidade de Evidências | **AC-1:** Comparar data da evidência com `Date.now()`.<br>**AC-2:** Abortar upload se diferença > 365 dias. | **TC-004:** Caducidade de Evidência de 366 dias (Boundary) |
| **REQ-006** | Identificação de Owner | **AC-1:** Validar formato de e-mail corporativo.<br>**AC-2:** Rejeitar e-mails inexistentes no diretório (AD). | **TC-008:** Auditoria de Alterações Críticas (Validação de Owner) |
| **REQ-007** | Unicidade de Hostname | **AC-1:** Consulta API via `GET` no evento `onBlur`.<br>**AC-2:** Desativar botão se retornar `409 Conflict`. | **TC-005:** Unicidade de Hostname (onBlur)<br>**SCEN-003:** Detetar nome de ativo duplicado através da Base de Dados |
| **REQ-008** | Gestão de Estados (Draft) | **AC-1:** Ignorar validações lógicas ao guardar rascunho.<br>**AC-2:** Persistir dados com a flag `is_draft=True`. | **TC-006:** Gravação de Rascunho com Dados em Falta<br>**SCEN-002:** Permitir progresso parcial através do modo Rascunho (Draft) |
| **REQ-009** | Transição para "Ready" | **AC-1:** Exigir 0 erros lógicos para transição.<br>**AC-2:** Forçar reexecução total do motor na submissão. | **TC-003:** (Reutilizado para validar bloqueio de transição)<br>**TC-009:** Fluxo completo de transição para "Ready" |

---

