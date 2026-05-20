# Example: Customs HS classification for a complex product

You manufacture a multi-component product (LED grow light with integrated water pump and Bluetooth controller). You need to ship to Germany. What's the HS code?

You: "Classify HS code: 'LED grow light, 100W, integrated water pump, Bluetooth controller, for indoor agriculture' — ship to DE."

OpenClaw agent (with cleo-legal): *invokes `customs-hs-classifier` skill*

1. `customs_lookup { description: "LED grow light 100W integrated water pump Bluetooth indoor agriculture", country: "DE", top: 5 }`
2. Top: `9405.40.99` — confidence 0.72.
3. Alternative: `8543.70.90` — confidence 0.61.

Answer:

```
For an integrated multi-function product like this, German customs will likely classify by "essential character" (General Interpretative Rule 3(b)).

Top candidates:

1. 9405.40.99 — Other electric lamps and lighting fittings (confidence 0.72)
   Rationale: Primary function is lighting. Water pump + Bluetooth are accessories.

2. 8543.70.90 — Electrical machines with individual functions (confidence 0.61)
   Rationale: If positioned as an "integrated growing system" rather than a lamp.

3. 8479.89.97 — Other machines for individual functions (confidence 0.45)

Recommended: 9405.40.99 (lighting = essential character).

Next step:
  /cleo-compliance "LED grow light 100W with water pump and Bluetooth" DE

Final classification must be validated by a licensed customs broker.
```

## Why this matters

Misclassification costs:
- Wrong duty rate (3.7% vs 0% — €37 per €1000 shipped)
- Wrong certifications required
- Wrong Intrastat reporting

3 min to classify > 3h of regret.
