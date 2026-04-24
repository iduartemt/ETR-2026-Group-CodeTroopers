# Objetivos e Fatores Críticos de Sucesso (FCSs) — Lab 4

## Variante
- **Número da Variante:** 4 — Qualidade e Consistência de Dados
- **Persona:** Data Steward / Gestor de Qualidade
- **Foco da Restrição Chave:** Validação cruzada, integridade de dados e prevenção de obsolescência/duplicação.

---

## Objetivos (3)

### OBJ-1 — Garantir a Integridade, Unicidade e Consistência Total dos Dados
- **Descrição (porquê/resultado):** Implementar um processo de entrada de dados (Intake) onde seja impossível submeter informações contraditórias, incompletas, obsoletas ou duplicadas na base de dados ativa.
- **Stakeholders impactados:** Data Steward, Transition Lead.
- **Sinal de sucesso (como sabemos):** Existência de zero registos no estado "Ready to Proceed" com inconsistências lógicas ou duplicações.
- **Impulsionado pela variante:** Sim.

### OBJ-2 — Assegurar a Rastreabilidade e Auditabilidade do Processo
- **Descrição:** Manter um registo imutável de todas as alterações em campos críticos e garantir que todas as integrações têm um proprietário (Owner) claramente identificado para fins de compliance.
- **Stakeholders impactados:** Auditor, Gestor de IT, Data Steward.
- **Sinal de sucesso:** 100% das alterações críticas registadas com identificação de utilizador/timestamp e 100% das integrações com Owners atribuídos.
- **Impulsionado pela variante:** Não.

### OBJ-3 — Otimizar a Eficiência Operacional e Resiliência do Sistema
- **Descrição:** Minimizar o tempo de correção de erros através de validações síncronas imediatas, garantir alta disponibilidade e permitir que o trabalho incompleto seja guardado de forma segura sem bloquear o utilizador.
- **Stakeholders impactados:** Transition Lead, End User.
- **Sinal de sucesso:** As validações de consistência respondem em menos de 500ms e o sistema garante uptime de 99.9%.
- **Impulsionado pela variante:** Sim.

---

## Fatores Críticos de Sucesso (FCSs) e Mapeamento

### FCS-1: Dados de inventário são consistentes, únicos e validados antes do estado operacional (Ligação: OBJ-1)
*Para garantir a integridade total, o sistema atua como um "gatekeeper" estrito (Variante 4).*
- **REQ-001:** Validação de Campos Obrigatórios
- **REQ-002:** Condicionalidade de Teste de DR
- **REQ-003:** Deteção de Inconsistência de DR (Lógica Cruzada)
- **REQ-004:** Validação de Evidência de Observabilidade (URL)
- **REQ-005:** Validação de Caducidade de Evidências (> 365 dias)
- **REQ-007:** Prevenção de Duplicados (Unicidade de Hostname)
- **REQ-009:** Transição para "Ready to Proceed" (Exige 100% sucesso)
- **NFR-004:** Qualidade de Dados Garantida (100% consistência)

### FCS-2: Alterações a dados críticos e responsabilidades são totalmente rastreáveis (Ligação: OBJ-2)
*Garante a conformidade legal e a correta atribuição de responsabilidades operacionais.*
- **REQ-006:** Identificação de Owner em Integrações
- **NFR-001:** Log de Auditoria (Audit Trail detalhado)
- **NFR-006:** Retenção de Logs em storage imutável por 12 meses

### FCS-3: O sistema fornece feedback imediato, é fiável e permite fluxos de trabalho flexíveis (Ligação: OBJ-3)
*A eficiência na recolha de dados exige ferramentas rápidas, sempre disponíveis e tolerantes a interrupções de trabalho.*
- **REQ-008:** Gestão de Estados de Submissão (Rascunho / Draft)
- **NFR-002:** Performance de Validação (< 500ms)
- **NFR-003:** Disponibilidade do Serviço (Uptime de 99.9%)
- **NFR-005:** Tempo de Resposta de Mensagens de Erro na UI (< 1s)