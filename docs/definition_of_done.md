# Definition of Done (DoD) — Lab 7

## DoD — Requirement (REQ-### / NFR-###)
A requirement is considered "Done" when:
1. It has a stable ID (REQ-001 to 009 or NFR-001 to 006), clear title, and type explicitly defined (FR/NFR).
2. The primary Stakeholder (e.g., Data Steward, Transition Lead) and Author are clearly recorded.
3. The description is unambiguous, testable, and avoids implementation leakage (focuses on the "What" and "Why", not the "How").
4. Acceptance criteria exist (min. 2–4), are fully verifiable, and cover both success (happy) and error/exception paths (crucial for Data Quality).
5. **[Variant Focus]** Variant impact is stated (Yes/No). If 'Yes', the specific cross-field validation logic or data integrity rule must be clearly defined.
6. **[NFR Focus]** If it is a Non-Functional Requirement, it contains a quantifiable, measurable statement (e.g., "< 500ms", "100% compliance", "< 1s UI response").
7. Links and dependencies to other requirements are identified (e.g., REQ-009 depends on REQ-001 to REQ-007).
8. Conflicts/duplicates have been resolved and validated through a team role-play session.
9. Validation method is defined (e.g., Peer Review / Demo / Automated Test / Telemetry Measurement).

## DoD — User Story (US-###)
A user story is considered "Done" when:
1. The story is written in the correct format (*As a... I want to... So that...*) providing clear business value for the AMS Intake process.
2. Acceptance criteria are agreed upon, BDD-friendly (*Given/When/Then* where applicable), and explicitly mapped to the project requirements.
3. **[Variant Focus]** Implementation acts as a strict "Gatekeeper": it guarantees zero data inconsistencies, obsolete files, or duplicates can transition to the "Ready to Proceed" state.
4. Appropriate tests exist (Unit tests for validation logic, Integration tests for APIs) and pass successfully.
5. No critical or blocking defects remain in the code branch (specifically, no bypassed mandatory validations).
6. System architecture, traceability matrices (`traceability_uc_req.md`), and API documentation are updated (if changes were made).
7. Code has passed Peer Review (Pull Request approved and merged by at least 1 other developer).
8. The Product Owner / Data Steward accepts the outcome via a successful visual Demo validation.