# T Cell Microvillus Scanning Simulation

Simulation code used for research of T Cell recognition based on mechanical
forces.

## Model

This code simulates a single microvillus as it scans an antigen presenting
surface.  T Cell receptors bind and disassociate from pMHCs present on the
surface.

## Running

The entry point of the code is `MV_scan_APC.m`.  It is currently designed as a
MATLAB function that takes a single parameter, the trajectory number to run
(useful for running multiple, parallel trajetories). Most simulation parameters
can be found and modified in this file.  The output filename and folder is
defined at the bottom of the file.  This can be changed to include important
parameters for easier identification.  The simulation currently saves the entire
MATLAB workspace at the end of the trajectory.  This can lead to fairly large
output files, especially with low sample rates.
