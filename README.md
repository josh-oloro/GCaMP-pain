# GCaMP-pain

> **MATLAB analysis pipeline for simultaneous dual-region calcium imaging of freely-moving mice during nociception**

[![DOI](https://img.shields.io/badge/DOI-10.3389%2Ffnins.2021.667708-blue)](https://doi.org/10.3389/fnins.2021.667708)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2019b%2B-orange)](https://www.mathworks.com/products/matlab.html)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📄 Publication

Rebusi R., **Olorocisimo J.P.**, Briones J., Ohta Y., Haruta M., Takehara H., Tashiro H., Sasagawa K., Ohta J. (2021).  
**Simultaneous CMOS-based imaging of calcium signaling of the central amygdala and the dorsal raphe nucleus during nociception in freely-moving mice.**  
*Frontiers in Neuroscience*, 15:667708.  
🔗 https://doi.org/10.3389/fnins.2021.667708

---

## 🧠 Overview

This repository contains the complete MATLAB analysis pipeline for a published neuroscience study investigating how two brain regions—the **Central Amygdala (CeA/CeLC)** and the **Dorsal Raphe Nucleus (DRN)**—respond to pain stimuli in real time.

Using a custom **miniature CMOS-based fluorescence imaging system** and the genetically-encoded calcium indicator **GCaMP**, we simultaneously recorded neural activity from both regions in **freely-moving mice** during a formalin-induced nociception model. This dual-site, single-animal approach is technically challenging and scientifically novel: it allows direct comparison of CeA and DRN dynamics within the same behavioral episode.

**Key scientific questions addressed:**
- Do the CeA and DRN show correlated calcium signals during pain?
- Does neural activity (ΔF/F) in these regions encode pain behavior (licking)?
- What is the temporal relationship (frame lag) between CeA and DRN activity?

---

## 🔬 Experimental Design

| Parameter | Detail |
|-----------|--------|
| **Animal model** | Freely-moving mice |
| **Pain model** | Formalin injection (4 mice) vs. PBS control (3 mice) |
| **Brain regions imaged** | Central Lateral Amygdala (CeLC) & Dorsal Raphe Nucleus (DRN) |
| **Calcium indicator** | GCaMP (genetically encoded) |
| **Imaging hardware** | Custom CMOS sensor (44 × 242 pixel array) |
| **Frame rate** | ~10.68 fps |
| **ROIs per region** | 3 manually-defined regions of interest per mouse |
| **Behavioral readout** | Lick count time series |

The CMOS sensor captures both brain regions on a single pixel array, split into two spatial segments: pixels `7:119` (CeA) and `129:241` (DRN) along the sensor's long axis.

---

## 🗂️ Repository Structure

```
GCaMP-pain/
│
├── ── Data Ingestion ──────────────────────────────────────────
│   f_read_pain.m          # Reads proprietary .raw CMOS files; applies FPN
│                          #   (Fixed Pattern Noise) correction via dark frame
│                          #   subtraction; outputs m×n×t data tensors & fps
│
├── ── Analysis Pipeline (run in order) ───────────────────────
│   s0_pain_setup.m        # Step 0: Load raw data, spatial crop, hum-noise
│                          #   removal, mean ΔF/F visualization
│   s1_pain_preprocessing.m# Step 1: ΔF/F normalization (reference-frame
│                          #   subtraction), spatial heatmap & video export
│   s2_pain_ROIselection.m # Step 2: Manual ROI definition, pixel-region
│                          #   extraction, background masking, save to .mat
│
├── ── Signal Analysis ─────────────────────────────────────────
│   cross_corr.m           # Pairwise normalized cross-correlation between
│                          #   all CeA × DRN ROI pairs; reports best lag & ρ²
│   cross_corr_diff.m      # Cross-correlation on differential (pain − baseline)
│                          #   signals
│   auto_corr_diff.m       # Auto-correlation of differential signals
│   MakeMatCrossCorr.m     # Assembles per-mouse cross-correlation matrices
│                          #   (lag & ρ) into 6×6×N tensors; saves crosscor.mat
│   MakeFigCrossCorr.m     # Publication-quality heatmap figure of |ρ| matrices
│                          #   across all 7 mice with annotated frame lags
│   FigCrossCorr.m         # Single-mouse cross-correlation figure
│
├── ── Information Theory ──────────────────────────────────────
│   discrete_continuous_info_fast.m  # Mutual information estimator for mixed
│                                    #   discrete-continuous data (Kraskov et al.,
│                                    #   PRE 2004 k-NN method); O(N log N)
│   behlick_MI.m           # Computes MI between ROI ΔF/F signals (continuous)
│                          #   and lick-count behavior (discrete) across all mice
│
├── ── Denoising ───────────────────────────────────────────────
│   hum_removal.m          # Column-mean spatial filter to remove electrical
│                          #   hum / fixed-column-pattern noise from raw frames
│   test_adjust.m          # Offset adjustment for multi-segment recordings
│                          #   (handles motion artifact gaps set to NaN)
│   sig_checker.m          # Signal quality diagnostic tool
│   allsig.m               # Aggregate signal inspection across experiments
│
├── ── Visualization ───────────────────────────────────────────
│   plot_mean.m             # Time-series line plots with SEM ribbons, injection
│                           #   period annotation, and calibrated time axis
│   plot_signals.m          # Multi-ROI overlaid signal plots
│   plot_signals_imgsc.m    # Heatmap-style signal plot (imagesc)
│   plot_multiple.m         # Grid figure for multi-mouse comparison
│   plot_across_mice.m      # Side-by-side Formalin vs. PBS group summary
│                           #   figure (CeA top, DRN middle, behavior bottom)
│   behavior_tally.m        # Renders lick behavior alongside neural traces
│   imagesc_code.m          # Spatial ΔF/F frame viewer with ROI overlays
│   breakplot_stem.m        # Stem plot with axis break for behavior data
│   breakplot_stem_x.m      # Horizontal-axis version of break stem plot
│   hDistance.m             # Helllinger distance utility for distribution
│                           #   comparison
│   PainMinusNIsolationE.m  # Pain-epoch differential signal computation
│   MI_boxplot.m            # Boxplot of MI values (Formalin vs. PBS groups)
│                           #   with significance annotation
│   Frame_lag_boxplot.m     # Boxplot of frame lags (Formalin vs. PBS groups)
│                           #   with significance bracket
│
├── ── Saved Data ──────────────────────────────────────────────
│   BehaviorTally.mat       # Lick-count behavioral data for all mice
│   crosscor.mat            # Precomputed cross-correlation matrices
│   E_Pain_adj_ROI.mat      # Formalin mouse E: ΔF/F + ROI coordinates
│   I_PBS_adj_ROI.mat       # PBS control mouse I: ΔF/F + ROI coordinates
```

---

## ⚙️ Analysis Pipeline

The pipeline flows through three ordered scripts followed by independent analysis modules:

```
Raw .raw files
      │
      ▼
 f_read_pain.m ──── Parses binary CMOS format, dark-frame FPN correction,
      │              assembles m×n×t tensor, computes fps from frame headers
      │
 s0_pain_setup.m ── Spatial crop (CeA: cols 7–119, DRN: cols 129–241),
      │              column-mean hum removal (hum_removal.m), mean+SEM plot
      │
 s1_pain_preprocessing.m
      │              Reference-frame ΔF/F = (F − F₀)/F₀ where F₀ is the
      │              mean of a pre-stimulus baseline window
      │              → Optional video export of ΔF/F heatmap
      │              → Saves: *_Pain_adj.mat
      │
 s2_pain_ROIselection.m
      │              Manual rectangular ROI placement on spatial heatmap,
      │              background masking (ROI pixels set to NaN),
      │              mean ± SEM time series extracted per ROI
      │              → Saves: *_Pain_adj_ROI.mat
      │
      ├── cross_corr.m ────── Pairwise xcorr (CeA ROIs × DRN ROIs)
      │                        Reports: best lag (frames), max ρ²
      │
      ├── MakeMatCrossCorr.m ─ Batch: builds 6×6×7 lag & ρ matrices
      │   MakeFigCrossCorr.m ─ Figure: |ρ| heatmaps + lag annotations
      │
      └── behlick_MI.m ────── Mutual information: I(lick behavior; ΔF/F)
              │                Uses Kraskov k-NN estimator (k=3, natural log)
              │                Bins continuous ROI signal to behavioral epochs
              └── MI_boxplot.m, Frame_lag_boxplot.m ── Statistical figures
```

---

## 🔑 Key Algorithms

### 1. Fixed Pattern Noise (FPN) Correction
Raw CMOS output includes per-pixel offset bias. Each recording file embeds a dark-frame background image (`bg_image`). The corrected signal is:

```
normal_image = bg_image − image_data
```

### 2. Column-Mean Hum Removal
Electrical hum appears as a correlated offset across all rows in a column. Removed by subtracting the deviation of each column's mean from the global mean:

```matlab
function data_denoise = hum_removal(data)
    ave1 = mean(data, 1);                          % col means: 1 × n × t
    ave2 = repmat(mean(ave1), 1, size(data,2), 1); % global mean broadcast
    ave3 = repmat(ave1 - ave2, size(data,1), 1, 1);
    data_denoise = data - ave3;
end
```

### 3. ΔF/F Normalization
Standard neuroimaging relative fluorescence change:

```
ΔF/F = (F(t) − F₀) / F₀
```

where `F₀` is the pixel-wise mean over a pre-stimulus reference window (frames 3110–6500).

### 4. Cross-Correlation Analysis
All 9 pairwise combinations of CeA (3 ROIs) × DRN (3 ROIs) are tested using normalized cross-correlation (`xcorr(..., 'coeff')`). The lag at peak correlation identifies the temporal lead/lag relationship between the two regions.

### 5. Mutual Information (Kraskov k-NN Estimator)
To quantify how much pain behavior (discrete lick counts) is encoded in continuous neural signals (ΔF/F), we use the mixed discrete-continuous mutual information estimator from:

> Kraskov A., Stögbauer H., Grassberger P. (2004). *Estimating Mutual Information*. Physical Review E, 69(6).

The implementation (`discrete_continuous_info_fast.m`) uses k=3 nearest neighbors and runs in O(N log N) time via binary search.

---

## 🖥️ Requirements

- **MATLAB** R2019b or later
- No additional toolboxes are strictly required; `xcorr` is from the Signal Processing Toolbox (used in `cross_corr.m`)
- Raw CMOS recording files (`.raw`) — binary format proprietary to the Ohta Lab imaging system

**Expected directory layout:**
```
project_root/
├── data/        ← place raw .raw recording files here
├── mat/         ← generated .mat files saved here by pipeline
├── Videos/      ← optional video output from s1_pain_preprocessing.m
└── *.m          ← all scripts in this repository
```

---

## 🚀 Getting Started

### 1. Ingest raw recordings
Place all `.raw` CMOS recording files in the `data/` folder, then run:
```matlab
% In s0_pain_setup.m, set your experiment folder name:
DATA_FOLDER = 'E - NEW Pain experiment 1';
run('s0_pain_setup.m')
```

### 2. Compute ΔF/F and visualize
```matlab
run('s1_pain_preprocessing.m')
% Optionally export a video of the ΔF/F heatmap when prompted
```

### 3. Define ROIs
```matlab
run('s2_pain_ROIselection.m')
% Manually edit the ROI coordinate variables (A_ROI*_xs/xe/ys/ye) to match
% your spatial heatmap before running
```

### 4. Cross-correlation analysis (single mouse)
```matlab
% After loading an *_adj_ROI.mat file:
run('cross_corr.m')
```

### 5. Batch cross-correlation across all mice
```matlab
run('MakeMatCrossCorr.m')   % builds crosscor.mat
run('MakeFigCrossCorr.m')   % renders publication figure
```

### 6. Mutual information: neural activity vs. behavior
```matlab
% Requires *_Pain_adj_ROI.mat files for all mice and BehaviorTally.mat
run('behlick_MI.m')
run('MI_boxplot.m')
```

---

## 📊 Key Results (from published paper)

- CeA and DRN calcium signals show **significantly higher cross-correlation** in formalin-injected mice compared to PBS controls, indicating coordinated pain-state activity.
- Frame-lag analysis reveals that CeA and DRN activity are **nearly synchronous** (≤ 1 frame lag, ~100 ms) in most formalin mice, while PBS mice show larger, more variable lags.
- Mutual information between ROI ΔF/F and lick behavior is **significantly greater in formalin mice** (CeA and DRN), demonstrating that both regions encode nociceptive behavior.

---

## 👥 Authors & Affiliations

**Joshua Philippe Olorocisimo** · Rebusi R. · Briones J. · Ohta Y. · Haruta M. · Takehara H. · Tashiro H. · Sasagawa K. · Ohta J.

Nara Institute of Science and Technology, Japan
olorocisimo.joshua.od9@ms.naist.jp

---

## 📚 Citation

If you use this code in your research, please cite:

```bibtex
@article{rebusi2021simultaneous,
  title     = {Simultaneous CMOS-based imaging of calcium signaling of the
               central amygdala and the dorsal raphe nucleus during nociception
               in freely-moving mice},
  author    = {Rebusi, R. and Olorocisimo, J.P. and Briones, J. and Ohta, Y.
               and Haruta, M. and Takehara, H. and Tashiro, H. and
               Sasagawa, K. and Ohta, J.},
  journal   = {Frontiers in Neuroscience},
  volume    = {15},
  pages     = {667708},
  year      = {2021},
  doi       = {10.3389/fnins.2021.667708}
}
```
