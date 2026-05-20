---
name: customs-hs-classifier
description: Classify products into HS, TN VED, CN8, or HTS tariff codes from a description in any language (RU, ZH, AR, EN, FR, …). Returns top candidates with confidence + customs rationale. Use when the user has a product and needs the import/export code, asks "what HS code for X?", "TN VED for Y", or wants to figure out customs duties.
version: 1.0.0
metadata:
  openclaw:
    requires:
      env: [CLEO_LEGAL_API_KEY]
    primaryEnv: CLEO_LEGAL_API_KEY
    envVars:
      - { name: CLEO_LEGAL_API_KEY, required: true, description: "Cleo Legal API key." }
    emoji: "📦"
    homepage: https://legaldata-public.cleolabs.co
---

# Customs / HS Code Classification

Use this skill when the user needs to classify a product for customs:
- "What HS code is a stainless steel beam?"
- "TN VED for a drone with thermal imaging?"
- "CN8 for cosmetic creams"
- "HTS classification for solar panels"

## Workflow

1. **Get a clean description**. If vague (e.g., "machine"), ask for function, material, dimensions.
2. **Detect destination** if helpful. Ask if not provided.
3. **Call `customs_lookup`** with `{ description, country?, system?, top: 5 }`. The MCP server handles multilingual input.
4. **Render** top candidates as a table.
5. **Suggest next step**: high confidence → `/cleo-compliance`. Low confidence → refine description.

## Worked examples

### Steel beam

User: "I need the HS code for a steel I-beam, 6m long, structural use, painted."

You:
1. `customs_lookup { description: "structural steel I-beam, 6m, painted", top: 5 }`
2. Top: `7216.10` — confidence 0.92.
3. Suggest `/cleo-compliance` for destination-specific obligations.

### Multilingual

User: "石材切割机 — for export to RU"

You:
1. `customs_lookup { description: "石材切割机", country: "RU", system: "tn_ved", top: 5 }`
2. MCP auto-translates internally. Top: `TN VED 8464.10.00.00` — confidence 0.87.

### Vague request

User: "What's the HS code for my product?"

You: "I need a description. Tell me: function, material, dimensions, destination. Example: 'lithium-ion battery, 60kWh, for EV, ship to DE'."

## Output format

```
Top candidates for "<description>" (system: <system>, destination: <country>):

  1. <code> — <title>
     Confidence: <0.0-1.0> · Rationale: <one sentence>

  2. ...

Next step:
- /cleo-compliance "<product>" <ISO-2>  →  full decision pack
```

**Always** append: "Final classification must be validated by a licensed customs broker."
