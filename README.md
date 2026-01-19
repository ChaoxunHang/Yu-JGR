# Thesis Core Code (MOSAiC Flux Parameterization)

## Overview

This repository contains the **core MATLAB code** used in the paper.
It **does not include** the full end-to-end (0–1) workflow for processing raw MOSAiC data. Instead, after you preprocess MOSAiC data following the procedures described in the manuscript, you can run the scripts below to reproduce the key datasets and model outputs used in the paper.

## Files in this repo

* `yu_0_OBS0.m`
  Generates an initial observation dataset (**OBS0**) as an intermediate product.

* `yu_1_OBS4.m`
  Generates the observation dataset used in the paper (**OBS4**).

* `yu_2_GLGS4.m`
  Runs the GLGS bulk scheme and outputs the paper’s GLGS results (**GLGS4**).

* `yu_3_LSBoostAndHybrid.m`
  Produces:

  * **LSBoost_results** (regime-specific LSBoost results)
  * **Hybrid_results** (GLGS-ML Hybrid scheme results)

## What’s included / not included

### Included

* Core scripts required to reproduce:

  * Observation dataset: **OBS4**
  * GLGS outputs: **GLGS4**
  * LSBoost outputs: **LSBoost_results**
  * Hybrid outputs: **Hybrid_results**

### Not included

* Full raw MOSAiC data ingestion and 0–1 preprocessing pipeline.
* Raw MOSAiC files.

## Prerequisites

1. **MOSAiC data prepared according to the paper**
   Please preprocess MOSAiC data following the procedures described in the manuscript.

2. **MATLAB environment**

* MATLAB installed (version not strictly required, but a recent release is recommended).
* Make sure this repository folder is added to the MATLAB path:

  * Either open MATLAB in this folder, or run `addpath(genpath(pwd))`.

> Note: The scripts expect the preprocessed MOSAiC data to be available in the location/format described in the paper (or as configured inside each script).

## How to run (recommended order)

After preprocessing MOSAiC data according to the paper, run the scripts in order:

1. Generate intermediate observation dataset

* Run: `yu_0_OBS0.m`
* Output: **OBS0** (intermediate)

2. Generate observation dataset used in the paper

* Run: `yu_1_OBS4.m`
* Output: **OBS4**

3. Run GLGS and generate GLGS results

* Run: `yu_2_GLGS4.m`
