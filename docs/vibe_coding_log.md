# Vibe Coding Log — Lab 8

## Tool used

- Codex / Lovable / Other: **Lovable** (AI pair-programmer, geração guiada por prompt dentro do editor web com preview em tempo real).
- Environment/stack: **React 18 + TypeScript 5 + Vite 5 + Tailwind CSS v3 + shadcn/ui**. Formulários com `react-hook-form` + `zod` + `@hookform/resolvers/zod`. Notificações com `sonner`. Datas com `date-fns`. Persistência apenas em **LocalStorage** (sem backend, sem login — conforme guardrails académicos).

---

## Iteration 1

**Prompt (summary or paste):**

- Pedido para agir como Senior Frontend Developer e construir um protótipo Single Page de um **Asset Intake Form** para o ator *Transition Lead*. Guardrails explícitos: **sem backend, sem base de dados real, sem ecrãs de login**; armazenamento apenas em estado/LocalStorage.
- Requisitos funcionais chave:
  - REQ-001: Nome do Sistema, Owner (email) e Modelo de Suporte obrigatórios.
  - REQ-002/003: Radio "Tem DR? Sim/Não". Se Sim → revelar e exigir "Data do último teste DR". Se passar de Sim → Não, limpar o campo.
  - REQ-004: URL do Dashboard só aceite se começar por `https://`.
  - REQ-005: Data da Evidência com mais de 365 dias → erro "Evidência Caducada" e bloqueio de submissão.
  - REQ-006: Owner tem de ser email válido.
  - REQ-007: Se Nome do Sistema for `PROD-DB` ou `CORE-ERP` → "Ativo já existe na base de dados" (simulação de duplicados).
  - REQ-008: "Guardar Rascunho" **ignora** validações e persiste em LocalStorage, estado → `Draft`.
  - REQ-009: "Submeter Final" corre todas as regras; 0 erros → estado `Ready to Proceed`; ≥1 erro → destaca campos a vermelho e bloqueia.
  - NFR-001: Log de auditoria visual no fundo do ecrã com Data/Hora, Ação e Novo Estado.

**Generated output (what appeared):**

- Plano `.lovable/plan.md` com layout ASCII, tabela de regras e ficheiros a criar.
- Componentes novos:
  - `src/lib/asset-intake.ts` — schema `zod` com `.superRefine` para regras cross-field (DR, duplicados, 365 dias), tipos partilhados, helpers de LocalStorage (`loadDraft`, `saveDraft`, `loadAudit`, `saveAudit`) e `formatTimestamp`.
  - `src/components/AssetIntakeForm.tsx` — formulário completo em shadcn/ui (`Form`, `Input`, `Select`, `RadioGroup`, `Popover`+`Calendar`), com dois handlers: `handleSaveDraft` (bypass) e `form.handleSubmit(onSubmitFinal, onSubmitInvalid)` (gatekeeper).
  - `src/components/StatusBadge.tsx` — badge `Incomplete` / `Draft` / `Ready to Proceed`.
  - `src/components/AuditLog.tsx` — tabela de auditoria.
- `src/pages/Index.tsx` atualizada para hospedar o formulário.

**Kept (accepted):**

- Toda a arquitetura proposta: schema `zod` central, separação em 4 componentes, uso de `react-hook-form` com `zodResolver`, `useEffect` a ouvir `watch("hasDR")` para o reset do REQ-003, persistência de draft **e** do audit log em LocalStorage.
- Comparação de duplicados **case-insensitive** via `.trim().toUpperCase()` antes de comparar com `["PROD-DB", "CORE-ERP"]`.
- Botão "Guardar Rascunho" com `variant="outline"` e "Submeter Final" com ícone `ShieldCheck`.
- `toast` de sucesso/erro via `sonner`.

**Rejected (feature drift / out of scope):**

- Não foram adicionados ecrãs de login, rotas extra nem integração com Supabase, apesar de o prompt inicial mencionar vagamente "base de dados" (contexto da frase de duplicados). A IA respeitou o guardrail e manteve tudo in-memory/LocalStorage.
- Upload real de ficheiros de evidência foi deliberadamente descartado — o campo "Evidência" é apenas uma data, como indicado no plano ("Sem upload real de ficheiros").

**Manual verification:**

- Happy path: Preenchi Nome=`HR-PORTAL`, Owner=`ana@empresa.com`, Tier=`Tier 2`, URL=`https://dash.empresa.com`, Data da Evidência = hoje, DR=`Não`. Cliquei "Submeter Final" → toast verde, badge passou a **Ready to Proceed** e apareceu linha no Log de Auditoria com `Submeter Final / Ready to Proceed`.
- Alternative flow: Preenchi parcialmente (só Nome e Owner), cliquei "Guardar Rascunho" → toast neutro, badge → **Draft**, nova linha no log `Guardar Rascunho / Draft`. Recarreguei a página (F5) e os dados **voltaram a aparecer** no formulário, vindos do LocalStorage.
- Exception/error path: URL=`http://foo` (sem `https://`) + Data da Evidência a 400 dias atrás. Submeti Final → os dois campos ficaram com borda vermelha, mensagens inline "A URL tem de começar por https://" e "Evidência Caducada (mais de 365 dias)." A submissão **não progrediu** e o badge manteve-se em `Incomplete`.

**Changes made after generation (manual edits):**

- Nenhumas alterações manuais em código nesta iteração — o output estava funcionalmente correto. Apenas foi necessário interagir manualmente com a UI para verificar cada fluxo.

---

## Iteration 2

**Prompt (summary or paste):**

