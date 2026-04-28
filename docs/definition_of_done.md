# Definition of Done (DoD) — Lab 7

## DoD — Requirement (REQ-### / NFR-###)
Um requisito é considerado "Done" (Concluído) quando:
1. Possui um ID estável (REQ-001 a 009 ou NFR-001 a 006), um título claro e o tipo explicitamente definido (FR/NFR).
2. O Stakeholder principal (ex: Data Steward, Transition Lead) e o Autor estão claramente registados.
3. A descrição é inequívoca, testável e evita fugas de implementação (foca-se no "O quê" e "Porquê", e não no "Como").
4. Existem critérios de aceitação (mín. 2–4), são totalmente verificáveis e cobrem tanto o caminho de sucesso (happy path) como os de erro/exceção (crucial para a Qualidade de Dados).
5. **[Foco na Variante]** O impacto da variante está indicado (Sim/Não). Se 'Sim', a lógica específica de validação cruzada entre campos ou a regra de integridade de dados deve estar claramente definida.
6. **[Foco nos NFR]** Se for um Requisito Não Funcional, contém uma declaração quantificável e mensurável (ex: "< 500ms", "100% de conformidade", "< 1s de tempo de resposta na UI").
7. Estão identificadas as ligações e dependências com outros requisitos (ex: REQ-009 depende do REQ-001 ao REQ-007).
8. Conflitos ou duplicações foram resolvidos e validados através de uma sessão de role-play em equipa.
9. O método de validação está definido (ex: Revisão por Pares / Demo / Teste Automatizado / Medição de Telemetria).

## DoD — User Story (US-###)
Uma User Story é considerada "Done" (Concluída) quando:
1. A história está escrita no formato correto (Como um... Eu quero... Para que...), fornecendo claro valor de negócio para o processo de AMS Intake.
2. Os critérios de aceitação foram acordados, são compatíveis com BDD (Given/When/Then quando aplicável) e estão explicitamente mapeados para os requisitos do projeto.
3. **[Foco na Variante]** A implementação atua como um "Gatekeeper" (filtro) rigoroso: garante que zero inconsistências de dados, ficheiros obsoletos ou registos duplicados possam transitar para o estado "Ready to Proceed".
4. Existem testes adequados (Testes Unitários para lógica de validação, Testes de Integração para APIs) e passam com sucesso.
5. Não restam defeitos críticos ou bloqueantes na branch de código (especificamente, nenhuma validação obrigatória foi contornada ou desativada).
6. A arquitetura do sistema, matrizes de rastreabilidade (`traceability_uc_req.md`) e documentação da API foram atualizadas (caso tenham ocorrido alterações).
7. O código passou por Revisão por Pares (Pull Request aprovado e integrado/merged por pelo menos 1 outro developer).
8. O Product Owner / Data Steward aceita o resultado através de uma validação visual bem-sucedida (Demo).
