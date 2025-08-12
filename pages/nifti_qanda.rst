
.. _nifti_qanda:

***********************
**NIfTI Q and A**
***********************

.. contents:: :local:

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

The original DFWG members are listed :ref:`here <whatisnifti_dfwg>`

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

.. _nifti_qanda_q04:

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

   * - .. image:: media/img_nifti1_handedness.gif
          :width: 100%
          :align: center

What is a quaternion? 
-----------------------

.. by: (Bob Cox)

A quaternion is a mathematical object that contains 4 real
numbers. Historically, quaternions were discovered by `William Rowan
Hamilton <https://en.wikipedia.org/wiki/William_Rowan_Hamilton>`_
in 1843. This antedates the discovery of vectors and matrices, which
are more widely taught in modern times.

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

What alignment information is stored in the NIfTI-1 header? 
-----------------------------------------------------------

.. by: (Christian Haselgrove)

Volume orientation is given by a transformation that maps voxel
indices (i,j,k) to spatial coordinates (x,y,z), typically anatomical
coordinates assigned by the scanner. This transformation ("Method 2"
in the nifti1.h documentation) is generated using the voxel
dimensions, a quaternion encoding a rotation matrix, and a 3D shift,
all stored in the NIfTI-1 header; details can be found in the nifti1.h
comments.

