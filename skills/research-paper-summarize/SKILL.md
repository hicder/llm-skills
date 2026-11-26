---
name: research-paper-summarize
description: >-
  Summarize the innovations, architecture, and engineering tradeoffs of a
  research paper, arXiv link, PDF, or technical system. Use when the user asks
  to summarize innovations in a paper, break down a technical paper's
  contributions, or analyze a system design paper with critical rigor.
---

# Research Paper Innovation Summary

Produce a structured, critical, systems-engineering-grade breakdown of a research paper or technical system.

## 1. Acquire the Source

Before writing, read the full paper or relevant sections (fetch the URL/arXiv PDF or read the local file). Never rely on memory or abstract-only guesses for metrics, symbol names, or section numbers.

## 2. Output Structure

Follow this 6-part structure in order:

### 1. Header & Central Thesis
- **Header:** Paper title as H1, followed by one metadata line (`arXiv:<id> · <Month Year> · <N> pages` or equivalent).
- **Central thesis:** Open with one **bolded sentence** framing the core paradigm shift (*"The central innovation is X, rather than Y"*).
- **Core pillars:** List the 3–5 major innovations as a numbered list with **bolded names** and crisp 1-sentence summaries.

### 2. Headline Results (with Caveats)
- Highlight the top quantitative results (latency, cost, CPU, throughput) as scannable callouts.
- Immediately add an explicit methodological caveat if numbers come from different evaluation settings, production migrations, or constrained benchmarks rather than one uniform test.

### 3. Deep-Dive per Innovation
Create one numbered section (`## 1. ...`, `## 2. ...`) for each major innovation:
- Optionally include a parenthetical significance tag (e.g., *(Most important storage-engine innovation)* or *(Most interesting correctness contribution)*).
- **How it works:** Explain the concrete mechanism, data flow, or architecture. Include:
  - Exact component, API, or algorithm names from the paper.
  - A concrete example or worked math/notation where helpful.
  - A compact comparison table, ASCII/Mermaid flow, or chart when it clarifies a trade-off or benchmark.
- **Why it matters:** Contrast directly against the naive or prior approach, and state the broader architectural implication.

### 4. Novelty vs. Established Techniques
Include a markdown table rating each technique's novelty:
- Columns: `Technique` | `Novelty assessment`
- Use **High**, **Medium**, or **Low–medium** paired with a 1-sentence justification separating genuine novelty from practical integration of existing ideas.
- Add a 1-line note clarifying that these are engineering assessments of the contributions, not formal novelty claims by the authors.

### 5. Limitations, Regressions, and Conditional Wins
Scrutinize the evaluation and design before recommending adoption:
- Call out where the approach regresses (e.g., short reads, extra retention/storage amplification, hidden background maintenance).
- Flag headline numbers that are workload-dependent or only hold under specific constraints (e.g., bandwidth caps, specific baselines).

### 6. Reusable Takeaways & Actionable Next Steps
- Distill **3 transferable design principles** that apply beyond the paper's specific domain.
- Point to which specific **sections** of the paper are most actionable (and why), tailored to the user's stack/context if known.
- End with **1 concrete next step** for deeper investigation and **3 brief follow-up topics** the user can ask about.

## 3. Save to Repo & Output Verbatim

After drafting the summary following the structure above:

1. **Create a directory in the current repo:**
   - Locate the current repository root (e.g., `git rev-parse --show-toplevel`), or use the current working directory if not inside a Git repository, unless the user specifies a target path.
   - Create a concise, descriptive kebab-case directory for the paper at `<repo-root>/<paper-slug>/` (e.g., `flash-attention-3`, `raft-consensus`).
2. **Write `summary.md`:**
   - Write the complete 6-part Markdown summary to `<repo-root>/<paper-slug>/summary.md`.
3. **Output the exact same content in the harness:**
   - Output the **exact, verbatim contents** of `summary.md` directly in your response.
   - Do **not** replace the output with just a file link, abbreviate it, paraphrase it, or diverge between the file and the chat response—both `summary.md` and the harness output must contain the exact same summary content.
   - If you include a note with the saved file path, keep it to a single brief line separated from the summary without modifying the summary text itself.

## Style & Rigor Rules
- Write like a senior systems engineer reviewing a paper for peers: concise, direct, and skeptical of unqualified marketing claims.
- Use short paragraphs, scannable bold lead-ins, tables, and exact terminology from the source.
- Never extrapolate, fill in unprinted numbers, or smooth over caveats in benchmarks.
