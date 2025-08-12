
.. _format_nifti1:

***********************
**NIfTI-1 Data Format**
***********************

.. contents:: :local:


Introduction
============

NIfTI-1 is adapted from the widely used ANALYZE (TM) 7.5 file
format. The hope is that older non-NIfTI-aware software that uses the
ANALYZE 7.5 format will still be compatible with NIfTI-1. NIfTI-1 uses
the "empty space" in the ANALYZE 7.5 header to add several new
features. These innovations are summarized in the :download:`OHBM-2004
poster <media/hbm_nifti_2004.pdf>`, and include the following features:

* Affine coordinate definitions relating voxel index (i,j,k) to
  spatial location (x,y,z);

* Codes to indicate spatio-temporal slice ordering for FMRI;

* "Complete" set of 8-128 bit data types;

* Standardized way to store vector-valued datasets over 1-4
  dimensional domains;

* Codes to indicate data "meaning";
    
* A standardized way to add "extension" data to the header;
    
* Dual file (`.hdr` and `.img`) or single file (`.nii`) storage; 

\.\.\. and many more. The goal is to foster interoperability at the
file-exchange level between FMRI data analysis software packages. The
authors of AFNI, BrainVoyager, FSL, and SPM have all committed to
support this format for both input and output.

**Note:** The specification is now called *NIfTI-1.1*, with the
finalization of the format for "extension" data, and a few other minor
tweaks to the format that took place in early 2005.


Documentation
=============

This PDF describes NIFTI-1 data: :download:`The NIfTI-1 Data Format
<media/TheNIfTI1Format2004.pdf>`.

The following are items that provide summaries:

* :download:`OHBM-2004 poster <media/hbm_nifti_2004.pdf>`

* :download:`PDF Diagrams of the NIfTI-1.1 file structure
  <media/nifti1diagrams_v2.pdf>`

The following contain information on the formal specification:

* `NIfTI-1 header file
  <https://github.com/NIFTI-Imaging/nifti_clib/blob/master/niftilib/nifti1.h>`_:
  C library header file that defines the NIfTI-1.1 format

* Description of NIfTI-1.1 Fields with links to other useful cross
  references

* :download:`Statistical codes PDF <media/nifti_stats.pdf>`: documentation
  for NIfTI-1 statistical codes and sample C library for statistical
  distributions.

* :download:`Analyze usage PDF <media/Analyze_usage.pdf>`: file
  showing how different FMRI software packages use the ANALYZE 7.5
  fields in the `.hdr` file. (Deciding what was commonly used in FMRI
  data analysis was the first step in deciding which parts of the
  ANALYZE 7.5 format were "empty" and could be reclaimed for other
  purposes.)


**NB:** All NIfTI-1 C library code is released into the public domain.
Please see :ref:`here <code_repo>` for download information.

