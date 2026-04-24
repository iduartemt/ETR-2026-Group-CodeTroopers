# Requirements Validation — Lab 7

## Participants / roles
- **Client/Stakeholders**: Bruno Martinho (Data Steward)
- **DevTeam**: Duarte Martins (Lead Developer)
- **Facilitator**: Bruno Martinho
- **Scribe**: Duarte Martins
- **Reviewer**: Denivaldo Antonio
- **Tester**: Diogo Sá

## Selected requirements (10 items)
- **REQ-001** (Variant impact: Yes) — Validação de Campos Obrigatórios
- **REQ-002** (Variant impact: Yes) — Condicionalidade de Teste de DR
- **REQ-003** (Variant impact: Yes) — Deteção de Inconsistência de DR
- **REQ-004** (Variant impact: No) — Validação de URL de Dashboard
- **REQ-005** (Variant impact: Yes) — Validação de Caducidade de Evidências
- **REQ-006** (Variant impact: No) — Identificação de Owner em Integrações
- **REQ-007** (Variant impact: Yes) — Prevenção de Duplicados (Unicidade)
- **REQ-008** (Variant impact: Yes) — Gestão de Estados (Rascunho / Draft)
- **REQ-009** (Variant impact: Yes) — Transição para "Ready to Proceed"
- **NFR-001** (Variant impact: No) — Log de Auditoria (Audit Trail)

## Variant-driven validation questions (min. 3)
1. **[Data Quality / REQ-003]**: Se o utilizador alterar o campo "Disaster Recovery" para "Não" após já ter inserido uma data, o sistema deve limpar o campo automaticamente ou apenas marcar como erro?
2. **[Data Quality / REQ-007]**: No caso de a Asset Database externa estar temporariamente indisponível, o sistema deve bloquear a submissão "Ready" ou permitir com um aviso de "Validação Pendente"?
3. **[Data Quality / REQ-005]**: A verificação dos 12 meses deve ser feita com base na data de modificação do ficheiro carregado ou numa data introduzida manualmente no formulário?

## Validation results

### REQ-001 — Validação de Campos Obrigatórios
- **Status**: Valid
- **Issues found**: Necessidade de garantir que campos preenchidos apenas com espaços em branco são tratados como vazios.
- **Proposed fix**: Aplicar a função `trim()` nos campos "Nome do Sistema", "Owner" e "Modelo de Suporte" antes da validação síncrona.
- **Expected evidence**: Teste unitário injetando espaços vazios.

### REQ-002 — Condicionalidade de Teste de DR
- **Status**: Valid
- **Issues found**: Falta de indicação visual dinâmica na interface para o utilizador perceber que a obrigatoriedade mudou.
- **Proposed fix**: Adicionar um marcador visual (asterisco vermelho) que aparece/desaparece conforme a seleção do campo "Disaster Recovery".
- **Expected evidence**: Demonstração de UI (Demo).

### REQ-003 — Deteção de Inconsistência de DR
- **Status**: Valid
- **Issues found**: Ambiguidade sobre se o utilizador pode guardar o formulário neste estado de erro lógico.
- **Proposed fix**: Permitir guardar em estado "Draft", mas bloquear explicitamente o botão "Submeter Final" se a inconsistência persistir.
- **Expected evidence**: Demonstração de bloqueio de transição de estado.

### REQ-004 — Validação de URL de Dashboard
- **Status**: Valid
- **Issues found**: Risco de aceitar URLs maliciosos ou não seguros (HTTP).
- **Proposed fix**: Implementar uma Regex estrita que exija `https://` e valide o formato de domínio corporativo.
- **Expected evidence**: Teste de integração com lista de URLs válidos e inválidos.

### REQ-005 — Validação de Caducidade de Evidências
- **Status**: Valid
- **Issues found**: "12 meses" pode ser interpretado de forma diferente dependendo do mês (30/31 dias) e anos bissextos.
- **Proposed fix**: Definir tecnicamente como 365 dias corridos face à data atual do servidor (`Date.now()`).
- **Expected evidence**: Teste automatizado com ficheiros datados de T-364 e T-366 dias.

### REQ-006 — Identificação de Owner em Integrações
- **Status**: Needs Rewrite
- **Issues found**: A entrada manual de ID ou Email pode gerar duplicados ou lixo de dados por erros de digitação.
- **Proposed fix**: Substituir o campo de texto livre por um componente de *autocomplete* ligado à base de dados de utilizadores ativa (Active Directory).
- **Expected evidence**: Revisão de protótipo de UI.

### REQ-007 — Prevenção de Duplicados
- **Status**: Valid
- **Issues found**: A verificação constante e síncrona na base de dados (onKeyPress) pode causar lentidão severa na interface.
- **Proposed fix**: Implementar a verificação de duplicados apenas quando o utilizador remove o foco do campo (evento *onBlur*) ou ao clicar no botão de submissão.
- **Expected evidence**: Medição de performance de resposta da interface.

### REQ-008 — Gestão de Estados (Draft)
- **Status**: Valid
- **Issues found**: Não estava definido se os anexos (evidências) deveriam ser guardados de forma temporária no estado de rascunho.
- **Proposed fix**: Sim, o rascunho deve persistir todos os dados temporariamente, incluindo ficheiros em storage *temp*, para permitir trabalho assíncrono.
- **Expected evidence**: Inspeção de base de dados após "Guardar Rascunho".

### REQ-009 — Transição para "Ready to Proceed"
- **Status**: Valid
- **Issues found**: Se o formulário ficar em "Draft" muito tempo, a evidência pode expirar antes da transição para "Ready".
- **Proposed fix**: Forçar a execução de todo o motor de regras completo (UC-04) no exato milissegundo do clique em "Submeter Final", não assumindo dados anteriores como válidos.
- **Expected evidence**: Teste de sistema (End-to-End).

### NFR-001 — Log de Auditoria
- **Status**: Valid
- **Issues found**: Falta de definição exaustiva dos chamados "campos críticos".
- **Proposed fix**: Listar explicitamente no documento técnico que campos como "Owner", "DR" e "Nome do Sistema" são os únicos que disparam log de auditoria.
- **Expected evidence**: Inspeção ao ficheiro JSON de logs após edição de um ativo.