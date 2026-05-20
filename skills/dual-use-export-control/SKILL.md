---
name: dual-use-export-control
description: Check whether a product or technology is subject to dual-use export controls (Wassenaar Arrangement, EU Regulation 2021/821, US EAR). Cross-checks the destination country against active sanctions/embargoes. Use when the user mentions exports, dual-use, controlled technology, encryption export, Wassenaar, ECCN, embargoes, or wants to know if shipping product X to country Y triggers controls.
version: 1.0.0
metadata:
  openclaw:
    requires:
      env: [CLEO_LEGAL_API_KEY]
    primaryEnv: CLEO_LEGAL_API_KEY
    envVars:
      - { name: CLEO_LEGAL_API_KEY, required: true, description: "Cleo Legal API key." }
    emoji: "🚫"
    homepage: https://legaldata-public.cleolabs.co
---

# Dual-Use Export Control

Use this skill when the user is exporting tech/equipment and needs to check:
- **Wassenaar Arrangement** classifications
- **EU Regulation 2021/821** (recast Dual-Use Regulation)
- **US EAR** (Export Administration Regulations, ECCN codes)
- Active **sanctions and embargoes** against the destination

## Workflow

1. **Identify the product** — get a clean description AND HS code (run customs_lookup first if not known).
2. **Identify the destination** — ISO-2.
3. **Call `customs_dual_use_check`** with `{ description, code, destination }`.
4. **If a dual-use match is returned**:
   - Render the matched control category (e.g., "Category 5 — Telecoms / Information Security")
   - Render the specific ECCN / EU dual-use code
   - Render the rationale
5. **Check sanctions** — the MCP tool already cross-checks. If destination is sanctioned/embargoed, flag prominently.
6. **Output:** clear yes/no on license required.

## Common patterns

- **Encryption** (Cat 5 Part 2): default-controlled unless specifically excluded.
- **Drones with thermal imaging**: very likely controlled.
- **Industrial chemicals**: Australia Group lists (handled by MCP).
- **Cybersecurity tools**: controlled under recent Wassenaar amendments.

## Worked example

User: "Can I ship a drone with thermal camera to KZ?"

You:
1. customs_lookup mentally → HS `8806.10`.
2. `customs_dual_use_check { description: "drone with thermal camera", destination: "KZ" }`.
3. Matched Wassenaar Cat 6.A.5 (thermal imaging) AND Cat 9.A.10 (UAVs above thresholds).
4. Sanctions: KZ not embargoed but on certain end-use watchlists.
5. **Verdict**: "License required. For KZ shipment from EU: contact BAFA / DGA via SBDU. Estimated 4-8 weeks."

## Output format

```
Dual-use status: CONTROLLED  /  POTENTIALLY CONTROLLED  /  NOT CONTROLLED

Categories matched:
- {category code} — {category name} ({source: Wassenaar / EU 2021/821 / EAR})

Destination check (XX):
- Sanctions: {none / list}
- Embargoes: {none / list}
- End-use restrictions: {none / list}

License likely required: YES / NO / DEPENDS
Recommended next step: contact {national authority} for license application.
```

**Always** append: "This is not legal advice. Final export determination must be made with a qualified export control specialist."
