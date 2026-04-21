# Vibe Coding Log — Lab 8

## Tool used
- **Codex / Lovable / Other:** Lovable / Bolt (AI Web Builder) / Gemini
- **Environment/stack:** React (Vite), Tailwind CSS, TypeScript, shadcn/ui

## Iteration 1
**Prompt (summary or paste):**
- Inserido o "Generation Prompt Pack" completo, focado na "Slice A: Asset Intake Form".
- Exigida UI simples com campos específicos (Texto, Dropdown, Radio, Datas) e botões "Guardar Rascunho" e "Submeter Final".
- Regras de negócio rigorosas passadas (REQ-001 a REQ-006): Validações *cross-field* (DR condicional), bloqueio de "N/A" para RTO/RPO em Tiers 1/2, e verificação de caducidade de evidências (> 365 dias).
- Guardrails definidos explícitamente: sem backend, sem auth, sem dashboards, apenas estado em memória.

**Generated output (what appeared):**
- Uma *Single Page Application* com um cartão central contendo o formulário "Asset Intake Form".
- A IA implementou um sistema de estado na memória (`{ status: 'empty' | 'draft' | 'ready', data: {...}, errors: {...} }`).
- Componentes visuais importados do `shadcn/ui` (Inputs, Select, Date Picker, Toasts).
- A IA gerou a lógica de validação *on-blur* e *on-change*, incluindo uma Regex específica `/^\s*n\.?\/?a\.?\s*$/i` para detetar e bloquear a string "N/A" nos campos de RTO/RPO.

**Kept (accepted):**
- Toda a UI gerada foi aceite. O painel de sumário de erros no topo após falha de submissão e o *badge* de estado ("Vazio", "Rascunho", "Pronto") foram excelentes adições de UX feitas pela IA que se alinham com os requisitos.
- A máquina de estados (Draft vs Final) comportou-se de acordo com o pedido.

**Rejected (feature drift / out of scope):**
- Nenhum *feature drift* detetado nesta iteração! A IA respeitou escrupulosamente a secção "Scope Guardrails" do prompt, não inventando logins, rotas extra nem backend.

**Manual verification:**
- [x] **Happy path:** Preenchidos todos os campos (Tier 1, DR=Sim com Data, ficheiro recente), clicado "Submeter Final" → Estado mudou para "Ready" e toast de sucesso ativado.
- [x] **Alternative flow:** Formulário deixado em branco, clicado "Guardar Rascunho" → Erros ignorados, estado mudou para "Draft" e toast ativado.
- [x] **Exception/error path:** Escolhido DR="Não" e preenchida "Data do Último Teste", ou inserido "N/A" no RTO/RPO (Tier 1) → Submissão bloqueada, sumário de erros exibido e *fields* marcados a vermelho.

**Changes made after generation (manual edits):**
- (Nenhuma alteração manual significativa; código executado localmente para validar a interface).
