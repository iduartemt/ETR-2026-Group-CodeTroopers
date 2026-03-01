# Visão do Produto (Slice: Intake & Discovery)

O módulo de Intake & Discovery do AMS visa automatizar a entrada e validação inicial de ativos de hardware na organização. O objetivo é garantir que nenhum equipamento entra no inventário sem passar por um processo rigoroso de verificação de qualidade (Data Quality), focando-se em regras de consistência entre campos para reduzir erros humanos e dados incompletos.

## 3 Objetivos Principais
1.  **Validação e Consistência Cruzada (Variant 4):** Implementar regras de dependência complexas entre campos. Por exemplo, se o campo "Disaster Recovery" for marcado como "Sim", o campo "Data do Último Teste" torna-se obrigatório e deve ser validado.
2.  **Deteção de Duplicados:** Impedir a criação de registos de ativos que já existem no sistema através da verificação do número de série e fabricante.
3.  **Auditoria de Criação:** Registar automaticamente a data, hora e utilizador responsável pela criação de cada novo registo, permitindo rastrear a origem de dados incorretos.

## 3 Não-Objetivos (Out of Scope)
1.  **Gestão de Ciclo de Vida:** Não vamos tratar do abate, reparação ou atribuição do ativo a funcionários nesta fase.
2.  **Integração com Hardware:** Não haverá leitura direta de códigos de barras ou RFID; a entrada de dados será via API/Interface simulada.
3.  **Autenticação Avançada:** Não vamos implementar sistema de login complexo (SSO ou OAuth); assumimos que o utilizador já está autenticado.
