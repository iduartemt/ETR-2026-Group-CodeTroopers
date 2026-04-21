# Definition of Done (DoD) — Lab 7

## DoD — Requirement (REQ-###)
A requirement is considered "Done" when:
1. REQ-### has a stable ID, clear title, and type explicitly defined (FR/NFR).
2. Stakeholder (Requisitante) and Author are clearly recorded.
3. The description is unambiguous, testable, and avoids implementation leakage (focuses on the "What" and "Why", not the "How").
4. Acceptance criteria exist (min. 2–4), are verifiable, and cover both success and error paths.
5. Variant impact is stated (Yes/No) and clearly aligns with the Data Quality scope (Variante 4).
6. Links and dependencies to other requirements are identified (e.g., Predecessors/Successors).
7. Conflicts/duplicates have been resolved and validated through a team role-play session.
8. Validation method is defined (e.g., Review / Demo / Test / Measurement).

## DoD — User Story (US-###)
A user story is considered "Done" when:
1. The story is written in the correct format (As a... I want to... So that...) providing clear business value.
2. Acceptance criteria are agreed upon, BDD-friendly (Given/When/Then where applicable), and fully verifiable.
3. Implementation meets all AC without breaking existing functionality.
4. Appropriate tests exist (Unit tests for validation logic, Integration tests for APIs) and pass successfully.
5. No critical or blocking defects remain in the code branch.
6. System architecture and API documentation are updated (if changes were made).
7. Code has passed Peer Review (Pull Request approved by at least 1 other developer).
8. The Product Owner / Data Steward accepts the outcome via a successful Demo validation.