- "Melhora o aspeto visual dos erros: mensagens a **vermelho vivo** por baixo de cada campo quando falha a submissão final."
- "Valida REQ-007: confirmar que `PROD-DB` / `CORE-ERP` em Nome do Sistema dispara erro de duplicado e bloqueia submissão."
- "Transforma o Log de Auditoria numa **tabela elegante com fundo cinzento claro** no fim da página (colunas Data/Hora, Ação, Estado). Continua sem backend/login."

**Generated output:**

- Atualização do componente base `src/components/ui/form.tsx`:
  - `FormMessage` passou a ter ícone de alerta SVG inline + `font-semibold` + `flex items-start gap-1.5` para alinhamento limpo. Cor mantida em `text-destructive` (token semântico).
- Atualização em `src/components/AssetIntakeForm.tsx`:
  - Helper `invalidClass` agora devolve `border-destructive border-2 bg-destructive/5 focus-visible:ring-destructive` em vez de apenas `border-destructive`, dando destaque visível sem quebrar o design system.
- Refactor completo de `src/components/AuditLog.tsx`:
  - Removido o wrapper `Card` genérico e substituído por `<section>` com `rounded-lg border bg-muted/50 p-5 shadow-sm` (fundo cinzento claro via token `muted`).
  - Adicionado cabeçalho com ícone, subtítulo explicativo e **contador de registos** à direita ("3 registos").
  - Tabela interna passou a ter `bg-background`, cabeçalho sticky em `bg-muted/80 backdrop-blur`, timestamp em `font-mono text-xs text-muted-foreground`.
  - Estado vazio com `border-dashed` e cópia amigável em PT.

**Kept:**

- Todas as três alterações visuais. O uso de tokens semânticos (`destructive`, `muted`, `background`) mantém compatibilidade com dark mode.
- Confirmação de que o REQ-007 **já funcionava** desde a iteração 1 (lógica no `.superRefine` do `assetIntakeSchema`) — não foi preciso tocar na regra, só verificar.

**Rejected:**

- Tentação de usar classes Tailwind cruas tipo `text-red-600` / `bg-gray-100` — rejeitado em favor dos tokens `text-destructive` e `bg-muted/50`, conforme as regras do design system do projeto (`index.css`/`tailwind.config.ts`).
- Não foi adicionado som, animação shake nem modal de erro — mantivemos o padrão shadcn de erros inline, mais sóbrio e académico.

**Manual verification:**

- Happy path: Mesmo fluxo da Iteração 1 continua verde — nenhum regression. Log de auditoria agora aparece numa caixa cinzenta clara bem diferenciada do cartão do formulário, com contador "1 registo" depois da submissão.
- Alternative flow: Escrevi exatamente `PROD-DB` em Nome do Sistema, restante preenchido corretamente, e cliquei "Guardar Rascunho" → gravou como Draft **sem** bloquear (REQ-008: bypass de validações confirmado). Depois cliquei "Submeter Final" → erro "Este ativo já existe na base de dados." apareceu em vermelho com ícone, input com borda vermelha dupla e fundo rosa muito claro. Badge permaneceu `Draft`.
- Exception/error path: Testei também com `core-erp` (minúsculas) — REQ-007 disparou na mesma graças ao `.toUpperCase()` do schema, o que confirma a regra case-insensitive. Campos vazios (Nome, Owner, Tier, DR) após clique em Submeter → 4 mensagens vermelhas com ícone alinhadas por baixo dos respetivos inputs, todos com o novo destaque visual, e o banner de resumo "4 erros detetados" no topo do cartão. Toast vermelho de erro "Não é possível submeter" apareceu em baixo.

**Changes made after generation:**

- Nenhum ajuste manual de código — só verificação interativa na preview. O dev-server recompilou limpo, sem erros de tipo.

---

## Notes (lessons learned)

- **Ambiguidade de requisitos que causou problemas:** O enunciado dizia "base de dados de duplicados" no REQ-007, o que podia ser mal-interpretado como "ligar a uma BD real". Sem o guardrail explícito ("não criar backend"), a IA poderia ter tentado ativar Lovable Cloud. Lição: palavras como "base de dados" em descrições de domínio precisam de ser desambiguadas como *simulação*.
- **Constraints em falta inicialmente:** Não foi definido se a comparação de duplicados deveria ser *case-sensitive* ou não, nem se o trim de espaços era esperado. A IA decidiu por `.trim().toUpperCase()` — razoável, mas deveria ter sido especificado. Também não ficou claro o que fazer com o draft depois de uma submissão final bem-sucedida (atualmente fica lá gravado).
- **Formato de erros:** O REQ-009 pediu "campos a vermelho" mas não especificou intensidade/estilo — por isso a primeira iteração usou apenas `border-destructive` simples, o que levou à Iteração 2 para reforçar contraste (borda dupla + fundo destrutivo leve + ícone).
- **O que mudaria nos requisitos da próxima vez:**
  1. Especificar explicitamente o comportamento *case-sensitivity* das validações de duplicados.
  2. Incluir um mini-guia de estilo dos estados de erro (ex.: "borda 2px destructive, fundo `destructive/5`, ícone de alerta") em vez de deixar ao critério do gerador.
  3. Definir o que acontece ao draft após `Ready to Proceed` (limpar? manter? arquivar?).
  4. Declarar um cap explícito do audit log (ex.: últimas 200 entradas — que foi a decisão implícita feita pela IA no `slice(0, 200)`).
  5. Indicar o idioma das mensagens (a IA acertou em PT porque o prompt estava em PT, mas convém torná-lo requisito formal).
