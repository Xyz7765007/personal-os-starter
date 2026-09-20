---
name: onboard
description: Use on Day 1 of a fresh OS, when someone says "set me up", "onboard me", "let's get started", "fill in my OS", or has just cloned the starter kit. A 7-question interview that writes os-intake.md and then generates the Day-1 file set (context files, voice samples, connections registry, CLAUDE.md). Safe to re-run any time after editing os-intake.md.
---

## What this skill does

One combined wizard. It reads `os-intake.md`, asks whichever of the seven questions are still blank, writes the answers back into that file as it goes, and then generates the rest of the OS from it in one pass.

**The moment that matters:** at the end, suggest the prompt *"What should I focus on this week?"* The user runs it once. The answer should feel like it came from someone who already knows them. That is the whole point of Day 1.

## When not to run this

- The user has already onboarded and wants to change one answer: still run, but only ask about what changed. The skill is idempotent.
- The user wants to wire a new tool: that is not onboarding. Point them at `connections.md` or suggest `/level-up`.

## Execution

### Step 1: Read the intake

Read `os-intake.md`. Check which of Q1 to Q7 have real content versus the `[Your answer here]` placeholder.

- **All seven filled:** skip to Step 3.
- **Some filled:** say which are done and ask "Want to fill the rest now, or generate from what is there?" Their call.
- **None filled:** run Step 2.

### Step 2: The interview (seven questions, hard cap)

Ask one question at a time. Keep your tone warm and short. Write each answer into `os-intake.md` immediately, so the user can stop and resume later.

**Q1 — Who are you, what do you do, and who do you do it for?**
Name, role, what they make or run, who it is for. One short paragraph each is fine. If they give one word, ask one follow-up, then move on.

**Q2 — Paste one or two things you wrote recently. Do not edit them.**
*This is the only question with a hard rule.* Samples must be pasted from real writing. If the user starts typing something new in the chat, stop them kindly:

> "Hold on. Paste it raw. If you write it here while we are talking, it is already shaped by this conversation. Open your last email or post in another tab and paste the unedited text. This is the one rule I cannot bend."

Ask for two samples. An email and a post, or two of either.

**Q3 — What are your two or three biggest priorities for the next 90 days?**
Push back gently on vague answers. "Grow" is not a priority. Ask for a number, a deadline or a deliverable.

**Q4 — Where do the numbers that matter to you live?**
Revenue, invoices, pipeline, budgets, dashboards. Multiple tools are fine. Maps to connections row 1.

**Q5 — Where do you talk to people day to day?**
Email provider, chat tools, messaging apps. Maps to connections rows 2 and 4. Infer the calendar (row 3) from the email provider and confirm it in Step 3.

**Q6 — Where do meeting notes, recordings and important documents live?**
Maps to connections rows 6 and 7.

**Q7 — What is the one task that eats your week, and where do you track your work?**
Capture the pain point (used later by `/level-up`) and the task tool (row 5).

### Step 3: Generate the Day-1 file set

Once the intake is complete, write these files in a single batch. If any already exist, copy the originals to `archives/intake-{YYYY-MM-DD-HHMM}/` first.

1. **`context/about-me.md`** — from Q1 and Q7. Who they are, their role, the task that eats their week. Two short paragraphs.
2. **`context/about-work.md`** — from Q1 and Q4. What they make or run, who it is for, where the results are tracked. One or two paragraphs.
3. **`context/priorities.md`** — from Q3. A numbered list, one line each, with any number or deadline they gave.
4. **`references/voice.md`** — from Q2. Paste the samples verbatim under a short header: "Match this register when drafting on my behalf. Do not send external text without showing me first."
5. **`connections.md`** — fill the Tool(s) column of the seven rows from Q4 to Q7. Leave "How it is reached" as `not yet connected` and the auth and date columns as `—`. Set "Last reviewed" to today's date. The user wires tools on Day 2 onwards.
6. **`CLAUDE.md`** — replace every `{{...}}` placeholder: name, role, audience, top pain, priorities list, a two-line voice summary (register, sentence length, warmth) and a one-line connections summary ("Seven areas named, none wired yet").

### Step 4: The closing screen

Print exactly this shape, three lines, no menu:

```
Day 1 done. Your OS knows who you are, what you do, what matters this quarter, and how you sound.

Now try: "What should I focus on this week?"
Tomorrow: pick one row in connections.md and wire it. Day 7: run /audit to see your score.
```

When the user then asks "what should I focus on this week", answer only from the new context files:

- Three bullets, in their register from Q2.
- Each bullet ties to one of the Q3 priorities by name.
- Last line: *"If I had to pick one thing for Monday it would be [X], because [reason from priorities]. Want me to draft the first step? And where in this could I take work off your plate entirely?"*

That last question plants the habit `/level-up` will formalise on Day 14.

## Rules

1. **Seven questions, no more.** Do not invent an eighth in conversation.
2. **Voice samples must be pasted.** Refuse typed-in-chat samples once, kindly, then accept whatever they paste.
3. **Generate in one pass.** No file-by-file confirmation. The user iterates by editing `os-intake.md` and re-running.
4. **Idempotent.** Re-running with a changed intake refreshes only the affected files and backs up the originals to `archives/`.
5. **Closing screen is three lines.**
6. **Do not create extra skills.** The kit ships three. The user authors more through `/level-up`.
7. **Never touch `.env`.** No keys on Day 1.
8. **Do not modify `references/how-your-os-works.md`.**

## How to tell it worked

- Ask "what should I focus on this week". The answer names their actual priorities and their actual pain point. Generic advice means it failed.
- Change one priority in `os-intake.md` and re-run. Only `context/priorities.md` and the priorities section of `CLAUDE.md` change, and a backup appears in `archives/`.
