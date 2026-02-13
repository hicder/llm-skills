---
name: create-weekly-tasks
description: Use when creating weekly task tracking markdown documents with hierarchical checkboxes
---

# Create Weekly Tasks

## Overview

Generate a structured markdown document for tracking weekly tasks with main task summaries and detailed subtask breakdowns.

## When to Use

- Creating weekly task lists for planning or standups
- Need visual task tracking with completion checkboxes
- Want hierarchical task structure (main tasks + subtasks)

## Format Structure

```markdown
# MM/DD/YYYY - MM/DD/YYYY

## Tasks

- [ ] Task Category - Main task description
- [ ] Task Category - Another main task

## Details

### Task Category - Main task description

- [x] Completed subtask
- [ ] Pending subtask
  - [x] Nested completed item
  - [ ] Nested pending item

### Task Category - Another main task

- [x] Completed work item
- [ ] Remaining work item
```

## Key Features

**Date Range Header:**
- Format: `MM/DD/YYYY - MM/DD/YYYY`
- Start date (Monday) to end date (Sunday)

File name should be YYYYMMDD-YYYYMMDD.md
- The range should be the same as the Date Range Header

**Tasks Section:**
- Main tasks with category prefix (e.g., "CRDB -", "ES -")
- All unchecked by default (unless copying from existing status)
- One checkbox per main task

**Details Section:**
- Each main task gets its own subsection (`###`)
- Subtasks use `- [ ]` (pending) or `- [x]` (completed)
- Supports nested items with indentation

## Example

```markdown
# 08/18/2025 - 08/25/2025

## Tasks

- [ ] Backend - Database API for atomics/locks
- [ ] Backend - Database Support for version-4
- [ ] Backend - Host level resiliency
- [ ] Search - library Project X launch

## Details

### Backend - Database API for atomics/locks

- [x] Ask Person A to bring up Staging Environment to hook up to Backend api
  - [x] service should already be up
- [ ] Get all 7 PRs reviewed
  - [x] New custom_metadata column family
  - [x] API.JSON.SET
  - [x] API.JSON.PATCH
  - [ ] API.JSON.GET
  - [ ] session
  - [ ] API.JSON.TXLOCK
  - [ ] unit test

### Backend - Database Support for version-4

- [x] Wait for Person B to publish bulk-loader and test my PR
- [ ] Get PR reviewed

### Backend - Host level resiliency

- [x] Write docs on infrastructure components
- [ ] Work with Person C on storage layer
- [x] Get Key Service up and running locally
- [x] Wrote first version of the operator

### Search - library Project X launch

- [x] Turn on slowlog
- [x] Get the query and see why it's expensive
```

## Common Mistakes

**Wrong:** Mixing main tasks with subtasks in the same list  
**Right:** Separate main tasks (Tasks section) from subtasks (Details section)

**Wrong:** Using `##` for task subsections  
**Right:** Use `###` for Details subsections (Tasks and Details are already `##`)

**Wrong:** Omitting the date range header  
**Right:** Always include the week range at the top

**Wrong:** Inconsistent category prefixes  
**Right:** Use consistent prefixes like "CRDB -", "ES -" for related tasks
