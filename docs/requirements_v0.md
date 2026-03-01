# Requirements v0 — Lab 2 (AMS)

## 1. Requisitos Estruturados

| Item | Requisito | Type | Stakeholder | Priority | Variant? |
|---:|---|---|---|---|---|
| 1 | O sistema deve impedir a submissão de um formulário de Intake se os campos obrigatórios (Nome do Sistema, Owner, Modelo de Suporte) estiverem vazios. | FR | Data Steward | H | Yes |
| 2 | O sistema deve exigir o preenchimento de uma "Data do Último Teste de DR" válida sempre que o campo "Disaster Recovery" for marcado como "Sim". | FR | Data Steward | H | Yes |
| 3 | O sistema deve assinalar uma submissão de Intake como "Inconsistente" se o campo "Disaster Recovery" for marcado como "Não", mas for fornecida uma data de teste. | FR | Data Steward | H | Yes |
| 4 | O sistema deve exigir um URL válido que aponte para o dashboard de monitorização para validar a evidência de observabilidade. | FR | Transition Lead | M | No |
| 5 | O sistema deve rejeitar automaticamente a evidência da data do teste de DR se a data fornecida for superior a 12 meses em relação à data atual. | FR | Data Steward | H | Yes |
| 6 | O sistema deve exigir a identificação explícita de um Owner (ID de Utilizador ou Email) para cada integração declarada no formulário. | FR | Transition Lead | M | No |
| 7 | O sistema deve rejeitar a criação de um novo perfil de sistema se o "Nome do Sistema" corresponder a um sistema ativo já existente na base de dados. | FR | Data Steward | H | Yes |
| 8 | O sistema deve permitir que os utilizadores guardem um formulário de Intake num estado de "Rascunho" (Draft) sem acionar as validações cruzadas obrigatórias. | FR | Transition Lead | M | Yes |
| 9 | O sistema deve transitar o Intake para o estado "Ready to Proceed" apenas quando todas as regras de validação e verificações de consistência passarem com sucesso. | FR | Data Steward | H | Yes |
| 10 | O sistema deve manter um registo de auditoria (audit trail) para alterações em campos críticos, registando o ID do Utilizador, a data/hora e os valores anterior e novo. | NFR | Auditor | M | No |

*(Legenda: FR = Functional Requirement, NFR = Non-Functional Requirement, H = High, M = Medium, L = Low)*

---

## 2. Reescrita de Ambiguidade (min. 5)

**1) Original:** "O sistema deve validar os dados corretamente." *(Ambíguo: O que significa corretamente?)*
* **Reescrito:** "O sistema deve executar regras de validação cruzada no momento da submissão e retornar uma mensagem de erro específica, impedindo a submissão se 'DR=Não' e a 'Data de DR' estiver preenchida." *(Foco na Variante 4)*

**2) Original:** "O sistema deve mostrar se a informação está má." *(Ambíguo: Como mostra? O que é "má"?)*
* **Reescrito:** "O sistema deve marcar explicitamente um registo de Intake com o estado 'Inválido' quando faltarem campos obrigatórios ou forem detetadas inconsistências cruzadas entre campos." *(Foco na Variante 4)*

**3) Original:** "O sistema deve ser rápido." *(Ambíguo: Quão rápido?)*
* **Reescrito:** "O sistema deve processar as validações do formulário de Intake e apresentar o feedback (mensagens de sucesso ou erro) ao utilizador em menos de 2 segundos para 95% das submissões."

**4) Original:** "A evidência deve ser recente." *(Ambíguo: O que é recente?)*
* **Reescrito:** "O sistema deve rejeitar anexos ou links de evidências operacionais se a 'data da evidência' associada for superior a 6 meses."

**5) Original:** "O sistema deve ser seguro." *(Ambíguo: Seguro de que forma?)*
* **Reescrito:** "O sistema deve restringir a transição para o estado 'Ready to Proceed' exclusivamente a utilizadores autenticados e com a função (role) de 'Data Steward' ou 'Transition Lead'."

* ID,Cenário,Critério de Aceitação
AC.1,Submissão com campos obrigatórios vazios,"Se o utilizador tentar submeter o Intake sem o ""Owner"" ou ""Modelo de Suporte"", o sistema deve bloquear a ação, marcar o estado como ""Incomplete"" e exibir uma mensagem de erro realçando os campos em falta."
AC.2,Inconsistência de Disaster Recovery,"Se ""Disaster Recovery = Não"" e ""Data do Teste"" estiver preenchida, o sistema deve impedir a transição para ""Ready to Proceed"", marcar o registo como ""Inconsistent"" e exigir a correção dos dados."
