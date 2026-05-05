Feature: Data Quality and Consistency Gatekeeper (Variant 4)
  As a Data Steward
  I want to ensure all inventory data is logically sound and unique
  So that the CMDB remains a reliable source of truth.

  # REQ links: REQ-003, REQ-007, REQ-008

  Scenario: Prevent contradictory Disaster Recovery information
    Given the user selects "Disaster Recovery = Não"
    And the user attempts to provide a "Data do Último Teste"
    When the user clicks "Submeter Final"
    Then the system must block the transition to "Ready" status
    And the record state must be marked as "Inconsistent"

  Scenario: Allow partial progress via Draft mode
    Given the user has mandatory fields empty (Name or Owner)
    When the user selects "Guardar Rascunho"
    Then the system must bypass all consistency checks
    And save the record with the status "Draft"

  Scenario: Detect duplicate asset name via Asset Database
    Given the hostname "CORE-ERP" already exists in the system
    When the user enters "CORE-ERP" in the system name field
    Then the system must display an error "Ativo já existe na base de dados"
    And disable the final submission button