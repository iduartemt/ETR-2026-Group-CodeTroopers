# Vibe Coding Log — Lab 8

## Tool used
- Lovable / Gemini
- Environment/stack: React, TypeScript, Tailwind CSS, Shadcn UI (in-memory state)

## Iteration 1
**Prompt (summary or paste):**
- Foi colado o "Generation Prompt Pack" inicial que definia a Slice A, focando nos campos obrigatórios (REQ-001), lógicas de Disaster Recovery (REQ-002 e REQ-003) e estados de submissão (REQ-006).

**Generated output (what appeared):**
- A ferramenta gerou o esqueleto da página principal (`Index.tsx`) com um design limpo e moderno usando Shadcn UI.
- Criou os estados básicos (`data`, `errors`) e a função `validate`.
- Adicionou os botões de "Guardar Rascunho" e "Submeter Final".

**Kept (accepted):**
- A interface gráfica (UI) base, incluindo os componentes `<Card>`, `<Select>` e o `<Popover>` para as datas.
- A mecânica de validação que separa `liveErrors` de `displayedErrors` (mostrando erros ao fazer *blur* ou após submissão).
- A lógica de transição de estado que permite "Guardar Rascunho" fazendo bypass aos erros.

**Rejected (feature drift / out of scope):**
- A IA tentou criar múltiplas páginas com o React Router (ex: uma lista de ativos). Removido para focar estritamente na Slice A (apenas o formulário).
- A IA inicialmente fez uma validação de DR muito simples e esqueceu-se de validar a string "N/A" nos campos numéricos de RTO/RPO.

**Manual verification:**
- Happy path: Parcialmente funcional, mas faltavam regras complexas de datas.
- Alternative flow (Draft): Sucesso. Clicar em "Guardar Rascunho" grava os dados e limpa os erros, mostrando uma *badge* "Rascunho".
- Exception/error path: Sucesso base. Campos vazios foram bloqueados no submit.

**Changes made after generation (manual edits):**
- Limpeza de imports não utilizados que a IA gerou ao tentar criar o layout completo da dashboard.

---

## Iteration 2
**Prompt (summary or paste):**
- "Refine the validation logic in the `validate` function. You missed the AC-Extra for REQ-003: reject the string 'N/A' in the RTO/RPO fields using a regex. Also, for REQ-004, you need to calculate if the 'creationDate' of the attached evidence is older than 365 days using standard timestamp math."

**Generated output:**
- A ferramenta atualizou o `Index.tsx`.
- Introduziu a constante `NA_REGEX = /^\s*n\.?\/?a\.?\s*$/i;`.
- Adicionou o cálculo matemático `ageDays = (Date.now() - data.evidence.creationDate.getTime()) / MS_PER_DAY` para verificar a caducidade.

**Kept:**
- Toda a lógica atualizada de validação cruzada foi mantida. Funciona de forma exata e bloqueia eficazmente as tentativas de inserir dados lixo.

**Rejected:**
- N/A. A IA focou-se apenas na função `validate` e não inventou funcionalidades extra nesta iteração.

**Manual verification:**
- Happy path: Preencher tudo, DR=Sim com data de hoje, Evidência com data de ontem -> Estado "Pronto".
- Alternative flow: Guardar rascunho com o nome preenchido e resto vazio -> Estado "Rascunho" guardado com sucesso.
- Exception/error path: 
    - Escolher DR="Não" mas colocar data de teste -> Erro disparado com sucesso.
    - Escrever " n/a " no campo RTO -> Erro "Valor 'N/A' não é permitido" disparado com sucesso.
    - Escolher data de evidência em 2023 -> Erro "Evidência expirada (>1 ano)" disparado com sucesso.

**Changes made after generation:**
- Nenhuma. O código ficou final e pronto a demonstrar a Variante 4.

---

## Notes (lessons learned)
- **What requirement ambiguity caused problems?** A indicação inicial de RTO/RPO sem definir explicitamente que o input poderia ser texto livre levou a IA a assumir campos tipo `<input type="number">`, o que dificultou a validação de "N/A" na primeira iteração. Foi preciso clarificar.
- **What constraints were missing initially?** Faltou explicar à IA como extrair/simular a data da evidência, sendo necessário pedir um *Date Picker* específico para a "metadata" da evidência no segundo prompt.
- **What would you change in your requirements next?** Detalharia melhor o modelo de dados esperado para os uploads de ficheiros em requisitos futuros, para evitar que a equipa perca tempo a discutir como obter a "data de criação" do ficheiro no Frontend.
