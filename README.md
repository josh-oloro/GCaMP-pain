# GCaMP-pain

MATLAB code for processing and analyzing simultaneous CMOS-based calcium imaging (GCaMP) data from the **Central Amygdala (CeA/CeLC)** and **Dorsal Raphe Nucleus (DRN)** during nociception in freely-moving mice.

## Publication

Rebusi R., Olorocisimo, J.P., Briones J., Ohta Y., Haruta M., Takehara H., Tashiro H., Sasagawa K., Ohta J. (2021). Simultaneous CMOS-based imaging of calcium signaling of the central amygdala and the dorsal raphe nucleus during nociception in freely-moving mice. *Frontiers in Neuroscience*, 15:667708. https://doi.org/10.3389/fnins.2021.667708

## Overview

This repository provides a complete pipeline to:
1. Read raw CMOS imager data and remove electrical noise
2. Compute ΔF/F (relative fluorescence change) signals for the CeA and DRN
3. Manually select regions of interest (ROIs) and extract per-ROI signals
4. Analyze inter-regional functional coupling via cross-correlation
5. Quantify the relationship between neural signals and pain behavior via mutual information
6. Generate publication-quality figures for group comparisons

## Requirements

- **MATLAB** (tested with R2019b or later)
- **Signal Processing Toolbox** — for `xcorr`, `detrend`
- **Statistics and Machine Learning Toolbox** — for `boxplot`, `prctile`
- Raw `.raw` CMOS image files (not included; place in a `data/` subfolder relative to the pipeline scripts)

## Directory Structure

```
GCaMP-pain/
│
├── Pipeline Scripts (run in order for each recording session)
│   ├── s0_pain_setup.m           - Read raw data, remove hum noise, plot raw signals
│   ├── s1_pain_preprocessing.m   - Compute ΔF/F, generate optional video, save processed data
│   └── s2_pain_ROIselection.m    - Define ROIs, extract ROI signals, save per-mouse results
│
├── Analysis Scripts
│   ├── cross_corr.m              - Cross-correlation between CeA and DRN ROIs (basic version)
│   ├── cross_corr_diff.m         - Cross-correlation using first-differenced signals (per-mouse figure)
│   ├── auto_corr_diff.m          - Auto-correlation within a single brain region (CeA or DRN)
│   └── behlick_MI.m              - Mutual information between ROI signals and licking behavior
│
├── Visualization Scripts
│   ├── plot_across_mice.m        - Overlay CeA and DRN signals for all Formalin and PBS mice
│   ├── plot_signals_imgsc.m      - Plot ROI signals alongside ΔF/F heatmap frames (single mouse)
│   ├── plot_multiple.m           - Plot CeA and DRN ROI signals for individual example mice
│   ├── behavior_tally.m          - Plot neural signals alongside behavioral lick counts
│   ├── PainMinusNIsolationE.m    - Plot ROI signals isolating the post-injection pain period
│   ├── imagesc_code.m            - Display ΔF/F heatmap images with ROI outlines overlaid
│   ├── allsig.m                  - Plot single-ROI signal vs whole-frame mean signal
│   ├── MakeMatCrossCorr.m        - Compile cross-correlation results from all mice into matrices
│   ├── MakeFigCrossCorr.m        - Generate cross-correlation summary figure (heatmap per mouse)
│   ├── FigCrossCorr.m            - Generate cross-correlation figure (earlier version)
│   ├── MI_boxplot.m              - Boxplot of mutual information values (Formalin vs PBS)
│   └── Frame_lag_boxplot.m       - Boxplot of cross-correlation frame lags (Formalin vs PBS)
│
├── Utility Functions
│   ├── f_read_pain.m             - Read raw CMOS .raw files into MATLAB arrays
│   ├── hum_removal.m             - Remove electrical hum noise via spatial mean subtraction
│   ├── plot_mean.m               - Plot mean signal with SEM, injection markers, and time axis
│   ├── test_adjust.m             - Subtract segment mean and detrend a data segment
│   ├── discrete_continuous_info_fast.m  - Estimate mutual information (discrete vs continuous)
│   ├── hDistance.m               - Compute Hellinger distance between two distributions
│   ├── breakplot_stem.m          - Stem plot with a y-axis break to skip blank data ranges
│   └── breakplot_stem_x.m        - Variant of breakplot_stem (applies break along x axis)
│
└── Data Files
    ├── BehaviorTally.mat         - Licking behavior data for all Formalin and PBS mice
    ├── E_Pain_adj_ROI.mat        - Processed ROI signals for Formalin Mouse E (example)
    ├── I_PBS_adj_ROI.mat         - Processed ROI signals for PBS Mouse I (example)
    └── crosscor.mat              - Cross-correlation results compiled across all mice
```

## Workflow

### Step 0 — Data Setup (`s0_pain_setup.m`)

Reads raw `.raw` CMOS image files, subtracts the fixed-pattern background image, removes electrical hum noise, and plots the raw and denoised mean signals for visual inspection.

