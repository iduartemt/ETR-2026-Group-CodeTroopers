# Acceptance Criteria — Lab 7

## REQ-001 — Validação de Campos Obrigatórios
- **AC-1:** O sistema deve validar a presença dos campos 'Nome', 'Owner' e 'Suporte' no momento do clique em "Submeter Final".
- **AC-2:** Caracteres invisíveis (espaços) inseridos pelo utilizador devem ser limpos (`trim()`) e rejeitados como campos vazios.
- **AC-3:** O sistema deve destacar o campo vazio com uma moldura vermelha e manter o estado em "Incomplete".

## REQ-002 — Condicionalidade DR (Given/When/Then)
- **Given** que o utilizador selecionou a opção "DR = Sim".
- **When** o utilizador deixa a "Data do Último Teste" vazia e tenta submeter.
- **Then** o sistema exibe o erro "Campo obrigatório para sistemas com resiliência" e impede a gravação em estado "Ready".
- **AC-1:** O sistema deve exibir o campo "Data do Último Teste" e marcá-lo visualmente como obrigatório assim que o utilizador selecionar a opção "Sim" no campo "Disaster Recovery (DR)".
- **AC-2** Se o utilizador selecionar "Sim" em DR e tentar "Submeter Final" com a "Data do Último Teste" vazia, o sistema deve bloquear a submissão e exibir a mensagem de erro "Campo obrigatório para sistemas com resiliência".
- **AC-3** Se o utilizador selecionar "Sim" e preencher uma data válida, o sistema deve aceitar a transação e permitir o avanço na validação do motor de regras.
- 
## REQ-003 — Inconsistência DR (Given/When/Then)
- **Given** que o utilizador selecionou "DR = Não".
- **When** o utilizador introduz qualquer data no campo de teste de DR.
- **Then** o sistema altera o estado da transação para "Inconsistent" e bloqueia a finalização até a contradição ser corrigida.
- **AC-1** Se o utilizador selecionar a opção "Não" no campo "Disaster Recovery (DR)", o sistema deve desativar (disabled) ou ocultar o campo "Data do Último Teste" para evitar preenchimento acidental.
- **AC-2** Se o utilizador mudar a seleção de "Sim" para "Não", o sistema deve limpar/apagar automaticamente qualquer data que já estivesse preenchida no campo de teste.
- **AC-3** Se for injetada uma submissão onde o DR é "Não" mas existe uma data de teste preenchida (ex: falha de frontend ou via API), o sistema deve rejeitar a transição e marcar o ativo como "Inconsistent".

## REQ-004 — Validação de URL de Dashboard
- **AC-1:** O campo de URL deve rejeitar ativamente strings que não comecem por `https://`.
- **AC-2:** A submissão falha se o URL apresentar erro de sintaxe padrão de domínio (Regex falhada).

## REQ-005 — Caducidade de Evidências (Variante 4)
- **AC-1:** O sistema deve extrair a data dos metadados do ficheiro (ou do input) e comparar com o relógio do servidor `Date.now()`.
- **AC-2:** Se a diferença for estritamente superior a 365 dias, o sistema deve abortar o upload e exibir a notificação "Evidência Expirada".

## REQ-006 — Identificação de Owner em Integrações
- **AC-1:** O campo de identificação do Owner da integração deve validar o formato de um e-mail corporativo válido (ex: `@empresa.com`).
- **AC-2:** O sistema deve rejeitar a atribuição e exibir a mensagem "Utilizador inativo ou não encontrado no diretório" caso o e-mail ou ID inserido não exista na base de dados central (Active Directory).
- **AC-3:** Ao digitar os primeiros 3 caracteres no campo de "Owner da Integração", o sistema deve consultar a API do diretório e apresentar uma lista pendente (dropdown) com no máximo 5 sugestões de utilizadores ativos correspondentes.

## REQ-007 — Unicidade de Hostname (Variante 4)
- **AC-1:** Ao perder o foco (*onBlur*) do campo 'Nome do Sistema', o sistema deve consultar a API de ativos via `GET`.
- **AC-2:** Se a API devolver o código "409 Conflict" (Duplicado), o botão de transição para "Ready" deve ser automaticamente desativado.

## REQ-008 — Gestão de Estados (Draft) (Given/When/Then)
- **Given** que o formulário tem campos obrigatórios em falta ou falha em validações cruzadas.
- **When** o utilizador clica em "Guardar Rascunho".
- **Then** o sistema grava os dados parcialmente na tabela e atribui a *flag* de estado `is_draft=True`.
- **AC-1** Ao clicar no botão "Guardar Rascunho", o sistema deve obrigatoriamente ignorar todas as validações de campos obrigatórios e regras de inconsistência lógica.
- **AC-2** Os dados preenchidos no formulário devem ser guardados com sucesso no armazenamento local/base de dados e o estado da transação deve ser classificado como "Draft".

## REQ-009 — Transição para "Ready to Proceed"
- **AC-1:** A transição de estado na base de dados para "Ready" só ocorre se o payload do motor de regras retornar 0 erros lógicos.
- **AC-2:** Ao clicar no botão "Submeter Final", o sistema deve obrigatoriamente forçar a reexecução de todo o motor de regras (UC-04), não assumindo como válidos quaisquer dados previamente guardados no estado "Draft".
- **AC-3:* Se o motor de regras retornar 1 ou mais erros (ex: inconsistência ou dados em falta), a transição para "Ready" deve ser abortada, o ativo deve manter o estado "Draft" ou "Incompleto" na base de dados, e os erros devem ser sinalizados na interface.

## NFR-001 — Log de Auditoria
- **AC-1:** Qualquer alteração (update) aos campos "Nome", "Owner" ou "Disaster Recovery" num ativo já existente gera um registo em tabela *append-only*.
- **AC-2:** Alterações efetuadas a campos não críticos (ex: Observações) devem ser guardadas com sucesso na base de dados sem gerar qualquer nova entrada na tabela de auditoria append-only. (Garante que não enchem a base de dados de logs desnecessários).

## NFR-002 — Performance (Variante 4)
- **AC-1:** O processamento interno das regras lógicas REQ-002 e REQ-003 deve ser executado no percentil 95 (P95) abaixo de 500ms.
- **AC-2** A interface de utilizador não deve bloquear de forma silenciosa. Se a execução assíncrona do motor de regras demorar mais de 200ms, o sistema deve desativar o botão de submissão e apresentar um indicador de carregamento (loading spinner) contínuo até à receção do resultado final. (Garante que o utilizador não clica múltiplas vezes por impaciência).

## NFR-004 — Qualidade de Dados Garantida (Variante 4)
- **AC-1:** Tentativas de chamadas diretas (via Postman/cURL) à API para criar ativos no estado "Ready" com dados inconsistentes devem ser rejeitadas pelo backend.
- **AC-2:** O formulário de Intake e o respetivo motor de regras devem operar com uma taxa de disponibilidade de 99.9% durante o horário de expediente comercial.
