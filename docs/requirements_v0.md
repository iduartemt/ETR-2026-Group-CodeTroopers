# Requirements v0 — Lab 2 (AMS)

## 1. Structured Requirements

| Item | Requirement | Type | Stakeholder | Priority | Variant? |
|---:|---|---|---|---|---|
| 1 | The system shall prevent the submission of an Intake form if mandatory fields (System Name, Owner, Support Model) are empty. | FR | Data Steward | H | Yes |
| 2 | The system shall require a valid "Last DR Test Date" to be filled whenever the "Disaster Recovery" field is set to "Yes". | FR | Data Steward | H | Yes |
| 3 | The system shall flag an Intake submission as "Inconsistent" if the "Disaster Recovery" field is set to "No" but a test date is provided. | FR | Data Steward | H | Yes |
| 4 | The system shall require a valid URL linking to the monitoring dashboard to validate the observability evidence. | FR | Transition Lead | M | No |
| 5 | The system shall automatically reject DR test date evidence if the date provided is older than 12 months from the current date. | FR | Data Steward | H | Yes |
| 6 | The system shall require an explicitly named Owner (User ID or Email) for every integration declared in the form. | FR | Transition Lead | M | No |
| 7 | The system shall reject the creation of a new system profile if the "System Name" matches an already existing active system in the database. | FR | Data Steward | H | Yes |
| 8 | The system shall allow users to save an Intake form in a "Draft" state without triggering mandatory cross-field validations. | FR | Transition Lead | M | Yes |
| 9 | The system shall transition the Intake to a "Ready to Proceed" state only when all validation rules and consistency checks pass successfully. | FR | Data Steward | H | Yes |
| 10 | The system shall maintain an audit trail for critical field changes, recording the User ID, timestamp, and the previous/new values. | NFR | Auditor | M | No |

*(Legenda: FR = Functional Requirement, NFR = Non-Functional Requirement, H = High, M = Medium, L = Low)*

---

## 2. Ambiguity Rewrite (min. 5)

**1) Original:** "The system must validate data properly." *(Ambíguo: O que é properly?)*
* **Rewritten:** "The system shall execute cross-field validation rules upon submission and return a specific error message preventing submission if 'DR=No' and 'DR Date' is filled." *(Foco na Variante 4)*

**2) Original:** "The system should show if data is bad." *(Ambíguo: Como mostra? O que é bad?)*
* **Rewritten:** "The system shall explicitly mark an intake record with an 'Invalid' status flag when mandatory fields are missing or cross-field inconsistencies are detected." *(Foco na Variante 4)*

**3) Original:** "The system must be fast." *(Ambíguo: Quão rápido?)*
* **Rewritten:** "The system shall process intake form validations and return feedback (success or error messages) to the user in under 2 seconds for 95% of submissions."

**4) Original:** "Evidence must be recent." *(Ambíguo: O que é recente?)*
* **Rewritten:** "The system shall reject operational evidence attachments or links if the associated 'evidence date' provided is older than 6 months."

**5) Original:** "The system should be secure." *(Ambíguo: Seguro como?)*
* **Rewritten:** "The system shall restrict the approval of the 'Ready to Proceed' state exclusively to users authenticated with the 'Data Steward' or 'Transition Lead' role."
