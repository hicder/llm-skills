---
name: executive-summary
description: >-
  Summarize a report, PDF, article, or document as an executive, high-signal
  research brief with a central thesis, numbered takeaways, data visuals or KPI
  callouts, an implications table, structural synthesis, and next-step reading
  guidance. Use when the user asks to summarize a report, PDF, whitepaper,
  research note, or long document in depth, or explicitly invokes executive
  summary / research brief formatting.
---

# Executive Summary Brief

Produce a scannable, high-signal executive research brief from the provided URL, PDF, or document. Prioritize concrete figures over vague adjectives, keep paragraphs short (1–2 sentences each), and clearly distinguish what the source reports from your own analytical interpretation.

## Workflow

1. **Read the full source first.** Fetch or read the entire document/PDF/page before drafting. Capture exact numbers, timeframes, entity names, page/section numbers, author, publication, and date. Never extrapolate or invent missing figures.
2. **Identify the central tension.** Distill the overarching thesis and 5–7 major themes before writing.
3. **Follow the output structure below.** Include every section unless the source genuinely lacks data for a visual or table.

## Output Structure

### 0. Header & Central Thesis

- `# Summary: [Report Title]`
- Muted metadata line: `Author · Publication · Date · Page count` (omit unavailable fields rather than guessing).
- `**Central thesis:**` 1–2 crisp sentences capturing the core tension and conclusion.

### 1. Major Takeaways (`## 1. The [N] major takeaways`)

- Break into 5–7 numbered `###` subsections (`### 1. ...`), each with a clear, thesis-driven heading.
- Use short, punchy paragraphs (1–2 sentences) and concise bullets.
- **Data visuals & KPI callouts:** When the source provides key quantitative breakdowns or headline metrics:
  - Present key comparative shares or trends as a clean chart if your environment supports rendering charts (e.g., `html_preview` + `html_render` in T3 Code, or native chart blocks); otherwise use a compact Markdown table or aligned visual comparison, always with exact source/page attribution.
  - Group headline KPIs (margins, ratios, dollar commitments, percentages) into scannable stat callouts or a compact KPI table with brief context notes.
- End pivotal subsections with a bold `**Implication:**` line explaining why the finding matters.

### 2. Implications Table (`## 2. [Strategic / Investment / Practical] implications`)

- Note explicitly that the table combines the source's arguments with your interpretation.
- Use a Markdown table:
  `| Entity or Segment | Outlook | Rationale |`

### 3. Analytical Synthesis (`## 3. What I find most important`)

- Highlight 3 overarching structural distinctions or non-obvious takeaways using bold lead-ins (`**First, ...**`, `**Second, ...**`, `**Third, ...**`).

### 4. Bottom Line (`## Bottom line`)

- Start with one bold summary sentence capturing the directional stance (e.g., where the report is constructive vs. skeptical).
- State the key framing shift for the reader (e.g., moving from *Question A* to *Question B*).
- Point to the specific pages, charts, or sections worth reading next for a deeper technical dive.

### 5. Follow-Up Options

- End with `---` and 3 concise bullets under `If you want, I can:` offering deeper dives into the document's main themes.
