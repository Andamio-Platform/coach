# Student Learning Targets (SLTs): Research Report

## 1. What Are Student Learning Targets?

In mainstream education, a **Student Learning Target** is a specific, measurable statement — written in student-friendly language — describing what a student is expected to know, do, or demonstrate by the end of a lesson, unit, or course. The key distinction from a *learning objective* (which is teacher-facing and often written in formal/technical language) is that a learning target is written **from the student's point of view**, often as an "I can..." statement.

> "Students can hit any target they can see that holds still for them." — Rick Stiggins

### Learning Objective vs. Learning Target

| | Learning Objective | Learning Target |
|---|---|---|
| **Audience** | Teacher-facing | Student-facing |
| **Language** | Formal, technical | Student-friendly, accessible |
| **Scope** | Broad standard or goal | Lesson-sized, specific |
| **Example** | "Students will identify reasons why communities are formed." | "I can explain reasons people form communities." |

Standards and objectives are the foundation; learning targets are the student-visible, lesson-sized breakdown of those standards.

---

## 2. Characteristics of Effective SLTs

The research literature converges on several criteria:

1. **Student-friendly language** — written from the learner's perspective, often as "I can..." statements
2. **Focused on learning, not tasks** — describes what the student will *learn*, not what activity they will *do*
3. **Specific and measurable** — narrow enough that mastery can be assessed
4. **Aligned to broader standards** — each SLT maps back to a standard or objective
5. **Integrated into instruction** — used at the start of a lesson, referenced throughout, and assessed at the end
6. **Ambitious but achievable** — challenging without being unreachable

### Types of Learning Targets

Researchers identify five kinds of learning targets:

| Type | Description | Example |
|---|---|---|
| **Knowledge** | Factual information, procedures, concepts | "I can list the three branches of government." |
| **Reasoning** | Thought processes: inference, analysis, evaluation | "I can compare and contrast two historical accounts." |
| **Skill** | Real-time demonstration or physical performance | "I can perform a layup in basketball." |
| **Product** | Creating an artifact that demonstrates learning | "I can write a research report with citations." |
| **Disposition** | Attitudes, habits of mind, values | "I can persist when solving difficult problems." |

---

## 3. Connection to Bloom's Taxonomy

Bloom's Taxonomy (revised, 2001) provides the cognitive framework most commonly used to write SLTs at the right level of rigor:

| Level | Action Verbs | Cognitive Demand |
|---|---|---|
| **Remember** | define, identify, recall, list, name | Lowest |
| **Understand** | explain, summarize, classify, describe, interpret | |
| **Apply** | use, solve, implement, demonstrate, compute | |
| **Analyze** | distinguish, compare, contrast, examine, organize | |
| **Evaluate** | judge, justify, critique, defend, assess | |
| **Create** | design, construct, develop, produce, propose | Highest |

The verb chosen for an "I can..." statement signals the cognitive level expected. "I can *list* the causes of the Civil War" (Remember) is fundamentally different from "I can *evaluate* competing explanations for the Civil War" (Evaluate).

---

## 4. SLTs and Formative Assessment

SLTs and formative assessment are tightly coupled:

- **Before the lesson**: The SLT is communicated so students know what they're aiming for.
- **During the lesson**: The SLT is referenced as an ongoing check — "Are we on track toward the target?"
- **After the lesson**: A formative assessment measures whether the target was hit.

Research shows that when students have clear learning targets, their rate of learning can roughly double (effect sizes of 0.31–0.47 reported by Marzano, Pickering, and Pollock).

### Success Criteria

Closely related to SLTs are **success criteria** — the specific evidence that demonstrates a target has been met. Best practice involves **co-constructing** success criteria with students rather than presenting them top-down. Success criteria answer: "How will I know I've met this target?"

---

## 5. SLTs in Competency-Based Education (CBE)

SLTs are the foundational unit of competency-based education, where:

- Students advance by demonstrating **mastery**, not by accumulating seat time
- Learning targets are **transparent** — students know exactly what they need to demonstrate
- Assessment is **ongoing** — multiple assessments measure the same targets
- Grades reflect **degree of mastery**, not completion of assignments
- Students typically demonstrate competence across 6–12 major learning targets per course

Research from the American Institutes for Research found that students' perceived clarity of learning targets was the factor most strongly associated with favorable changes in learning capacities. A meta-analysis of mastery learning found an average effect size of 0.59 — moderate to substantial improvement.

---

## 6. How Andamio Currently Uses SLTs

