# Traceability — Use Cases ↔ Requirements (Lab 6)

Este documento mapeia os Casos de Uso (UC) aos respetivos Requisitos Funcionais (FR) e Não Funcionais (NFR), garantindo que todas as funcionalidades desenvolvidas têm um propósito claro e que nenhum requisito fica "órfão".

## Mapping (UC → REQ)

| Use Case | Linked Requirements (REQ-### / NFR-###) | Notes |
|:---|:---|:---|
| **UC-01 (Submeter Intake)** | REQ-001, REQ-002, REQ-004, REQ-006, REQ-007, REQ-008, REQ-009, NFR-005 | Cobre todo o fluxo da interface de submissão, recolha de dependências e feedback visual imediato ao utilizador. |
| **UC-02 (Guardar Rascunho)** | REQ-008 | Foco exclusivo na gestão do estado "Draft", permitindo o *bypass* intencional às validações cruzadas. |
| **UC-03 (Upload Evidências)** | REQ-005 | Foco no carregamento de ficheiros operacionais e rejeição automática por caducidade (> 365 dias). |
| **UC-04 (Validar Consistência)**| REQ-001, REQ-002, REQ-003, REQ-005, REQ-007, REQ-009, NFR-002, NFR-004 | **Núcleo da Variante 4:** Atua como o motor de regras no backend, garantindo performance e 100% de qualidade de dados. |
| **UC-05 (Revisão pelo Steward)**| REQ-003, REQ-009 | Interação do Data Steward para corrigir dados sinalizados como "Inconsistente" antes da transição para "Ready". |
| **UC-06 (Exportar Logs)** | NFR-001, NFR-006 | Exportação do *Audit Trail* para fins de conformidade e garantia de retenção legal por 12 meses. |

## Gaps / Observations
- **Requisitos de Sistema Transversais:** O **NFR-003** (Disponibilidade de 99.9%) não está mapeado a um Caso de Uso interativo específico, uma vez que é um atributo arquitetural global que suporta a infraestrutura de todos os UCs.
- **Evolução da Variante 4 (Data Quality):** Com a introdução do motor de integridade estrito, o **UC-04** assumiu o papel de *Gatekeeper*. Desta forma, a transição final de estado (**REQ-009**) só é ativada se as validações cruzadas e lógicas passarem sem exceções, assegurando o cumprimento integral do **NFR-004**.
- **UX e Prevenção de Erros:** O **UC-01** absorveu o **NFR-005**, garantindo que a identificação de eventuais bloqueios (como o duplicado do **REQ-007**) é apresentada na UI em menos de 1 segundo.