# Core Code (MOSAiC Flux Parameterization)

## Overview

This repository contains the **core code** used in the paper.
It **does not include** the full end-to-end pipeline for processing MOSAiC data from scratch (0–1). Instead, after you **preprocess MOSAiC data following the paper** and apply a **simple formatting/cleaning step** as described below, you can reproduce all key datasets and model outputs used in the manuscript.

## What’s included / not included

### Included

* Core scripts and functions required to reproduce the main results in the paper.
* Code to generate:

  * Observation dataset: **OBS4**
  * GLGS outputs: **GLGS4**
  * LSBoost outputs: **LSBoost_results**
  * Hybrid scheme outputs: **Hybrid_results**

### Not included

* The complete 0–1 MOSAiC raw-data processing workflow (e.g., raw ingest, QC pipeline, instrument-level parsing).

## Prerequisites

1. **MOSAiC data prepared according to the paper**
   Please preprocess the MOSAiC data following the procedures described in the manuscript.
2. **Simple preprocessing step (as in the paper)**
   After the above, apply the paper’s “simple processing” step to format the MOSAiC data into the expected input structure for this codebase.

> Note: The exact format/paths depend on your local setup. Ensure your processed MOSAiC dataset is accessible to the scripts in `2.code/`.

## How to run (reproducing paper outputs)

After MOSAiC preprocessing is complete, run the scripts in `2.code` **in order**:

1. **Run 1** → Generate observation dataset

   * Output: **OBS4**

2. **Run 2** → Run GLGS scheme and generate GLGS results

   * Output: **GLGS4**

3. **Run 3** → Train/evaluate LSBoost and generate ML & hybrid outputs

   * Output:

     * **LSBoost_results**
     * **Hybrid_results**

In short:

* `2.code/1` → **OBS4**
* `2.code/2` → **GLGS4**
* `2.code/3` → **LSBoost_results** and **Hybrid_results**

## Outputs

Successful execution will produce the following main artifacts (names consistent with the manuscript):

* **OBS4**: observation dataset used in the paper
* **GLGS4**: GLGS scheme results evaluated in the paper
* **LSBoost_results**: regime-specific LSBoost model results
* **Hybrid_results**: results from the GLGS-ML hybrid scheme

## Notes

* This repository is intended for **reproducibility of the paper’s key results** once MOSAiC data have been prepared following the manuscript.
* If you encounter path or format issues, verify:

  * Your processed MOSAiC data matches the expected variable names/units/time resolution used by the scripts.
  * Output directories exist and are writable.

## Citation

If you use this code, please cite the corresponding paper.
