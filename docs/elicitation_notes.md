# Elicitation Notes — Lab 2 (AMS)

## Configuração da Entrevista
- Data: 2026-02-XX
- Equipa Cliente: Team X (no papel de AMS Transition Lead)
- DevTeam: Team <NOME_DA_VOSSA_EQUIPA>
- Slice discutido: Intake & Discovery (AMS)
- Variante: 4 — Data Quality & Consistency (Data Steward Persona)

---

## Contexto (AMS)

- Setor: Saúde (Healthcare)
- Tipo de solução: ERP + Plataforma de Analytics
- Modelo de suporte: L1/L2/L3 — 24/7 — Inglês e Espanhol
- Principais problemas nas transições:
  - Falta de documentação de monitorização
  - Informação de DR inconsistente
  - Listas de acessos desatualizadas
  - Integrações declaradas mas não documentadas
  - Evidência frequentemente inexistente ou desatualizada

---

## Perguntas & Respostas (mín. 10)

1. Q: Que informação é obrigatória durante o Intake?
   A: Nome do sistema, owner, modelo de suporte, estado de DR, integrações e monitorização.

2. [Evidence] Q: Que evidência comprova que existe Disaster Recovery?
   A: Um plano de DR documentado e a data do último teste realizado.

3. [Variant] Q: Se DR estiver marcado como "Sim", a data do último teste é obrigatória?
   A: Sim, e não deve ser superior a 12 meses.

4. [Variant] Q: O que acontece se DR estiver marcado como "Não", mas existir data de teste preenchida?
   A: Isso é inconsistente e deve ser sinalizado pelo sistema.

5. [Evidence] Q: Como verificamos que os dashboards de monitorização estão ativos?
   A: Através de um link funcional para o dashboard, validado pela equipa de Operações.

6. [Variant] Q: O sistema deve bloquear a submissão se existirem campos obrigatórios vazios?
   A: Sim, formulários incompletos não devem avançar.

7. Q: Quem é responsável por validar a informação submetida?
   A: O Transition Lead inicialmente e depois o Data Steward.

8. [Evidence] Q: Qual é a validade aceitável da evidência submetida?
   A: Evidência operacional não deve ter mais de 6 meses.

9. Q: O Intake pode ser guardado parcialmente?
   A: Sim, mas não deve ficar no estado “Ready to Proceed” até ser validado.

10. [Variant] Q: Informação contraditória (ex: suporte 24/7 mas janela limitada) deve ser permitida?
    A: Não, o sistema deve sinalizar a inconsistência e impedir aprovação.

11. Q: As integrações precisam de ter um owner identificado?
    A: Sim, cada integração deve ter um responsável nomeado.

12. [Evidence] Q: Quem é o dono oficial da lista de stakeholders?
    A: O Service Delivery Manager.

---

## Lista de Necessidades (mín. 15)

1. Precisamos recolher toda a informação obrigatória do sistema.
2. Precisamos validar que campos obrigatórios não estão vazios.
3. Precisamos exigir data de teste de DR quando DR = Sim.
4. Precisamos detetar inconsistências entre campos relacionados.
5. Precisamos validar evidência de monitorização.
6. Precisamos garantir que integrações têm owner definido.
7. Precisamos detetar informação contraditória no modelo de suporte.
8. Precisamos bloquear submissão se falharem regras de validação.
9. Precisamos marcar o Intake como inválido quando existirem inconsistências.
10. Precisamos garantir que a evidência não está desatualizada.
11. Precisamos impedir nomes de sistemas duplicados.
12. Precisamos registar quem altera campos críticos.
13. Precisamos validar que listas de acessos estão completas.
14. Precisamos identificar stakeholders obrigatórios em falta.
15. Precisamos diferenciar estados: Draft, Incomplete e Ready.

---

## Assunções (mín. 3)

- A1: Os stakeholders fornecem informação correta.
- A2: Testes de DR são realizados pelo menos uma vez por ano.
- A3: Evidência está armazenada num repositório acessível.
- A4: Existe definição clara de campos obrigatórios.

---

## Questões em Aberto (mín. 3)

- Q1: Qual é a idade máxima aceitável para evidência de teste de DR? [Variant]
- Q2: Inconsistências devem bloquear totalmente a submissão ou permitir apenas guardar como rascunho? [Variant]
- Q3: Quem define oficialmente os campos obrigatórios?
- Q4: O sistema deve detetar automaticamente duplicação de sistemas?

---

## Notas da Variante (obrigatório)

- Como a variante influenciou a elicitação?
  - Focámos fortemente em validações cruzadas entre campos.
  - Introduzimos regras do tipo “Se X então Y é obrigatório”.
  - Questionámos como lidar com informação contraditória.
  - Definimos explicitamente estados inválidos ou incompletos.
  - Reforçámos a importância da evidência e da sua validade temporal.
