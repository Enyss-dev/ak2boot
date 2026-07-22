# Way of Working — our professional method

This is the method we follow on **every** task, for `ak2boot`, for SaaS, and for
accounting work. The goal: **fewer bugs, fewer problems, clear organisation**, and
work that a senior engineer would be proud of. Take your time. Quality over speed.

Claude: read this file before any non-trivial task. Keep it up to date as the
project grows.

---

## 1. Mindset (the base)

- **Think first, act after.** Never rush to code.
- **Simple is best.** Prefer the simplest solution that works. Avoid clever code.
- **Small steps.** Do a little, verify it, then continue.
- **One source of truth.** No duplicated logic or data. (DRY)
- **Only build what we need now.** Do not add features "for later". (YAGNI)
- **Make it work → make it right → make it fast**, in that order.

---

## 2. The task loop (follow every time)

A repeatable cycle. Do not skip steps.

1. **Understand** the goal. Ask a short question if anything is unclear.
2. **Define "done".** Write what success looks like (acceptance criteria) and the
   main edge cases (empty input, errors, big numbers, etc.).
3. **Plan.** List the steps. For non-trivial work, share the plan first.
4. **Propose the best option** and explain **why** (trade-offs in simple terms).
5. **Design** briefly (data model, functions, files touched) before writing code.
6. **Implement** in small, focused changes.
7. **Test** each step. Do not move on until it works.
8. **Self-review** the diff (see the Definition of Done checklist below).
9. **Commit** with a clear message. Open a **draft Pull Request**.
10. **Merge** only when tests pass and the change is reviewed.
11. **Reflect.** If a bug appeared, add a test so it never comes back.

---

## 3. Planning & requirements

- Turn a vague idea into a **clear goal** with concrete acceptance criteria.
- List **edge cases** and **error cases** early — they cause most bugs.
- Split big work into **small tasks** that can each be tested alone.
- Prefer a short spike/prototype when the path is unknown, then throw it away.

---

## 4. Architecture (SaaS) — the 12-Factor App

We follow the [Twelve-Factor App](https://12factor.net/) method for cloud SaaS:

1. **Codebase** — one repo in Git, deployed to many environments.
2. **Dependencies** — declared explicitly (e.g. `package.json`, `requirements.txt`).
3. **Config** — in environment variables, **never** in code. No secrets in Git.
4. **Backing services** — treat DB, cache, queue as attached resources (via URL/config).
5. **Build, release, run** — keep these three stages separate.
6. **Processes** — app is stateless; save state in the DB, not in memory.
7. **Port binding** — the app exports its service via a port.
8. **Concurrency** — scale by running more processes.
9. **Disposability** — start fast, shut down clean.
10. **Dev/prod parity** — keep dev, staging, and production as similar as possible.
11. **Logs** — treat logs as event streams (stdout), not files.
12. **Admin processes** — run one-off admin tasks as separate processes.

Extra principles:
- **Separation of concerns**: keep layers apart (UI, business logic, data).
- **Clear boundaries**: small modules with one job each.

---

## 5. Coding standards

- **Readable first.** Code is read more than written. Optimise for the reader.
- **Match the existing style** of the project.
- **Good names.** Names should say what a thing is or does.
- **Small functions**, one responsibility each.
- **Handle errors** on purpose; never swallow errors silently.
- **Comment the "why", not the "what"** — only where it is not obvious.
- **No dead code**, no commented-out blocks left behind.

---

## 6. Version control — GitHub Flow

We use [GitHub Flow](https://docs.github.com/en/get-started/quickstart/github-flow):

- `main` is **always working** (deployable). Never commit broken code to `main`.
- Create a **short-lived branch** for each task (a few days max).
- Make **small commits** with clear messages. Prefer
  [Conventional Commits](https://www.conventionalcommits.org/):
  `feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`.
- Open a **draft Pull Request** early. Keep PRs **small** and easy to review.
- **Review** before merge (tests green, code read, no secrets).
- Merge to `main`, then the branch can be deleted.

---

## 7. Testing

- Follow the **test pyramid**: many **unit** tests, some **integration** tests, a
  few **end-to-end** tests.
- **Test each step** as you build it.
- When you fix a bug, first **write a test that fails**, then fix it (regression test).
- Aim for **meaningful coverage** of important logic — not 100% for the number,
  but cover the risky and money-related parts fully.
- Tests must be **fast, repeatable, and independent**.

---

## 8. CI/CD & automation

- Set up **Continuous Integration** so every PR runs **lint + tests + build**
  automatically. A red pipeline blocks merge.
- Automate formatting and linting so style is not a manual debate.
- Deploy in small, frequent, reversible steps once tests are green.
- (We will add the concrete CI config when the project has code.)

---

## 9. Security (build it in from day one — DevSecOps)

- **Never commit secrets** (keys, passwords, tokens). Use environment variables
  and a secrets manager. Add a `.gitignore` and, if useful, secret scanning.
- **Validate all input.** Never trust data from the user or the network.
- **Least privilege.** Give each part only the access it needs.
- **Keep dependencies updated**; watch for known vulnerabilities.
- **Protect data**: encrypt secrets in transit (HTTPS) and sensitive data at rest.
- **Auth**: strong authentication and clear authorization checks.
- For SaaS, keep **GDPR / SOC 2** ideas in mind early (privacy, access logs).

---

## 10. Accounting rules (money must be correct)

Accounting has stricter rules than normal apps. Money errors are serious.

- **Double-entry**: every transaction has equal **debit** and **credit**. They must
  always balance. Enforce this in code and in the database.
- **Immutability**: **never edit or delete** a posted record. To correct, post a
  **reversing / contra entry** and add the correct one. History stays intact.
- **Audit trail**: log who did what and when, for every change. Keep it complete —
  it is often a legal requirement (e.g. GAAP, Sarbanes-Oxley).
- **Exact money**: use integer minor units (cents) or a **Decimal** type.
  **Never use binary floating point** for money (0.1 + 0.2 problems).
- **Data integrity**: use foreign keys and constraints; no orphan records.
- **Idempotency**: the same operation applied twice must not double-post.
- **Reconciliation**: it must be possible to trace any balance back to its entries.
- **Backups**: financial data must be backed up and recoverable.

---

## 11. Documentation

- Keep a clear **README** (what the project is, how to run it, how to test it).
- Record important choices as short **decision notes** (why we chose X over Y).
- Update docs in the **same PR** as the code change.

---

## 12. Definition of Done (checklist before merge)

A task is done only when:

- [ ] It meets the acceptance criteria.
- [ ] Edge cases and errors are handled.
- [ ] Tests are written and **passing**.
- [ ] Lint/format pass; no dead code or leftover debug logs.
- [ ] No secrets committed.
- [ ] For accounting: entries balance, records are immutable, audit trail written,
      money uses exact types.
- [ ] The diff is small, readable, and self-reviewed.
- [ ] Docs/README updated if needed.

---

_This method is a living document. Improve it as we learn._