**Configure before running:**
- `DATA_FOLDER` — name of the folder (inside `data/`) containing the raw `.raw` files
- `x_size`, `y_size` — pixel array dimensions (default: 44 × 242)
- `inj_start`, `inj_end` — frame indices marking the start and end of the injection period
- `start_mark` — frame index to assign as time zero (typically the midpoint of injection)

**Workspace outputs:** `data_raw`, `data_denoise1` (CeA region), `data_denoise2` (DRN region)

---

### Step 1 — Preprocessing (`s1_pain_preprocessing.m`)

Computes ΔF/F = (F − F₀) / F₀ for both brain regions using a pre-injection reference baseline. Optionally exports a side-by-side video of the ΔF/F heatmaps. Saves processed data to `<trial_name>_Pain_adj.mat` in the `mat/` subfolder.

**Configure before running:**
- `ref_frame` — frame range used as the baseline F₀ (e.g., `3110:6500`)
- `sample_frame` — a frame number to display as a representative image
- `VID_START`, `VID_END` — frame range for optional video export (prompted at runtime)

**Saved outputs:** `data_adj1`, `data_adj2` (ΔF/F arrays for CeA and DRN) in `mat/<trial_name>_Pain_adj.mat`

---

### Step 2 — ROI Selection (`s2_pain_ROIselection.m`)

Loads the ΔF/F data, computes ROI mean and SEM signals for three manually defined rectangular regions in each brain area, and generates imagesc plots with ROI outlines. Saves results to `<trial_name>_Pain_adj_ROI.mat`.

**Configure before running:**
- `A_ROI*_xs/xe/ys/ye` — pixel row/column coordinate ranges for CeA ROIs 1–3
- `B_ROI*_xs/xe/ys/ye` — pixel row/column coordinate ranges for DRN ROIs 1–3
- `mat_name` — output filename (e.g., `'E_Pain_adj_ROI'`)

**Saved outputs:** Per-ROI mean/SEM time series, ROI boundary coordinates, sample frame images in `mat/<trial_name>_Pain_adj_ROI.mat`

---

### Analysis

After running the pipeline for all recording sessions:

1. **Cross-correlation** — Load an `_adj_ROI.mat` file, then run `cross_corr_diff.m` to compute pairwise cross-correlations between all CeA and DRN ROI pairs. First-differenced signals are used to improve stationarity. `cross_corr.m` provides a simpler non-differenced version.

2. **Auto-correlation** — Run `auto_corr_diff.m` on a loaded `_adj_ROI.mat` file to examine within-region temporal structure for the CeA or DRN.

3. **Mutual Information** — Run `behlick_MI.m` to compute mutual information between each ROI's calcium signal and the mouse's licking behavior across all mice. Requires `BehaviorTally.mat` and all per-mouse `_adj_ROI.mat` files to be accessible.

4. **Summary Figures** — Run `MakeMatCrossCorr.m` to compile cross-correlation lags and rho values into summary matrices, then `MakeFigCrossCorr.m` to produce the per-mouse heatmap figure. Run `MI_boxplot.m` and `Frame_lag_boxplot.m` for group-level boxplot summaries.

5. **Group Signal Plots** — Run `plot_across_mice.m` to overlay ΔF/F signals from all Formalin and PBS mice in a single figure.

---

## Data Description

### Mouse Groups
| Group | Mouse IDs | Description |
|-------|-----------|-------------|
| Formalin | E, L, M, N | Pain model; injected with formalin in the hindpaw |
| PBS | I, P, Q, R | Controls; injected with phosphate-buffered saline |

### Brain Regions
| Region | Sensor | Plot Color |
|--------|--------|------------|
| CeA / CeLC (Central Amygdala) | Device 1 | Blue |
| DRN (Dorsal Raphe Nucleus) | Device 2 | Red |

### Signal Processing Summary
| Step | Description |
|------|-------------|
| Background subtraction | Fixed-pattern noise (FPN) removed using each file's background frame |
| Hum removal | Electrical noise removed by subtracting the column-wise spatial mean |
| ΔF/F | (F − F₀) / F₀, where F₀ is the mean of a pre-injection reference window |
| ROI extraction | Rectangular pixel patches manually defined on the ΔF/F heatmap |

---

## Notes

- **Directory layout:** Pipeline scripts (`s0`, `s1`, `s2`) and utility functions (`f_read_pain`, `plot_mean`, etc.) must be on the MATLAB path. The scripts expect raw data in a `data/` subfolder and save processed `.mat` files to a `mat/` subfolder, both located in the same directory as the scripts.
- **Workspace dependencies:** Analysis scripts (`cross_corr.m`, `auto_corr_diff.m`) consume variables already present in the MATLAB workspace from a previous pipeline step or `load()` call. Load the corresponding `_adj_ROI.mat` file before running them.
- **Frame rate:** All recordings use approximately **10.68 fps**, stored in each saved `.mat` file as `fps`.
- **Figure layout:** Visualization scripts contain hardcoded subplot grid parameters (`prow`, `pcol`) that are tuned to reproduce the published figures.
