
.. _format_nifti2:

***********************
**NIfTI-2 Data Format**
***********************

.. contents:: :local:


Introduction
============

The NIfTI committee, in conjunction with public discussion on the
`NITRC forum <https://www.nitrc.org/forum/forum.php?forum_id=1941>`_,
have created a final version for the NIfTI-2 format that is a very
simple extension of the current :ref:`NIfTI-1 format <format_nifti1>`,
but updated to allow 64-bit storage and addressing for large images
and matrices.

It is intended that this format:

* will enable the storage of large images and matrices, with all
  dimensions being coded by 64-bit integers rather than the current
  limitation of 16-bit signed integers (which currently gives a
  restrictive 32767 size limit in each dimension)
    
* will be very simple to implement and update software (a couple of
  hours coding or less generally)
    
* contains the same information and logic as a NIfTI-1 file (no new
  fields and all current fields still retained)
    
* will support the existing file formats and naming: a ``.nii``
  single-file, a ``.hdr/.img`` file-pair and their gzipped versions
    
* has a very simple test (see below) to determine if the file is
  NIfTI-1 or NIfTI-2
    
* does not replace NIfTI-1 in the short term but is supported
  alongside it


Documentation
--------------

The following contain information on the formal specification: **NEED
TO ADD LINKS HERE**


* Description of NIfTI-2 Fields

  * description matches that of the NIfTI-1.1 Fields of the NIfTI-1
    header file

  * field types and field order have been altered

  * extensions match those of NIfTI-1.1 when the extender bytes are
    ``1 0 0 0``

  * in the future, extenders may be added using other byte sequences


Test Data Sets
---------------

**to be added**

Supporting Software
-------------------

The following packages have all agreed to support hte NIfTI-2 version,
but that NIfTI-1 will remain a default output, or a configurable
default, in the short-term:

* AFNI, BrainVisa, BrainVoyager, Caret, Connectome Workbench,
  Fiswidgets, FreeSurfer, FSL, ITK, LONI-DIRAC, Mango, MRIcron,
  NiBabel, R, SPM and TractoR

The sourceforge supporting libraries in niftilib will be updated so
that they seemlessly support both NIfTI-1 and NIfTI-2.

Conversion utilities to and from NIfTI-1 will be made available via
GitHub as well as in some of the software packages mentioned above.
