---
name: sanctions-screening
description: Check persons, entities, and countries against OFAC SDN, EU consolidated, UN, UK OFSI, and other sanctions lists. Returns matched entries with metadata, last updated dates, and applicable jurisdictions. Use when the user mentions OFAC, SDN, sanctions, AML, blocked persons, screening, embargoes, or asks "is X sanctioned by Y?".
version: 1.0.0
metadata:
  openclaw:
    requires:
      env: [CLEO_LEGAL_API_KEY]
    primaryEnv: CLEO_LEGAL_API_KEY
    envVars:
      - { name: CLEO_LEGAL_API_KEY, required: true, description: "Cleo Legal API key." }
    emoji: "🛑"
    homepage: https://legaldata-public.cleolabs.co
---

# Sanctions Screening

Use this skill when the user asks about:
- **OFAC** (US Treasury) — SDN List, Sectoral Sanctions, Non-SDN lists
- **EU consolidated** sanctions list
- **UN** Security Council sanctions
- **UK OFSI** consolidated list
- Country-specific embargoes (CU, IR, KP, RU, SY, VE, etc.)
- AML / sanctions screening for KYC workflows

## Workflow

1. **Identify the target** — natural person, legal entity, vessel, aircraft, or country.
2. **Search** — `search_legal { type: "sanction", country: <issuing jurisdiction>, q: "<target name>" }`.
3. **Render matches** — each: `{name} | {alias list} | {birth date/registration} | {sanction program} | {date listed} | {issuing authority}`.
4. **No match ≠ not sanctioned** — be explicit: "No matches in Cleo's loaded lists (last updated `<date>`). Always re-screen against the live source for compliance-critical decisions."
5. **Country-level**: return all active programs (e.g., "Iran: ITSR OFAC, EU Council Decision 2010/413/CFSP, UN UNSC Res 2231").

## Refresh cadence (transparency)

- OFAC SDN: daily refresh
- EU consolidated: daily
- UN: weekly

Always note `last_updated_at` from the response.

## Worked examples

### Person check

User: "Is Ivan Petrov on OFAC?"

You:
1. `search_legal { q: "Ivan Petrov", type: "sanction", country: "US" }`
2. Show all matches (common name — show all candidates so user disambiguates by DOB / passport / address).

### Country check

User: "What sanctions apply to Iran?"

You:
1. `search_legal { q: "Iran sanctions program", type: "sanction" }` (no country — global view)
2. Render all active programs.

### Company check

User: "Screen Acme Tech Holdings Ltd against EU sanctions."

You:
1. `search_legal { q: "Acme Tech Holdings", type: "sanction", country: "EU" }`
2. If no match: "No match in EU consolidated (last updated `<date>`). Necessary but not sufficient — also screen against OFAC, UN, UK OFSI, and local lists."

## Output format

```
Sanctions screen for "<target>":
  Lists checked: <programs>
  Last updated: <ISO date>

Matches:
  ✓ NONE
  OR
  ✗ FOUND ({n}):
    1. {name} | aliases: {…} | DOB: {…} | program: {SDN} | listed: {date}

⚠ Always re-screen against live sources for compliance-critical decisions.
```