The NIfTI-1 header also provides for a general affine transformation,
separate from that described by Method 2. This transformation ("Method
3") also maps voxel indices (i,j,k) to (x,y,z), which in this case are
typically coordinates in a standard space such as the Talairach
space. The elements of this transformation matrix are stored in the
NIfTI-1 header. For example, the Method 2 transformation can be
constructed from the attributes from a set of DICOM files; the Method
3 transform can be computed offline and inserted into the header
later.

The exact "meaning" of the coordinates given by the Method 2 and
Method 3 transformations is recorded in header fields qform_code and
sform_code, respectively. Code values can indicate if the (x,y,z) axes
are:

* Anatomical coordinaes from the scanner (e.g., the DICOM header)
    
* Aligned to some anatomical "truth" or standard
    
* Aligned and warped to Talairach-Tournoux coordinates
    
* Aligned and warped to MNI-152 coordinates

It is possible that neither transformation is specified (i.e.,
qform_code=sform_code=0), in which case we are left with the voxel
size in pixdim[], and no orientation is given or assumed. This use
("Method 1") is discouraged.


Does NIfTI-1 support a single file format for header and data? 
--------------------------------------------------------------

.. by: (Bob Cox)

**Yes.** In this format, the 348 byte header comes first in the
file. The image data follows. The image data offset in the file is
specified by the vox_offset field in the header. Note that the magic
field for a single file is "n+1", whereas that for a double file is
"ni1". This means that it is the contents of the header that
determines if the data is stored in the same file as the header or a
different file. The filename itself (``*.hdr`` or ``*.nii``) does not
necessarily specify the double or single storage format.

In principle, one could put arbitrary information between the header
and the image data, by making vox_offset be larger than 352. This is
not recommended. Such a file would not be compatible or portable,
which is the entire point of the NIfTI-1 effort.  **However:** also see
:ref:`this question <format_nifti1_q_custom>`!

We recommend the use of the suffix ``.nii`` for a single header+data
NIfTI-1 format file. This suffix does not have any previous meaning
attached, unlike the more obvious ``.nif`` (Navy Image File). 

.. comment: link no longer working?

   For more information on connotations of various suffixes that start
   with "n", see http://www.icdatamaster.com/n.html.


Why does NIfTI-1 allow for two coordinate systems (the qform and sform)?
------------------------------------------------------------------------- 

.. by: (Mark Jenkinson)

The basic idea behind having two coordinate systems is to allow the
image to store information about (1) the scanner coordinate system
used in the acquisition of the volume (in the qform) and (2) the
relationship to a standard coordinate system - e.g. MNI coordinates
(in the sform).

The qform allows orientation information to be kept for alignment
purposes without losing volumetric information, since the qform only
stores a rigid-body transformation which preserves volume. On the
other hand, the sform stores a general affine transformation which can
map the image coordinates into a standard coordinate system, like
Talairach or MNI, without the need to resample the image.

By having both coordinate systems, it is possible to keep the original
data (without resampling), along with information on how it was
acquired (qform) and how it relates to other images via a standard
space (sform). This ability is advantageous for many analysis
pipelines, and has previously required storing additional files along
with the image files. By using NIfTI-1 this extra information can be
kept in the image files themselves.

**Note:** the qform and sform also store information on whether the
coordinate system is left-handed or right-handed (see Q15) and so when
both are set they must be consistent, otherwise the handedness of the
coordinate system (often used to distinguish left-right order) is
unknown and the results of applying operations to such an image are
unspecified.


How is the timing of acquisition encoded in the NIfTI-1 header?
----------------------------------------------------------------

.. by: (Bob Cox)

For a few purposes, it is important to know the order and timing of
the MRI slice acquisition. The NIfTI-1.1 header contains several
fields that can be used to specify this type of information:

* **freq_dim, phase_dim, and slice_dim**: These fields encode which
  spatial dimension (1, 2, or 3) corresponds to which acquisition
  dimension for MRI data. Two examples: Rectangular scan multi-slice
  EPI:

  * Rectangular scan multi-slice EPI:

    .. code-block:: none

       freq_dim  = 1  
       phase_dim = 2  
       slice_dim = 3

    \.\.\. or some permutation of these.

  * Spiral scan multi-slice EPI: 

    .. code-block:: none

       freq_dim  = 0
       phase_dim = 0  
       slice_dim = 3
       
    \.\.\. since the concepts of frequency- and phase-encoding directions
    don't apply to spiral scan.

  * In many cases, ``freq_dim=1``, ``phase_dim=2``, and
    ``slice_dim=3`` will make sense; however, the provision of these
    codes means that it isn't necessary to store the slices in the
    NIfTI-1.1 in the same physical layout in which they were acquired.

  * The fields ``freq_dim``, ``phase_dim`` and ``slice_dim`` are all
    squished into the single byte field ``dim_info`` (2 bits each,
    since the values for each field are limited to the range
    ``0..3``). This unpleasantness is due to lack of space in the 348
    byte allowance.

  * The C macros ``DIM_INFO_TO_FREQ_DIM``, ``DIM_INFO_TO_PHASE_DIM``
    and ``DIM_INFO_TO_SLICE_DIM`` can be used to extract these values
    from the ``dim_info`` byte.

  * The C macro ``FPS_INTO_DIM_INFO`` can be used to put these 3 values
    into the dim_info byte.

* **slice_duration**: If this value is positive, and if ``slice_dim``
  is nonzero, then ``slice_duration`` indicates the amount of time used to
  acquire one slice.

  * ``slice_duration * dim[slice_dim]`` can be less than ``pixdim[4]``
    with a clustered acquisition method, for example.

* **slice_code**: If this value is nonzero, and if slice_dim is
  nonzero, and if slice_duration is positive, then slice_code
  indicates the timing pattern of the slice acquisition. The following
  codes are defined:

  * ``NIFTI_SLICE_SEQ_INC == sequential increasing``

  * ``NIFTI_SLICE_SEQ_DEC == sequential decreasing``

  * ``NIFTI_SLICE_ALT_INC == alternating increasing``

  * ``NIFTI_SLICE_ALT_DEC == alternating decreasing``

  * ``NIFTI_SLICE_ALT_INC2 == alternating increasing #2``

  * ``NIFTI_SLICE_ALT_DEC2 == alternating decreasing #2``


* **slice_start and slice_end**: These values indicate the start and
  end of the slice acquisition pattern, when ``slice_code`` is
  nonzero.

  * These values are present to allow for the possible addition of
    "padded" slices at either end of the volume, which don't fit into
    the slice timing pattern.

  * If there are no padding slices, then ``slice_start=0`` and
    ``slice_end=dim[slice_dim]-1`` are the correct values.

  * For these values to be meaningful, ``slice_start`` must be
    non-negative and ``slice_end`` must be greater than
    ``slice_start`` and less than ``dim[slice_code]``.

  * The following table indicates the slice timing pattern, relative
    to ``time=0`` for the first slice acquired, for some sample
    cases. Here, ``dim[slice_dim]=7`` (there are seven slices, labeled
    ``0..6``), ``slice_duration=0.1``, and ``slice_start=1``,
    ``slice_end=5`` (one padded slice on each end).

    .. code-block:: none

       slice index  SEQ_INC  SEQ_DEC  ALT_INC  ALT_DEC  ALT_INC2  ALT_DEC2
            6         n/a      n/a      n/a      n/a      n/a       n/a
            5         0.4      0.0      0.2      0.0      0.4       0.2
            4         0.3      0.1      0.4      0.3      0.1       0.0
            3         0.2      0.2      0.1      0.1      0.3       0.3
            2         0.1      0.3      0.3      0.4      0.0       0.1
            1         0.0      0.4      0.0      0.2      0.2       0.4
            0         n/a      n/a      n/a      n/a      n/a       n/a

      'n/a' = 'not applicable' 

  * The SEQ values for slice_code are sequential ordering (uncommon
    but not unknown), either increasing in slice number or decreasing
    (INC or DEC), as illustrated above.

  * The ALT values for slice_code are alternating ordering.

    * The 'standard' way for these to operate (without the '2' on the
      end) is for the slice timing to start at the edge of the
      ``slice_start .. slice_end`` group (at ``slice_start`` for INC
      and at ``slice_end`` for DEC).
    
    * With the ``ALT_*2`` values for slice_code, the slice timing
      instead starts at the first slice in from the edge (at
      ``slice_start+1`` for INC2 and at ``slice_end-1`` for
      DEC2). This latter acquisition scheme is found on some Siemens
      scanners.


 No doubt this is all a little confusing. There are threee concepts to grasp:

1. ordering of the spatial dimensions in the image array relative to acquisition,

#. time it takes to acquire a single slice,
    
#. and time-ordering of the slice acquisition within the ``slice_dim``
   direction (including the possibility of 'padded' slices that don't
   have an acquisition time order).


.. _format_nifti1_q_custom:

How can I add customized (extension) data to the NIfTI-1 header? 
----------------------------------------------------------------

.. by: (Bob Cox)

There are two phases to this answer: clarifying where the image data
is stored, and then discussing the NIfTI-1.1 approved way of storing
information after the 348 byte header (and before the image data in a
``.nii`` file).

**Clarifying vox_offset**

Of primary importance is the issue of where extended header data will
be stored, and how a program is to know what is header data and what
is image data. In NIfTI-1.1, the location of the image data is
specified by the vox_offset header field. There are two cases:

* In a ``.nii`` file, the vox_offset field value is the start location
  of the image data bytes in that file.
    
* In a ``.hdr/.img`` file pair, the vox_offset field value is the
  start location of the image data bytes in the ``.img`` file.

All data at and after the vox_offset location is taken to be image
data. Furthermore, the following limitations apply to the value of
``vox_offset``:

* If vox_offset is less than 352 in a ``.nii`` file, it is equivalent to
  352 (i.e., image data never starts before byte #352 in a ``.nii`` file).
    
* The default value for ``vox_offset`` in a ``.nii`` file is 352; in a
  ``.hdr`` file it is 0. The default value applies if the header
  vox_offset value is illegal (e.g., non-positive).
    
* ``vox_offset`` should be an integer multiple of 16; otherwise, some
  programs may not work properly (e.g., SPM). This constraint is to
  allow memory-mapped input to be properly byte-aligned. However, this
  multiple-of-16 constraint is a suggestion, not a strict requirement.


Note that since ``vox_offset`` is an IEEE-754 32-bit float (for
compatibility with the ANALYZE-7.5 format), it effectively has a
24-bit mantissa. All integers from 0 to 224 can be represented exactly
in this format, but not all larger integers are exactly storable as
IEEE-754 32-bit floats. However, unless you plan to have
``vox_offset`` be potentially larger than 16 MB, this limitation
should not be an issue. (Actually, any integral multiple of 16 up to
227 can be represented exactly in the IEEE-754 format, which allows
for up to 128 MB of random information before the image data. If this
limit is not enough, perhaps the NIfTI-1.1 format is not right for
your application.)

In a ``.img`` file (i.e., image data stored separately from the
NIfTI-1.1 header), data bytes between #0 and #vox_offset-1 (inclusive)
are completely undefined and unregulated by the NIfTI-1.1
standard. One potential use of having vox_offset > 0 in the ``.hdr/.img``
file pair storage method is to make the ``.img`` file be a copy of (or
link to) a pre-existing image file in some other format, such as
DICOM; then vox_offset would be set to the offset of the image data in
this file. (It may not be possible to follow the multiple-of-16 rule
with an arbitrary external file; using the NIfTI-1.1 format in such a
case may lead to a file that is incompatible with software that relies
on vox_offset being a multiple of 16.)

In a ``.nii`` file, data bytes between #348 and #vox_offset-1
(inclusive) may be used to store user-defined extra information;
similarly, in a ``.hdr`` file, any data bytes after byte #347 are
available for user-defined extra information. The (very weak)
regulation of this extra header data is described next.

**Extended Header Data Section(s)**

The NIfTI-1.1 header struct is 348 bytes long. In a ``.nii`` file, the
image data can start no earlier than byte #352. The four bytes
immediately following the NIfTI-1.1 header struct (bytes #348-351
inclusive) should be considered to be declared as follows:

.. code-block:: C

   unsigned char extension[4] ;

After the end of the 348 byte header (e.g., after the magic field),
the next 4 bytes are an byte array field named extension. By default,
all 4 bytes of this array should be set to zero. In a ``.nii`` file,
these 4 bytes will always be present, since the earliest start point
for the image data is byte #352. In a separate ``.hdr`` file, these bytes
may or may not be present (i.e., a ``.hdr`` file may only be 348 bytes
long). If not present, then a NIfTI-1.1 compliant program should use
the default value of ``extension={0,0,0,0}``. The first byte
(``extension[0]``) is the only value of this array that is specified
at present. The other 3 bytes are reserved for future use.

If ``extension[0]`` is nonzero, it indicates that extended header
information is present in the bytes following the extension array. In
a ``.nii`` file, this extended header data is before the image data (and
``vox_offset`` must be set correctly to allow for this). In a ``.hdr`` file,
this extended data follows extension and proceeds (potentially) to the
end of the file.

The format of extended header data is only weakly specified. Each
extension must be an integer multiple of 16 bytes long. The first 8
bytes of each extension comprise two 4-byte integers:

.. code-block:: C

  int esize , ecode ;

These values may need to be byte-swapped, as indicated by ``dim[0]`` for
the rest of the NIfTI-1.1 header.

* esize is the number of bytes that form the extended header data
        
  * esize must be a positive integral multiple of 16
        
  * this length includes the 8 bytes of esize and ecode themselves

* ecode is a non-negative integer that indicates the format of the
  extended header data that follows

  * different ecode values are assigned to different developer groups
    
  * at present, the registered values for code are: 

    * 0 = NIFTI_ECODE_IGNORE = unknown private format (not recommended!)

    * | 2 = NIFTI_ECODE_DICOM = DICOM format (i.e., attribute tags and
        values): 
      | http://medical.nema.org/

    * | 4 = NIFTI_ECODE_AFNI = AFNI header attributes; AFNI is described
        at `<http://afni.nimh.nih.gov/>`_; 
      | The format of the AFNI
        extension in the NIfTI-1.1 format is described at **UPDATE**
      | `<http://nifti.nimh.nih.gov/nifti-1/AFNIextension1/>`_

    * 6 = NIFTI_ECODE_COMMENT = comment: arbitrary non-NUL ASCII text,
      with no additional structure implied

    * | 8 = NIFTI_ECODE_XCEDE = XCEDE metadata:
      | `<http://www.nbirn.net/Resources/Users/Applications/xcede/index.htm>`_
    
    * 10 = NIFTI_ECODE_JIMDIMINFO = Dimensional information for the
      JIM software (XML format); contact info is Dr Mark A Horsfield
      (``mah5 _at_ leicester.ac.uk``).
    
    * | 12 = NIFTI_ECODE_WORKFLOW_FWDS = Fiswidget XML pipeline
        descriptions; documented at
      | `<http://kraepelin.wpic.pitt.edu/~fissell/NIFTI_ECODE_WORKFLOW_FWDS/NIFTI_ECODE_WORKFLOW_FWDS.html>`_;
      | contact info is Kate Fissell (``fissell _at_ pitt.edu``).

 In the interests of interoperability (a primary rationale for NIfTI),
 groups developing software that uses this extension mechanism are
 encouraged to document and publicize the format of their
 extensions. To this end, the NIfTI DFWG will assign even numbered
 codes upon request to groups submitting at least rudimentary
 documentation for the format of their extension. The assigned codes
 and documentation will be posted on the NIfTI website. All odd values
 of ecode (and 0) will remain unassigned (at least, until the even
 ones are used up, when we get to 2,147,483,646).

Also in the interests of interoperability, any extension data should
be checked for integrity. For example, an XML-formatted extension
should be checked that it begins with the string ``"<?xml "``; if not,
the software should skip it. In this way, databases of NIfTI-1.1 files
that wish to anonymize files can simply fill an extension field with
zero bytes to wipe out any information that might identify a
subject. In such a case, the anonymizing software should change the
ecode value to NIFTI_ECODE_IGNORE, but programs should be prepared to
deal with zero-ed out extensions that are still marked with a nonzero
ecode.

Note that the other contents (past ecode and esize) of the extended
header data section are totally unspecified by the NIfTI-1.1
standard. In particular, if binary data is stored in such a section,
its byte order is not necessarily the same as that given by examining
``dim[0]``; it is incumbent on the programs dealing with such data to
determine the byte order of binary extended header data.

Multiple extended header sections are allowed, each starting with an
esize,ecode value pair. The first esize value, as described above, is
at bytes #352-355 in the ``.hdr`` or ``.nii`` file (files start at
byte #0, just to be clear). If this esize1 value is positive, then the
second (esize2) will be found starting at byte #352+esize1, the third
(esize3) at byte #352+esize1+esize2, et cetera. Of course, in a ``.nii``
file, the value of vox_offset must be compatible with these
extensions. If a malformed file indicates that an extended header data
section would run past vox_offset, then that entire extended header
section should be ignored. In a ``.hdr`` file, if an extended header
data section would run past the end-of-file, that extended header data
should also be ignored.

With the above scheme, a program can successively examine the esize
and ecode values, and skip over each extended header section if the
program doesnt know how to interpret the data within. Of course, any
program can simply ignore all extended header sections simply by
jumping straight to the image data using vox_offset.

The C reference implementation for NIfTI-1.1 I/O contains several
functions to read and write header extensions. The nifti_tool command
line program for manipulating NIfTI-1.1 files uses these functions to
let you examine, remove, and/or add extension data to a file.
