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

## 3. Critérios de Aceitação (Foco em Estados Inválidos e Consistência)

Estes critérios definem as condições necessárias para que uma funcionalidade seja aceite, focando-se na prevenção de dados inconsistentes (Variante 4).

| ID | Cenário | Critério de Aceitação |
|:---|:---|:---|
| **AC.1** | Submissão com campos obrigatórios em falta | **Dado** que o utilizador está no formulário de Intake, **Quando** tenta submeter sem preencher "Nome do Sistema" ou "Owner", **Então** o sistema deve bloquear a submissão, apresentar uma mensagem de erro e manter o estado como **"Incomplete"**. |
| **AC.2** | Validação de consistência de Disaster Recovery (DR) | **Dado** que o utilizador selecionou "Disaster Recovery = Não", **Quando** insere uma data no campo "Último Teste de DR", **Então** o sistema deve marcar o Intake como **"Inconsistent"** e impedir a transição para "Ready to Proceed" até que a contradição seja resolvida. |
| **AC.3** | Validação de caducidade de evidência | **Dado** que uma evidência operacional é carregada, **Quando** a data da evidência for superior a 12 meses em relação à data atual, **Então** o sistema deve rejeitar o ficheiro com um aviso de "Evidência Expirada". |

---

## 4. Plano de Testes de Qualidade de Dados (Variante 4)

Conforme exigido pela variante, definimos os seguintes cenários de teste para validar a consistência cruzada.

### Teste 1: Validação de Estado Inconsistente (Lógica Cruzada)
* **Objetivo:** Garantir que o sistema deteta informações contraditórias.
* **Input:** `Disaster Recovery = "Não"` E `Data do Teste = "2024-05-20"`.
* **Resultado Esperado:** O sistema deve lançar um erro de validação e impedir o estado "Ready".

### Teste 2: Validação de Validade Temporal (Teste Parametrizado)
Este teste utiliza múltiplos cenários de dados para validar a regra de "máximo 12 meses".

| ID | Input (Idade da Evidência) | Resultado Esperado |
|:---|:---|:---|
| **T2.1** | 6 meses atrás | **Sucesso**: Evidência aceite. |
| **T2.2** | 13 meses atrás | **Falha**: Sistema rejeita por antiguidade (Limite > 12 meses). |
| **T2.3** | Data no futuro (+1 mês) | **Falha**: Sistema rejeita por data inválida. |
