# Objetivos e Fatores Críticos de Sucesso (FCSs) — Lab 4

## Variante
- **Número da Variante:** 4 — Qualidade e Consistência de Dados
- **Persona:** Data Steward / Gestor de Qualidade
- **Foco da Restrição Chave:** Validação cruzada e integridade de dados (validação entre campos).

---

## Objetivos (3)

### OBJ-1 — Garantir a Integridade e Consistência Total dos Dados
- **Descrição (porquê/resultado):** Implementar um processo de entrada de dados (Intake) onde seja impossível submeter informações contraditórias ou incompletas.
- **Stakeholders impactados:** Data Steward, Transition Lead.
- **Sinal de sucesso (como sabemos):** Existência de zero registos no estado "Pronto" com inconsistências lógicas.
- **Impulsionado pela variante:** Sim.

### OBJ-2 — Assegurar a Rastreabilidade e Auditabilidade do Processo
- **Descrição:** Manter um registo imutável de todas as alterações em campos críticos para fins de conformidade e auditoria.
- **Stakeholders impactados:** Auditor, Gestor de IT.
- **Sinal de sucesso:** 100% das alterações críticas registadas com identificação de utilizador e data/hora.
- **Impulsionado pela variante:** Não.

### OBJ-3 — Otimizar a Eficiência Operacional através de Feedback em Tempo Real
- **Descrição:** Minimizar o tempo de correção de erros através de validações imediatas e mensagens claras para o utilizador.
- **Stakeholders impactados:** Transition Lead, Data Steward.
- **Sinal de sucesso:** As validações de consistência respondem em menos de 500ms.
- **Impulsionado pela variante:** Sim.

---

## Fatores Críticos de Sucesso (FCSs) e Mapeamento

### FCS-1: Dados de inventário são consistentes, completos e validados antes da gravação (Ligação: OBJ-1)
- **REQ-001:** Validação de Campos Obrigatórios
- **REQ-002:** Condicionalidade de Teste de DR
- **REQ-003:** Deteção de Inconsistência de DR
- **REQ-004:** Validação de Caducidade de Evidências
- **NFR-004:** Métrica de Qualidade de Dados (100% consistência)

### FCS-2: Alterações a dados críticos são totalmente rastreáveis e justificáveis (Ligação: OBJ-2)
- **REQ-006:** Gestão de Estados de Submissão (Rastreio de transições)
- **NFR-001:** Log de Auditoria Detalhado
- **NFR-006:** Retenção de Logs por 12 meses

### FCS-3: O feedback de erros é imediato e preserva a eficiência operacional do utilizador (Ligação: OBJ-3)
- **REQ-005:** Prevenção de Duplicados Síncrona
- **NFR-002:** Performance de Validação (<500ms)
- **NFR-005:** Mensagens de Erro Contextuais
