# Atribuição da Variante AMS

* *Variante:* 4 — Data Quality & Consistency
* *Persona Principal:* Data Steward / Quality Manager (Gestor de Qualidade de Dados)
* *Restrição Chave:* Validação cruzada e consistência de dados (Cross-field validation).
* *Foco:* Garantir que não entra "lixo" no sistema. Se um dado depende de outro, ambos têm de bater certo.

## Requisitos Específicos da Variante
1. *Validações Cruzadas:* Regras condicionais (ex: "Se X, então Y é obrigatório").
2. *Estados de Incompletude:* O sistema deve saber lidar explicitamente com estados de "Rascunho" vs "Inválido".
3. *Testes Parametrizados:* Vamos usar PyTest para injetar múltiplos cenários de dados no mesmo teste.