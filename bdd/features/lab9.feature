Funcionalidade: Gatekeeper de Qualidade e Consistência de Dados (Variante 4)
  Como Data Steward (Gestor de Qualidade de Dados)
  Quero garantir que todos os dados do inventário são logicamente consistentes e únicos
  Para que a CMDB permaneça como uma "fonte da verdade" confiável.

  # Links de Requisitos: REQ-003, REQ-007, REQ-008

  Cenário: Prevenir informações contraditórias de Disaster Recovery
    Dado que o utilizador seleciona "Disaster Recovery = Não"
    E o utilizador tenta fornecer uma "Data do Último Teste"
    Quando o utilizador clica em "Submeter Final"
    Então o sistema deve bloquear a transição para o estado "Ready"
    E o estado do registo deve ser marcado como "Inconsistent"

  Cenário: Permitir progresso parcial através do modo Rascunho (Draft)
    Dado que o utilizador tem campos obrigatórios vazios (Nome ou Owner)
    Quando o utilizador seleciona "Guardar Rascunho"
    Então o sistema deve ignorar todas as verificações de consistência
    E guardar o registo com o estado "Draft"

  Cenário: Detetar nome de ativo duplicado através da Base de Dados de Ativos
    Dado que o hostname "CORE-ERP" já existe no sistema
    Quando o utilizador insere "CORE-ERP" no campo de nome do sistema
    Então o sistema deve exibir um erro "Ativo já existe na base de dados"
    E desativar o botão de submissão final