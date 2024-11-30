
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

This list of Q&A was created early in the original NIfTI development
process. Some of these questions have since been addressed and the
answers updated a bit here (denoted with *"Update:"*).

If you think other answers should be updated, please let us know.

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

Required fields are:

.. code-block:: none

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
appropriate values. The non-required fields are:

.. code-block: none

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


What I/O libraries are available?
---------------------------------

.. by: (Kate Fissell)

The first I/O library for NIfTI-1 was a `C/C++ library
<https://github.com/NIFTI-Imaging/nifti_clib>`_ (which has
subsequently grown in development), with the following principal
files:

* ``nifti1.h``: the header file for the NIfTI-1 format

* ``nifti1_io.c``: the I/O functions for the NIfTI-1 format

* ``nifti1_io.h``: the header file for the I/O functions for the
  NIfTI-1 format.

* ``nifti1_test.c``: a short sample program to read and write NIfTI-1
  files.

These files were contributed by Robert Cox (NIH) and contain functions
to read and write NIfTI-1 headers and data blocks, print header
fields, and, functions to manipulate some of the more complicated data
items in the NIfTI-1 header (e.g., transform matrices).

*Update*: Since initial development, I/O libraries exist in `Matlab
<https://github.com/NIFTI-Imaging/nifti_matlab>`_ and `Java
<https://github.com/NIFTI-Imaging/nifti_java>`_, and other libraries
are welcome.  The full set of libraries is available via the `main
NIfTI GitHub repository <https://github.com/NIFTI-Imaging>`_.

How do I tell if an ANALYZE header is NIfTI-1 compatible? 
---------------------------------------------------------

.. by: (Christian Haselgrove)

NIfTI-1 headers must contain a specific sequence of bytes in the last
four bytes of the header (bytes 344-348):

* When there is a separate file for the image data, these bytes must
  be "ni1\0" (hexadecimal 6e 69 31 00).
* When the image data is in the same file as the header, these bytes
  must be "n+1\0" (hexadecimal 6e 2b 31 00).

If neither of these conditions is satisfied, then a program should not
presume that the NIfTI-1 additions/changes to the ANALYZE format are
present in the header.


Is NIfTI-1 compatible with the ANALYZE 7.5 file format? 
--------------------------------------------------------

.. by: (Jeff Woodward)

*[Temporary answer by RW Cox]* **We hope so.** The interpretation of
many of the fields in the ANALYZE 7.5 header is not very clear. Most
such fields aren't widely used by software other than ANALYZE
itself. After considerable discussion, we kept the ANALYZE 7.5-defined
fields that seemed widely used in the FMRI community. The goal was to
have non-NIfTI-aware FMRI packages that use the ANALYZE 7.5 format
still be able to read most NIfTI-1 files. Time and experience will
tell if this goal has been met.


Do I need to convert all of my files to this format?
----------------------------------------------------

.. by:  (Colin Holmes)

**No.** NIfTI-1 was created to provide a common and widely acceptable
version of the ANALYZE-7.5 format that could act as an image data
interchange format between neuroimaging programs and analysis
packages. As it provides little support for storage of required
metadata (e.g., image acquisition parameters), it is not a complete
solution for long-term archiving of neuroimaging data. **For this
function, please see the NIfTI-2 format (coming soon to a lab near
you).**


Is the NIfTI-1 header extensible?
------------------------------------

.. by: (Hester Breman)

The NIfTI-1 files can exist in two forms. There can be a single *.nii
file or two separate files, a ``*.hdr`` and a ``*.img`` file (see the
NIfTI-1 header file for more details).

When the information is separated into a ``*.hdr`` and ``*.img`` file,
which resembles the original ANALYZE 7.5 format, any programs that
read the ANALYZE format will expect a header of 348 bytes. Therefore
the NIfTI-1 header is not extensible in this form, since any program
is likely to fail when it detects that the header file is not the
expected size.

While it is possible to store data between the header and the image
part of a single ``*.nii`` file, this is non-standard and no other
program will will be able to interpret these data. Therefore it is not
recommended to produce such files.

In the current NIfTI-1 format, there are many possibilities to store
different kinds of data in the image part of the file. Datasets, many
types of statistical values, vectors, meshes, etc., all can be stored
in NIfTI-1. Each NIfTI-1-aware program will be able to read these
files. Interpretation of the files will also be possible, since the
meaning of the fields is determined, when the intent of the file is
known.

For any other types of data that cannot be stored in the NIfTI-1
format, eventually a NIfTI-2 format for complex data is to come.

What modalities does this format support? 
------------------------------------------

.. by:(Colin Holmes)

NIfTI-1 can store image data from any modality such as PET, MRI, CT,
EEG that produces regularly sampled 1-5D rasters. No support is
provided for modality-specific metadata such as dose, pulse sequence
or indeed the majority of subject oriented descriptive items.

A limited amount of information specific to FMRI time series
acquisition is available in the NIfTI-1 header:

* Marking the frequency, phase, and slice encoding directions.

* Storing the per-slice acquisition time.

* Storing the slice acquisition order (e.g., interleaving).

This particular information is present since the primary thrust of the
DFWG has been to make FMRI data analysis software inter-operable.


What types of data can I store in the format? 
----------------------------------------------

.. by: (Colin Holmes)

NIfTI-1 provides support for regularly sampled raster-oriented data of
up to five dimensions (e.g., image data). The data type of each value
stored in the raster grid must be the same, and is indicated in the
datatype header field. These data types are intended to encompass a
wide range of commonly usages. Expressed in C language syntax, these
basic data types are:

