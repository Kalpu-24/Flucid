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
- **Modes**:
  - Simple Mode: minimal UI, essentials-only (tasks, due date, priority, quick planner)
  - Complex Mode: full feature set (subtasks, dependencies, timelines, advanced filters)
- **Notifications & Reminders**: Scheduled, snooze, and smart reminders for upcoming deadlines
- **Data & Sync**:
  - Local persistence initially; cloud sync roadmap
  - Import/export (JSON/CSV) roadmap
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
- **v1 (Complex Mode Foundations)**:
  - Subtasks, tags/labels, filters, search
  - Recurring tasks and reminders
  - Timeline view for projects
  - Keyboard shortcuts and accessibility pass
- **v1.x Enhancements**:
  - Dependencies, milestones, progress tracking
  - Saved views and custom boards
  - Import/export and optional cloud sync

## Design Principles
- **Clarity first**: information-dense but legible; icons aid scanning
- **Structured by default**: sensible organization without heavy setup
- **Fast interactions**: keyboard-first and low-friction flows
- **Progressive complexity**: Simple Mode by default; unlock power in Complex Mode

## Status
In active development. This document tracks the intended feature set to implement next.