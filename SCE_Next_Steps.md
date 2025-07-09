# Signal Composite Engine (SCE) – Next-Steps Roadmap

> **Status:** v0.1.0  
> **Last updated:** 2025-06-30

---

## 1. Validation & Testing  
- [ ] Run forward-testing on multiple symbols & timeframes (1m → 1D).  
- [ ] Toggle `Require Both Signals to Align` on/off; verify output accuracy.  
- [ ] Disable/enable individual signals (#1/#2) and confirm fallback behaviour.  
- [ ] Stress-test `Mixed Mode` (internal EMA + externals) for unexpected edge cases.

## 2. Expand Signal Inputs  
- [ ] Add 3rd, 4th, and 5th external signal inputs.  
- [ ] UI: add enable toggles & labels for each new signal.  
- [ ] Guarantee backward-compatibility for scripts using only 1-2 signals.

## 3. Weighted Composite Scoring  
- [ ] Introduce **per-signal weight** inputs (0–100 or 0.0–1.0).  
- [ ] Compute a composite score each bar: `score = Σ(signal_i * weight_i)`.  
- [ ] Add **Threshold** input: send trade only when `|score| ≥ threshold`.  
- [ ] Visual: plot composite score & threshold line.

## 4. Flexible Alignment Logic  
- [ ] Option: *All signals agree*, *Majority agree*, or *Threshold score*.  
- [ ] Parameterise logic so users can switch without source edits.  
- [ ] Update alert firing rules accordingly.

## 5. Alerts & Strategy Integration  
- [ ] Update alert messages to include composite score & active weights.  
- [ ] Ensure compatibility with **Signal Execution Strategy** (SES).  
- [ ] Provide sample SES code snippet for new payload format.

## 6. Optimisation & UX  
- [ ] Refactor for readability: move helper functions to a separate library.  
- [ ] Group inputs (🎛 UI) logically to avoid clutter when 5 signals present.  
- [ ] Add **Debug Panel v2** with per-signal weight & current contribution.

## 7. Versioning & Documentation  
- [ ] Create version `v0.2.0` once weighted scoring is functional.  
- [ ] Generate changelog entry & update VERSION_HISTORY.md.  
- [ ] Record unit tests & edge cases in `/docs/testing/`.

---

### 💡 Ideas for Future Releases
1. **Signal Clustering** – automatically group correlated signals and adjust weights.  
2. **Machine-Learning Weights** – optimise weights via walk-forward analysis.  
3. **Session-Aware Scoring** – dynamic weighting based on market sessions.  
4. **Risk-Based Scaling** – tie signal strength to position sizing logic. 