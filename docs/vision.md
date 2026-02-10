# Visão do Produto (Slice: Intake & Discovery)

O módulo de Intake & Discovery do AMS visa automatizar a entrada e validação inicial de ativos de hardware na organização. O objetivo é garantir que nenhum equipamento entra no inventário sem passar por um processo rigoroso de verificação de dados obrigatórios e deteção de duplicados, reduzindo erros humanos e inconsistências na base de dados central.

## 3 Objetivos Principais
1.  *Validação de Dados:* Garantir que todos os campos obrigatórios (Número de Série, Modelo, Fabricante) estão preenchidos e no formato correto antes da gravação.
2.  *Deteção de Duplicados:* Impedir a criação de registos de ativos que já existem no sistema através da verificação do número de série.
3.  *Auditoria de Criação:* Registar automaticamente a data, hora e utilizador responsável pela criação de cada novo registo de ativo.

## 3 Não-Objetivos (Out of Scope)
1.  *Gestão de Ciclo de Vida:* Não vamos tratar do abate, reparação ou atribuição do ativo a funcionários nesta fase.
2.  *Integração com Hardware:* Não haverá leitura direta de códigos de barras ou RFID; a entrada de dados será via API/Interface simulada.
3.  *Autenticação Avançada:* Não vamos implementar sistema de login complexo (SSO ou OAuth); assumimos que o utilizador já está autenticado.