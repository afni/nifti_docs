
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


Occasionally asked questions
=============================

What are NIfTI and the DFWG?
------------------------------------------

(Mike Huerta)

The purpose of the Neuroimaging Informatics Technology Initiative
(NIfTI) is to support service, training, and research to develop
and enhance the utility of informatics tools used in neuroimaging,
with a focus on functional magnetic resonance imaging (fMRI). NIfTI
is jointly sponsored by the National Institute of Mental Health
(NIMH) and the National Institute of Neurological Disorders and
Stroke (NINDS), which are part of the National Institutes of Health
(NIH) and the Department of Health and Human Services
(DHHS). Further background can be found at this link. NIfTI was
developed and has been implemented with input from the community of
neuroscientists who use neuroimaging in their research, and from
the community of developers of informatics tools used to make sense
of neuroimaging data (with an emphasis on fMRI).

There are two major activities of NIfTI, thus far. The first is the
support of a cluster of grants to characterize, compare, and
validate informatics tools used in fMRI studies.

The second is the support of the Data Format Working Group. The
DFWG is charged with arriving at a technical solution to the
problem of multiple data formats used in fMRI research. This was
identified by many investigators as a fundamental obstacle to fMRI
fulfilling the promise it has to elucidate brain function. The
solution arrived at by the DFWG will not be imposed on the research
community, but several groups that develop fMRI-related software
have already indicated their willingness to adopt the
solution. Suggestions for membership on the DFWG were broadly
solicited from the research community.

The original DFWG members are listed :ref:`here <nifti_dfwg>`

It should be noted that in no way is the NIfTI-1 format an official
format whose use is mandated by the NIH. This effort has been made
to help developers and users of functional neuroimaging
software. What use is made of the format is now up to the
community.

Why didn't the committee choose the DICOM or MINC-2 formats? 
----------------------------------------------------------------------

.. by: *(Steve Strother)*

**DICOM:** The DICOM standard attempts to address the extremely general
requirements of digital imaging in diagnostic and therapeutic
healthcare environments (http://medical.nema.org/dicom/), while the
DFWG has a much narrower focus. The DFWG committee's strategy has
been to adopt a two-pronged approach to developing a technical
solution to the problem of multiple fMRI data formats by initially
focusing on a relatively simple format that has low storage
overhead, resolves some immediate format problems in the fMRI
community and is not difficult for developers to learn and use. The
NIfTI-1 format specification represents the simple first prong of
this approach with the goal of consolidating the variants of the
ANALYZE 7.5 format currently being used by the major fMRI software
packages while staying mostly ANALYZE 7.5 compatible and explicitly
dealing with the specification and storage of a data coordinate
system.

The committee felt that DICOM did not satisfy the general
requirements of a simple format for the fMRI community with DICOM's
large, clinically focused storage overhead and the relatively
complex specifications for multiframe MRI and spatial
registration. In addition, the DICOM specification is also heavily
concerned with data communication, something the committee felt was
well beyond the scope of NIfTI-1.

**MINC-2:** The DFWG committee is very aware of the latest MINC
developments through Colin Holmes' able and enthusiastic advocacy
of MINC to the committee. MINC is being actively and seriously
considered as a candidate for a NIfTI-2 format specification (see
below). In addition, we have been provided with MINC 1.0 namespace
(7/5/2003) and MINC 2.0 file format (11/18/2003) documents by
Robert Vincent in Montreal. Most of the DFWG committee meet with
Alan Evans, John Sled, Robert Vincent and several others to discuss
MINC and its proposed developments at the last OHBM meeting in New
York.

**NIfTI-2:** The second prong of the committee's approach (NIfTI-2)
will be a more complex format specification to address the problem
of comprehensive data interchange within the fMRI research
community. Development of NIfTI-2 and inclusion of specifications
for such data as nonlinear registrations, surfaces and various
types of metadata (e.g., data analysis design matrices) are under
discussion by the committee.


Can you add my favorite variable X to the header?
-----------------------------------------------------------------

.. by: *(Jeff Woodward)*

*[Temporary answer by RW Cox]* Not very likely. We stayed within the
restriction of a 348 byte header to keep compatibility with ANALYZE
7.5. Most of the space is now taken by new fields, agreed upon by the
DFWG committee after extensive wrangling.

What is the minimum set of fields required to create a NIfTI-1 header? 
------------------------------------------------------------------------

.. by: *(Christian Haselgrove)*

While not all of the NIfTI-1 header fields are necessary to describe a
volume, most fields require a specific value to indicate the field's
non-use.

Required fields are::

    FIELD         NOTES
    -----------------------------------------------------
    sizeof_hdr    must be 348
    -----------------------------------------------------
    dim           dim[0] and dim[1] are always required; 
                  dim[2] is required for 2-D volumes, 
                  dim[3] for 3-D volumes, etc.
    -----------------------------------------------------
    datatype      needed to specify type of image data
    -----------------------------------------------------
    bitpix        should correspond correctly to datatype
    -----------------------------------------------------
    pixdim        with the exception of pixdim[0] (which 
                  is required when qform_code != 0), 
                  pixdim[n] is required when dim[n] is 
                  required
    -----------------------------------------------------
    vox_offset    required for an "n+1" header
    -----------------------------------------------------
    magic         must be "ni1\0" or "n+1\0"
    -----------------------------------------------------

The descrip and aux_file fields are not required. The NIfTI-1 standard
does not specify any use or interpretation of these fields.

The remaining fields are not required, but their non-use must be
indicated as in the following table. The simplest way to ensure this
when creating a 348-byte header structure is to fill it with zeros
(e.g., with calloc()) before setting any desired fields to their
appropriate values. The non-required fields are::

    FIELD           NON-USE INDICATOR
    ---------------------------------------------------
    intent_code    intent_code = NIFTI_INTENT_NONE = 0
    intent_name    and intent_name[0] = '\0'
    intent_p1
    intent_p2
    intent_p3
    ---------------------------------------------------
    scl_slope      scl_slope = 0
    scl_inter
    ---------------------------------------------------
    xyzt_units     xyzt_units = NIFTI_UNITS_UNKNOWN = 0
    ---------------------------------------------------
    cal_max        cal_max = 0 and cal_min = 0
    cal_min
    ---------------------------------------------------
    toffset        toffset = 0
    ---------------------------------------------------
    slice_code     slice_code = 0 and dim_info = 0
    dim_info
    slice_start
    slice_end
    slice_duration
    ---------------------------------------------------
    qform_code     qform_code = 0 (see note below)
    quatern_b
    quatern_c
    quatern_d
    qoffset_x
    qoffset_y
    qoffset_z
    pixdim[0]
    ---------------------------------------------------
    sform_code     sform_code = 0
    srow_x
    srow_y
    srow_z
    ---------------------------------------------------


**NB:** Using ``qform_code=0`` is legal, but not recommended. This case
is intended for the case when you don't want to encode any orientation
information in the header. It is mainly intended for compatibility
with older ANALYZE 7.5 files; however, the ANALYZE 7.5 orient field is
not contained in a NIfTI-1 header. If ``qform_code=0``, a program may
treat the orientation of a NIfTI-1 file in any way; this is unlikely
to be portable or inter-operable.


What format converters are available?
-------------------------------------

.. by: (David Rex)

*Not answered in original docs!*



