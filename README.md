# Flucid

## Overview
Flucid is a structured Todo and planning app featuring Phosphor Icons, with dual modes to suit different workflows: a streamlined Simple Mode and a powerful Complex Mode.

## Planned Features
- **Phosphor Icons**: Cohesive iconography across all UI components for clarity and consistency.
- **Core Todo Management**:
  - Create, edit, complete, and delete tasks
  - Subtasks and checklists
  - Due dates, reminders, and recurring tasks
  - Priority levels and tags/labels
  - Quick add (global capture)
- **Planner**:
  - Daily/weekly/monthly views
  - Time-blocking and agenda view
  - Drag-and-drop task scheduling
  - Smart suggestions (auto-slot overdue/unplanned tasks)
- **Timelines**:
  - Project timelines/Gantt-like view
  - Milestones and dependencies
  - Progress tracking and critical path highlights
- **Structured UI**:
  - Sections, boards, and lists for organized workflows
  - Filters, saved views, and search
  - Keyboard shortcuts and accessible navigation
- **Categories & Subcategories**:
  - Custom, user-defined categories with optional subcategories (hierarchical)
  - Not required: if unspecified, tasks/entries default to "Misc"
  - Create/rename/merge/delete categories and subcategories
  - Duplicate handling and redundancy cleanup (suggest merge on similar names)
  - Quick assignment in task editor and journal entry composer
  - Example: Category "Wasted time" → Subcategory "YouTube" (or "YT")
- **Journaling**:
  - Daily notes with rich text (headings, checklists, code blocks)
  - Templates (daily review, weekly recap, project postmortem)
  - Link journal entries to tasks, projects, and timelines
  - Mood/energy tracking and highlights; media attachments (images)
  - Backlinks and full-text search across entries
- **Modes**:
  - Simple Mode: minimal UI, essentials-only (tasks, due date, priority, quick planner)
  - Complex Mode: full feature set (subtasks, dependencies, timelines, advanced filters)
- **Notifications & Reminders**: Scheduled, snooze, and smart reminders for upcoming deadlines
- **Data & Sync**:
  - Local persistence initially; cloud sync roadmap
  - Import/export (JSON/CSV) roadmap
- **Calendar Integration (Roadmap)**:
  - Optional Google Calendar integration via OAuth
  - One-way and two-way sync (tasks with due dates <-> events)
  - Time-blocking export and reminders alignment
- **Cross-Platform**: Flutter app targeting iOS, Android, Web, Windows, macOS, and Linux

## Gemini AI Integration (User-Provided API Key)
- **Opt-in, bring-your-own-key**: Users add their personal Gemini API key in `Settings → Integrations`.
- **Capabilities**:
  - Natural-language task capture (e.g., "plan my week" or "remind me to call mom every Friday")
  - Smart scheduling and prioritization based on existing workload
  - Task breakdown into subtasks with estimated effort and suggested due dates
  - Project planning: generate timelines/milestones and update progress
  - Intent-based actions: map user phrasing to in-app actions via custom intents
- **Custom Intents (ground-up design)**:
  - Intent schema: `name`, `entities` (task, date, priority, project), `action` (create/update/schedule)
  - Deterministic handlers: each intent resolves to specific app operations (e.g., create task, move task, reschedule)
  - Safe operations: review-and-apply step in Simple Mode; auto-apply with undo in Complex Mode (configurable)
- **Privacy & Security**:
  - Keys stored locally and never bundled with the app
  - Users can disable AI features anytime; graceful degradation to manual flows
  - Configurable data sharing scope (titles only vs. full task context)
- **Failure Modes & Safeguards**:
  - Clear error states for invalid/expired keys and rate limits
  - Offline/AI-unavailable fallback to standard create/schedule flows
  - Change log for AI-applied edits with one-tap undo

## Initial Roadmap
- **MVP (Simple Mode)**:
  - Basic tasks (CRUD), complete/undo
  - Due dates and priorities
  - Daily/weekly planner view with drag-and-drop
  - Phosphor Icons integration
  - Local storage
  - Basic journaling (daily notes, link to tasks)
  - Categories with default fallback to "Misc"
- **v1 (Complex Mode Foundations)**:
  - Subtasks, tags/labels, filters, search
  - Recurring tasks and reminders
  - Timeline view for projects
  - Keyboard shortcuts and accessibility pass
  - Enhanced journaling (templates, search, media attachments)
  - Subcategories, merge/rename tools, and redundancy cleanup
- **v1.x Enhancements**:
  - Dependencies, milestones, progress tracking
  - Saved views and custom boards
  - Import/export and optional cloud sync
  - Google Calendar integration (OAuth, 1/2-way sync)
  - AI-assisted category suggestions from entry text

## Design Principles
- **Clarity first**: information-dense but legible; icons aid scanning
- **Structured by default**: sensible organization without heavy setup
- **Fast interactions**: keyboard-first and low-friction flows
- **Progressive complexity**: Simple Mode by default; unlock power in Complex Mode

## Status
In active development. This document tracks the intended feature set to implement next.