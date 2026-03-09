# Casos de Uso — Lab 5 (CodeTroopers)

**Sistema:** AMS Intake & Data Quality Platform
**Variante:** 4 — Data Quality & Consistency

---

## UC-01 — Submeter Novo Ativo
- **Ator Principal:** End User (Utilizador Final)
- **Atores Secundários:** Asset Database (Sistema Externo), Data Steward.
- **Objetivo:** Registar um novo ativo de hardware no sistema, garantindo que todos os dados submetidos estão limpos, completos e validados.
- **Pré-condições:**
  1. O utilizador está autenticado no sistema.
  2. O formulário de Intake está aberto.
- **Gatilho (Trigger):** O utilizador clica no botão "Submeter Final".
- **Pós-condições (Sucesso):** O registo é gravado na Base de Dados com estado "Ready"; Um ID único é gerado; O Data Steward é notificado.
- **Pós-condições (Falha):** O registo não é gravado (ou permanece em "Draft"); Mensagens de erro são exibidas e nenhuma alteração crítica é persistida.
- **Requisitos Relacionados:** REQ-001, REQ-002, REQ-003, REQ-005, REQ-006, NFR-002.

### Fluxo Principal (Caminho Feliz)
1. O **Ator** preenche os campos de identificação do ativo (Nome, Owner, Tipo).
2. O **Ator** carrega o ficheiro de evidência (PDF) de compra (inclui UC-03).
3. O **Ator** clica no botão "Submeter".
4. O **Sistema** executa o motor de validação de consistência (inclui UC-04).
5. O **Sistema** verifica na "Asset Database" externa se o Serial Number/Hostname é único (REQ-005).
6. O **Sistema** grava o registo como "Ready".
7. O **Sistema** apresenta uma mensagem de sucesso e o ID do novo ativo.

### Fluxos Alternativos
**A1. Guardar como Rascunho (Draft)**
1. No passo 3, o **Ator** clica em "Guardar Rascunho".
2. O **Sistema** ignora as validações de campos obrigatórios (REQ-006).
3. O **Sistema** grava o registo com a flag `is_draft=True`.
4. O caso de uso termina com sucesso (estado parcial).

### Exceções / Erros
**E1. Falha na Validação Cruzada (Foco Variante 4)**
1. No passo 4, o **Sistema** deteta uma inconsistência (ex: "DR=Sim" mas "Data de Teste" vazia - REQ-002).
2. O **Sistema** aborta a transação de gravação.
3. O **Sistema** destaca os campos inválidos a vermelho e exibe a mensagem de erro específica.
4. O **Sistema** regista a tentativa falhada no log de auditoria.
5. O fluxo retorna ao passo 1 para correção pelo utilizador.

**E2. Duplicação de Ativo**
1. No passo 5, a "Asset Database" retorna que o ativo já existe.
2. O **Sistema** exibe erro bloqueante: "Ativo já registado na base de dados".
3. O fluxo termina em falha (o utilizador deve contactar o suporte).

---

## UC-04 — Validar Regras de Consistência (Backend)
- **Ator Principal:** Sistema (Automático / Motor de Regras).
- **Atores Secundários:** N/A.
- **Objetivo:** Garantir a integridade referencial, lógica e temporal dos dados antes de qualquer persistência oficial. Este é o núcleo da Variante "Data Steward".
- **Pré-condições:** O sistema recebeu um payload de dados (JSON) vindo do interface de submissão.
- **Gatilho (Trigger):** Invocado automaticamente pelo UC-01 ("Submeter") ou manualmente por um Data Steward numa auditoria.
- **Pós-condições (Sucesso):** Retorna status "OK" e a lista de dados sanitizados.
- **Pós-condições (Falha):** Retorna status "ERRO" e uma lista estruturada de violações de regras.
- **Requisitos Relacionados:** REQ-001, REQ-002, REQ-003, REQ-004, NFR-004.

### Fluxo Principal (Caminho Feliz)
1. O **Sistema** valida os tipos de dados básicos (Data, Inteiro, String) e limites de caracteres.
2. O **Sistema** verifica o preenchimento de todos os campos marcados como obrigatórios (REQ-001).
3. O **Sistema** verifica as dependências condicionais (Lógica "Se X então Y" - ex: Se Tipo="Servidor" então "Rack" é obrigatório).
4. O **Sistema** valida a consistência lógica de datas (ex: Data Fim > Data Início).
5. O **Sistema** verifica os metadados da evidência (Data do ficheiro < 12 meses - REQ-004).
6. O **Sistema** retorna o resultado "Válido" para o processo chamador.

### Fluxos Alternativos
*N/A (Este é um processo de sistema de "caixa negra").*

### Exceções / Erros
**E1. Violação de Regra de Negócio Crítica**
1. Durante a validação (passos 2-5), uma regra é quebrada (ex: Inconsistência de DR - REQ-003).
2. O **Sistema** adiciona o erro a uma lista acumulativa de falhas (não para na primeira falha).
3. O **Sistema** termina a validação e retorna o objeto de erro completo (ex: `{ "valid": false, "errors": ["Campo DR inválido", "Data expirada"] }`).