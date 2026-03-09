# Diagrama de Casos de Uso — Lab 5

## Fronteira do Sistema (System Boundary)
- **Nome do Sistema:** AMS Intake & Data Quality Platform
- **Slice Coberta:** Intake & Discovery (Foco: Data Steward & Validação)

## Atores (3)
- **A1: End User (Utilizador Final)**
  - *Papel:* Responsável por iniciar o processo de intake e fornecer os dados brutos e evidências.
- **A2: Data Steward (Gestor de Dados)**
  - *Papel:* (Variante 4) Responsável por monitorizar a qualidade, resolver inconsistências complexas e auditar o processo.
- **A3: Asset Database (Sistema Externo)**
  - *Papel:* Sistema legado que fornece a "versão da verdade" para verificar duplicados (Serial Numbers/Hostnames).

## Casos de Uso (6)
- **UC-01:** Submeter Novo Ativo
- **UC-02:** Gerir Rascunhos (Drafts)
- **UC-03:** Carregar Evidência (PDF)
- **UC-04:** Validar Regras de Consistência (Backend - Variante 4)
- **UC-05:** Resolver Inconsistências de Dados
- **UC-06:** Exportar Logs de Auditoria

## Ficheiro do Diagrama
- Caminho da Imagem: `docs/diagrams/use_case_diagram.png`
- Caminho do Código: `docs/diagrams/use_case_diagram.puml`