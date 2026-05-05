# Matriz de Rastreabilidade — Requisitos vs Casos de Teste (Lab 9)

Este documento estabelece a ligação entre os Requisitos Funcionais (FR) e Não Funcionais (NFR) definidos no REM v1 e os Casos de Teste (TC) desenhados para o Lab 9, garantindo a cobertura total da **Variante 4 (Data Quality & Consistency)**.

## Mapeamento de Rastreabilidade

| ID Requisito | Título do Requisito | Caso de Teste (TC) | Objetivo da Validação |
|:---|:---|:---|:---|
| **REQ-001** | Validação de Campos Obrigatórios | **TC-001** | Garantir que dados "órfãos" ou apenas com espaços (`trim`) são bloqueados. |
| **REQ-002** | Condicionalidade de Teste de DR | **TC-002** | Validar se a obrigatoriedade da data é ativada dinamicamente quando DR = "Sim". |
| **REQ-003** | Deteção de Inconsistência de DR | **TC-003** | **Gatekeeper:** Bloquear submissão se houver contradição lógica (DR="Não" com data). |
| **REQ-005** | Validação de Caducidade de Evidências | **TC-004** | Garantir a integridade temporal (Data Freshness) rejeitando ficheiros > 365 dias. |
| **REQ-007** | Prevenção de Duplicados (Unicidade) | **TC-005** | Validar a unicidade do Hostname contra a Asset Database no evento `onBlur`. |
| **REQ-008** | Gestão de Estados (Rascunho) | **TC-006** | Validar o bypass intencional das regras de consistência para permitir trabalho assíncrono. |
| **NFR-001** | Log de Auditoria | **TC-008** | Garantir que alterações em campos críticos geram registos imutáveis com UserID e Timestamp. |
| **NFR-002** | Performance de Validação | **TC-007** | Validar se o motor de regras responde em menos de 500ms para manter a eficiência operacional. |

---

## Cobertura por Use Cases (UC)

Seguindo o alinhamento com o **Use Case Diagram v2**, os testes cobrem as seguintes interações sistémicas:

*   **UC-01 (Submeter Novo Ativo):** Validado pelos TC-001, TC-002, TC-005 e TC-008.
*   **UC-02 (Guardar Rascunho):** Validado pelo TC-006.
*   **UC-03 (Upload de Evidências):** Validado pelo TC-004.
*   **UC-04 (Validar Consistência):** Validado pelos TC-003 e TC-007 (Núcleo do Gatekeeper da Variante 4).
*   **UC-06 (Exportar Logs):** Validado pelo TC-008 no que respeita à criação de registos auditáveis.

## Observações de Cobertura
- **REQ-009 (Transição Final):** É testado indiretamente em todos os Happy Paths (TC-002, TC-008), onde o estado "Ready to Proceed" só é atingido após 100% de sucesso no motor de regras.
- **NFR-004 (Qualidade Garantida):** Validada pelo TC-008, assegurando que nenhuma submissão via API contorna as regras de integridade.