
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


NIfTI-1 Test Data Sets
================================

Valid test data sets of 3D (structural) and 4D (functional) images in
NIfTI-1 format.

Note: ``nifti_tool`` is part of the reference NIfTI implementation, and
``avwhd`` is part of FSL.

3D Structural Images
---------------------------

**Labeled LR Standard (MNI152) Images in Nifti Format**

Two images in nifti1 format (dual file or single file) in MNI152
space, with appropriate sform and qform (gzipped for convenient
transfer). *NB:* The first image (LR) is stored in radiological
convention. The second image (RL) is stored in neurological
convention. Any nifti-1 compliant viewing software should display
these images identically:


* | :download:`avg152T1_LR_nifti.hdr.gz <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_LR_nifti.hdr.gz>` and :download:`avg152T1_LR_nifti.img.gz <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_LR_nifti.img.gz>`, or
  | :download:`avg152T1_LR_nifti.nii.gz <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_LR_nifti.nii.gz>`
  | dimensions: ``91 x 109 x 91`` ; ``2mm x 2mm x 2mm``
  | text header dumps by: :download:`nifti_tool <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_LR_nifti_ntool.txt>` and :download:`avwhd <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_LR_nifti_avwhd.txt>`


* | :download:`avg152T1_RL_nifti.hdr.gz <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_RL_nifti.hdr.gz>` and :download:`avg152T1_RL_nifti.img.gz <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_RL_nifti.img.gz>`, or
  | :download:`avg152T1_RL_nifti.nii.gz <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_RL_nifti.nii.gz>`
  | dimensions: ``91 x 109 x 91`` ; ``2mm x 2mm x 2mm``
  | text header dumps by: :download:`nifti_tool <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_RL_nifti_ntool.txt>` and :download:`avwhd <https://nifti.nimh.nih.gov/nifti-1/data/avg152T1_RL_nifti_avwhd.txt>`



**Statistic Image**

A single z-statistic image in gzipped single file nifti-1 form 

* | :download:`zstat1.nii.gz <https://nifti.nimh.nih.gov/nifti-1/data/zstat1.nii.gz>`
  | dimensions: ``64 x 64 x 21`` ; ``4mm x 4mm x 6mm`` 
  | text header dumps by: :download:`nifti_tool <https://nifti.nimh.nih.gov/nifti-1/data/zstat1_ntool.txt>` and :download:`avwhd <https://nifti.nimh.nih.gov/nifti-1/data/zstat1_avwhd.txt>`


4D Functional Images
---------------------------

**Simple Time-series or multi-volume image**

A simple image time-series in gzipped single file nifti-1 form.

* | :download:`filtered_func_data.nii.gz <https://nifti.nimh.nih.gov/nifti-1/data/filtered_func_data.nii.gz>`
  | dimensions: ``64 x 64 x 21 x 180`` ; ``4mm x 4mm x 6mm x 3sec`` 
  | text header dumps by: :download:`nifti_tool <https://nifti.nimh.nih.gov/nifti-1/data/filtered_func_data_ntool.txt>` and :download:`avwhd <https://nifti.nimh.nih.gov/nifti-1/data/filtered_func_data_avwhd.txt>`


**Sternberg Item Recognition Paradigm (SIRP) fMRI Study + XML Extension Data**

147 volumes of a SIRP study in a single NIfTI ``*.nii`` image file
with sform and qforms properly set and an extension space consisting
of the XCEDE XML formatted E-prime task data, Quickmood assessments
acquired before and after the scanning session, and the image
acquisition parameters. The first volume of the series contains an "L"
superimposed on the left side of the volume to help in testing
implementations that read the qforms. Additionally the XML file
portion is also saved as an independent XML file for easy browsing
called ``103.1.sirp.xml``. Also includes a PDF description of task.

* | :download:`sirp_fmri_study_ver4.tar.gz <https://nifti.nimh.nih.gov/nifti-1/data/sirp_fmri_study_ver4.tar.gz>`
  | text header dumps by: :download:`nifti_tool <https://nifti.nimh.nih.gov/nifti-1/data/hdr_dump.txt>`

Minimal Nifti1 Dataset
---------------------------

The "minimal" dataset :download:`minimal.hdr
<https://nifti.nimh.nih.gov/nifti-1/data/minimal.hdr.gz>`,
:download:`minimal.img
<https://nifti.nimh.nih.gov/nifti-1/data/minimal.img.gz>` and
:download:`minimal.nii
<https://nifti.nimh.nih.gov/nifti-1/data/minimal.nii.gz>` is provided
as an example and test dataset. It contains close to the minimum
number of :download:`header fields
<https://nifti.nimh.nih.gov/nifti-1/data/minimal.txt>` that need to be
set in nifti1 dataset and have it still conform to the nifti1
standard. It is not the very minimum, because one could create 1
dimensional image. But, we wanted to provide a minimal dataset that
could be loaded and viewed as an image. minimal.img is a simple ramp
image, increasing from 0-63 along the Y axis. See the nifti :ref:`FAQ
question #4 <nifti_qanda_q04>` for an explanation of the minimal
fields that must be set in nifti1 datasheet.