.. code-block:: C

   unsigned char      = 8-bit byte     [     0..  255]
   signed char        = 8-bit byte     [  -128..  127]
   signed short       = 16-bit integer [-32768..32767]
   unsigned short     = 16-bit integer [     0..65535]
   signed int         = 32-bit integer
   unsigned int       = 32-bit integer
   signed long long   = 64-bit integer
   unsigned long long = 64-bit integer

   float              = 32-bit floating point value
   double             = 64-bit floating point value
   long double        = 128-bit floating point value

   { float r,i ; }    = 64-bit complex = 2 32-bit floats
   { double r,i ; }   = 128-bit complex = 2 64-bit floats
   {long double r,i;} = 256-bit complex = 2 128-bit floats

   {unsigned char r,g,b;} = RGB triple = 3 8-bit bytes

Not all data types will be supported by all programs; in fact, most
programs will probably only operate on a limited set of these data
types. A well-crafted NIfTI-1 compatible program should detect when it
cannot deal with an input file's data type, and exit gracefully.

The first 3 dimensions are reserved for space; the fourth dimension
for time (or frequency); the fifth dimension is intended to allow
storing multiple values at each spatio-temporal location. In addition,
the intent_code field can be used to describe if and how the fifth
dimension of the image data is organized. Possible organizations
include vector, general matrix, symmetric matrix, and quaternion.

NIfTI-1 does not provide for the storage of data sets defined over
irregularly sampled domains, such as cortical surface models. Nor does
NIfTI-1 provide for storage of the definitions of such domains.


Does NIfTI-1 solve the problem of data interchange in fMRI? 
-------------------------------------------------------------

.. by: (Colin Holmes)

*Yes and no.* NIfTI-1 can act as a conduit for image data (only) being
exchanged between programs in an analysis sequence. It does not
provide for the long-term and complete storage of image and metadata
and associated computed results (e.g., surfaces) that is necessary to
provide for the complete and robust preservation of data for
historical, archival or full-fledged interlaboratory exchange of
neuroimaging data.


What is the default orientation? 
-----------------------------------

.. by: (John Ashburner)

The NIfTI format allows storage on disk to be in either a left- or
right-handed coordinate system. However, the format includes an
implicit spatial transformation into a RIGHT-HANDED coordinate
system. This transform maps from data coordinates (e.g. column i, row
j, slice k), into some real world (x,y,z) positions in space. These
positions could relate to Talairach-Tournoux (T&T) space, MNI space,
or patient-based scanner coordinates.

For T&T, and MNI coordinates, x increases from left to right, y
increases from posterior to anterior, and z increases in the inferior
to superior direction. Directions in the scanner coordinate system are
similar. MRI data is usually exported as DICOM format, which encodes
the positions and orientations of the slices. When data are converted
from DICOM to NIfTI-1 format, the relevant information can be
determined from the Pixel Spacing, Image Orientation (Patient) and
Image Position (Patient) fields of the DICOM files.

NIfTI-1 also allows the space of one image to be mapped to that of
another (via a rigid or affine transform). This is to enable
on-the-fly resampling of registered images. This would allow
intra-subject images, collected with lots of different orientations or
resolutions, to be treated as if they are all in register.

Is radiological or neurological orientation default?
--------------------------------------------------------

.. by: (John Ashburner)

Neurological and radiological conventions only relate to visualization
of axial images. They are unrelated to how the data are stored on
disk, or even how the real-world coordinates are represented.

It is more appropriate to consider whether the real-world coordinate
system is left- or right-handed (see below). Talairach and Tournoux
use a right-handed system, whereas the storage convention of ANALYZE
files is usually considered as left-handed. These coordinate systems
are mirror images of each other (if you are a psychologist, try
explaining why mirror images appear to be left-right flipped, rather
than flipped up-down, or back-front). Transforming between left- and
right-handed coordinate systems involves flipping, and can not be done
by rotations alone.

.. list-table:: 
   :header-rows: 0
   :widths: 75

   * - .. image:: media/img_nifti1_handedness.gif
          :width: 100%
          :align: center

What is a quaternion? 
-----------------------

.. by: (Bob Cox)

A quaternion is a mathematical object that contains 4 real
numbers. Historically, quaternions were discovered by William Rowan
Hamilton in 1843. This antedates the discovery of vectors and
matrices, which are more widely taught in modern times.

Like real and complex numbers, quaternions can be added and
multiplied. Unlike real and complex numbers, the order in which
quaternions are multiplied makes a difference. In Hamilton's notation,
which is still used, a quaternion is represented as the sum of 4 real
numbers times the basis symbols 1, i, j, and k; for example:

.. code-block:: none

   q = a 1 + b i + c j + d k
   p = u 1 + v i + w j + x k

Quaterions are added component by component. Multiplication is done
via the following rules:

.. code-block:: none

   1 * X =  X   [for any X]
   i * j =  k
   j * i = -k   [anti-commutative]
   j * k =  i
   k * j = -i   [anti-commutative]
   k * i =  j
   i * k = -j   [anti-commutative]

   i * i = -1   [each of i, j, and k   ]
   j * j = -1   [is a square root of -1]
   k * k = -1

So the example quaternions above multiply out to:

.. code-block:: none

    q*p = (a*u-b*v-c*w-d*x) 1 + (a*v+b*u+c*x-d*w) i
          +(a*w-b*x+c*u+d*v) j + (a*x+b*w-c*v+d*u) k

A principal application of quaternions is to represent 3D
rotations. How this is done is described in great detail in the
NIfTI-1 C header, and also here. The reason this representation is
used in NIfTI-1 is to save space in the 348-byte header; a quaternion
only requires 4 floats (16 bytes) to specify, but a 3x3 matrix
requires 9 floats (36 bytes). The nifti1_io.c I/O library contains
functions to convert quaternions to rotation matrices, and vice-versa.

