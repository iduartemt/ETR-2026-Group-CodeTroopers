## Gaps / Observations

### 1. Use case without requirements
- **UC-06 (Exportar Logs):** Este caso de uso está mapeado apenas a Requisitos Não Funcionais (NFR). Revela a falta de um requisito funcional (REQ) que defina as permissões de exportação. 
  - *Candidato: REQ-008 (Exportação de Dados).*

### 2. Requirement without use cases
- **REQ-009 (Backup Automático):** (Exemplo) Este requisito está no documento V1 mas não é coberto por nenhum Caso de Uso, pois é uma tarefa de sistema em background.

### 3. Missing requirement candidates revealed by modeling
- **REQ-007 (Notificação de Erro Externo):** Identificado ao modelar o UC-01/E2. O sistema precisa de uma regra para notificar o utilizador quando a *Asset Database* está offline.
- **REQ-010 (Validação de Integridade de Ficheiros):** Identificado no UC-03. Falta um requisito que especifique a validação de formato e tamanho máximo para os PDFs de evidência.