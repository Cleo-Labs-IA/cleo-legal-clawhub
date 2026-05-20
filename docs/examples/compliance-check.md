# Example: Composite compliance check (cross-border shipment)

Ship "thermal imaging drone with 2.5km range" from France to Kazakhstan for an industrial client.

You: `/cleo-compliance "thermal imaging drone 2.5km range industrial inspection" KZ`

OpenClaw agent (with cleo-legal): *calls MCP tool `compliance_check` directly*

```json
{
  "product": { "description": "thermal imaging drone 2.5km range industrial inspection" },
  "destination_country": "KZ",
  "client_type": "oil_gas",
  "options": {
    "include_alternatives": true,
    "include_dual_use_check": true,
    "include_parallel_import": true
  }
}
```

Response (5 quota units):

```
PRIMARY TARIFF CODE
  HS 8806.10.00 — Unmanned aircraft, MTOW ≤ 250 g
  → Reclassify: 8806.21.00 (250g-2kg) likely better
  Confidence: 0.81

ALTERNATIVES
  - 8806.92.00 — Other unmanned aircraft
  - 9006.30.00 — Cameras specially designed for industrial use

LEGALLY REQUIRED OBLIGATIONS (KZ + EAEU)
  - EAC declaration of conformity (TR CU 020/2011, EMC)
  - GOST R 51317.6.1-2017 — EMC immunity
  - GAC-Kazakhstan type approval (radio module)
  - TN VED 8806.21.00 declaration

CONTRACTUALLY EXPECTED (for oil_gas industry)
  - GOST 31610.X — explosion-proof for hazardous zones
  - GOST R IEC 60079-X — explosive atmospheres
  - SIL 2 certification (functional safety)

DUAL-USE STATUS: ⚠ CONTROLLED
  Categories: Wassenaar Cat 6.A.5 + Cat 9.A.10
  License likely required: YES — file with BAFA / DGA / SBDU

EAEU PARALLEL IMPORT
  EAC certificate issued in KZ recognised in: RU, BY, KZ, AM, KG.
  → "Ship once, sell five times" — significant optimization.

ESTIMATED LEAD TIME
  - Export license: 4-8 weeks
  - EAC certification: 4-6 weeks
  - Total: 8-14 weeks

⚠ ADVISORY DISCLAIMER
Final classification, obligation matrix, and export license determination must be validated by a licensed customs broker and an export-control specialist.
```

## What this saved

- 6+h research across BAFA, EEC TR CU, GAC-KZ, GOST register
- 2h cross-referencing dual-use ECCN ↔ Wassenaar ↔ EAR
- Risk of missing EAEU parallel-import optimization

5 quota units.