Based on the Andamio protocol documentation and glossary, SLTs in Andamio have specific technical characteristics that go beyond the general education definition:

### Andamio's Definition

> "An individual learning objective within a Course Module, formatted as an 'I can...' statement. Each SLT is content-addressed by its blake2b-256 hash, making it a unique, verifiable identifier. SLTs define what students should be able to demonstrate upon completion."

### Key Technical Properties

1. **Format**: "I can..." or "Learner can..." statements (e.g., "Learner can deploy a smart contract to preprod")
2. **Content-addressed**: Each SLT is hashed using blake2b-256 to produce a unique 64-character hex identifier
3. **On-chain**: SLT hashes are stored on the Cardano blockchain as part of course module data
4. **Prerequisite chains**: Modules (identified by SLT hash) can require completion of other modules as prerequisites
5. **One module = one SLT scope**: Each module represents a Student Learning Target and holds the criteria students must satisfy to earn credit
6. **Assessment**: Students submit evidence of completion; teachers review and accept or refuse

### SLTs in the Protocol Flow

```
Course → Module (identified by SLT hash) → Lesson(s) + Assignment
                                              ↓
                                    Student submits evidence
                                              ↓
                                    Teacher assesses submission
                                              ↓
                                    Credit earned (on-chain)
```

### What This Means

Andamio's SLTs serve a dual purpose:
- **Pedagogical**: They communicate learning expectations to students (the traditional education role)
- **Technical**: They act as unique content identifiers, prerequisite references, and on-chain records of achievement

---

## 7. Summary of Key Findings

| Dimension | General Education | Andamio Protocol |
|---|---|---|
| **Format** | "I can..." statements | "I can..." / "Learner can..." statements |
| **Scope** | Lesson-sized learning expectation | One per course module |
| **Assessment** | Formative + summative | Evidence submission → teacher review |
| **Identification** | Human-readable text | blake2b-256 hash (content-addressed) |
| **Tracking** | Gradebook / LMS | On-chain Cardano transactions |
| **Prerequisites** | Informal or course-level | Explicit hash-based prerequisite chains |
| **Mastery model** | Varies (CBE adopters use it) | Built into the protocol |
| **Verifiability** | Institutional records | Blockchain-verifiable credentials |

---

## Sources

- [Kentucky Dept. of Education — Learning Targets](https://www.education.ky.gov/school/stratclsgap/currandstand/Documents/Learning%20Targets.pdf)
- [Voyager Sopris Learning — The Power of Learning Targets](https://www.voyagersopris.com/vsl/blog/setting-the-stage-for-success-the-power-of-learning-targets)
- [EL Education — Crafting and Using Learning Targets](https://www.eleducation.org/core-practices/student-engaged-assessment/crafting-and-using-learning-targets/)
- [Edutopia — Making Learning Targets Clear to Students](https://www.edutopia.org/article/making-learning-targets-clear-students/)
- [Louisiana DOE — SLT Guidance and Templates](https://doe.louisiana.gov/docs/default-source/teaching/slt-guidance-and-templates.pdf)
- [ASCD — Learning Targets: Helping Students Aim for Understanding](https://files.ascd.org/pdfs/publications/books/Learning_Targets_Action_Tools.pdf)
- [Rhode Island DOE — Setting Targets in Student Learning Objectives](https://ride.ri.gov/sites/g/files/xkgbur806/files/Portals/0/Uploads/Documents/Teachers-and-Administrators-Excellent-Educators/Educator-Evaluation/Student-Learning-Objectives/Setting_Targets_in_Student_Learning_Objectives.pdf)
- [University of Arkansas — Using Bloom's Taxonomy](https://tips.uark.edu/using-blooms-taxonomy/)
- [Cult of Pedagogy — Competency-Based Learning](https://www.cultofpedagogy.com/competency-based-learning/)
- [Aurora Institute — CBE and Student Learning Objectives](https://aurora-institute.org/cw_post/two-sides-of-the-same-coin-competency-based-education-and-student-learning-objectives/)
- [IES REL Southeast — CBE Mastery Framework](https://ies.ed.gov/rel-southeast/2025/01/cbe-mastery-framework)
- [McREL — Learning Objectives and Success Criteria](https://www.mcrel.org/success-criteria-challenges-examples-support/)
- [Oregon DOE — Writing Tips for Learning Goals](https://www.oregon.gov/ode/educator-resources/assessment/Documents/writing_tips_learning_goals_success_criteria.pdf)
- Andamio Protocol V2 Documentation — Glossary, Module Management, Protocol Overview
