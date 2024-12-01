
.. _fields_nifti1:

*************************
**NIfTI-1 Header Fields**
*************************


.. comment: don't include this table here, because it is basically
   contained in the list-table below

   .. contents:: :local:


Struct documentation
=============================

The field-by-field documentation on these pages was taken directly
from the official nifti-1 header file documentation, originally
written by Bob Cox (SSCC, NIMH, NIH, USA). 

These pages provide a "clickable" index to that information, and some
links to additional information.

See also this PDF description of NIFTI-1 data: :download:`The NIfTI-1
Data Format <media/TheNIfTI1Format2004.pdf>`.

.. list-table:: **struct nifti_1_header: 348 bytes total**
   :header-rows: 1
   :widths: 30 30 30 10

   * - Item
     - NIfTI-1 usage
     - Analyze 7.5 field(s)
     - Byte offset
   * - :ref:`int sizeof_hdr <fields_nifti1__sizeof_hdr>`
     - MUST be 348  
     - int sizeof_hdr
     - 0
   * - :ref:`char data_type[10] <fields_nifti1__data_type>`
     - ++UNUSED++
     - char data_type[10]
     - 4
   * - :ref:`char db_name[18] <fields_nifti1__db_name>`
     - ++UNUSED++
     - char  db_name[18]
     - 14
   * - :ref:`int extents <fields_nifti1__extents>`
     - ++UNUSED++
     - int   extents
     - 32
   * - :ref:`short session_error <fields_nifti1__session_error>`
     - ++UNUSED++
     - short session_error
     - 36
   * - :ref:`char  regular <fields_nifti1__regular>`
     - ++UNUSED++
     - char  regular
     - 38
   * - :ref:`char  dim_info <fields_nifti1__dim_info>`
     - MRI slice ordering
     - char hkey_un0
     - 39
   * - :ref:`short dim[8] <fields_nifti1__dim>`
     - Data array dimensions
     - short dim[8]
     - 40
   * - :ref:`float intent_p1 <fields_nifti1__intent_p123>`
     - 1st intent parameter
     - short unused8; short unused9
     - 56
   * - :ref:`float intent_p2 <fields_nifti1__intent_p123>`
     - 2nd intent parameter
     - short unused10; short unused11
     - 60
   * - :ref:`float intent_p3 <fields_nifti1__intent_p123>`
     - 3rd intent parameter
     - short unused12; short unused13
     - 64
   * - :ref:`short intent_code <fields_nifti1__intent_code>`
     - NIFTIINTENT code
     - short unused14
     - 68
   * - short datatype
     - Defines data type!
     - short datatype
     - 70
   * - short bitpix
     - Number bits/voxel
     - short bitpix
     - 72
   * - short slice_start
     - First slice index
     - short dim_un0
     - 74
   * - float pixdim[8]
     - Grid spacings
     - float pixdim[8]
     - 76
   * - float vox_offset
     - Offset into .nii file
     - float vox_offset
     - 108
   * - float scl_slope
     - Data scaling: slope
     - float funused1
     - 112
   * - float scl_inter
     - Data scaling: offset
     - float funused2
     - 116
   * - short slice_end
     - Last slice index
     - float funused3
     - 120
   * - char  slice_code
     - Slice timing order
     - 
     - 122
   * - char  xyzt_units
     - Units of pixdim[1..4]
     - 
     - 123
   * - float cal_max
     - Max display intensity
     - float cal_max
     - 124
   * - float cal_min
     - Min display intensity
     - float cal_min
     - 128
   * - float slice_duration
     - Time for 1 slice
     - float compressed
     - 132
   * - float toffset
     - Time axis shift
     - float verified
     - 136
   * - int   glmax
     - ++UNUSED++
     - int   glmax
     - 140
   * - int   glmin
     - ++UNUSED++
     - int   glmin
     - 144
   * - char  descrip[80]
     - any text you like
     - char  descrip[80]
     - 148
   * - char  aux_file[24]
     - auxiliary filename
     - char  aux_file[24]
     - 228
   * - short qform_code
     - NIFTIXFORM code
     - 
     - 252
   * - short sform_code
     - NIFTIXFORM code
     - 
     - 254
   * - float quatern_b
     - Quaternion b param
     - 
     - 256
   * - float quatern_c
     - Quaternion c param
     - 
     - 260
   * - float quatern_d
     - Quaternion d param
     - 
     - 264
   * - float qoffset_x
     - Quaternion x shift
     - 
     - 268
   * - float qoffset_y
     - Quaternion y shift
     - 
     - 272
   * - float qoffset_z
     - Quaternion z shift
     - 
     - 276
   * - float srow_x[4]
     - 1st row affine transform
     - 
     - 280
   * - float srow_y[4]
     - 2nd row affine transform
     - 
     - 296
   * - float srow_z[4]
     - 3rd row affine transform
     - 
     - 312
   * - char intent_name[16]
     - name or meaning of data
     - 
     - 328
   * - char magic[4]
     - MUST be "ni1\0" or "n+1\0"
     - 
     - 344

.. _fields_nifti1_unused:

Comment on unused fields
==========================

*From the nifti1.h header file.*

Fields that are marked as ++UNUSED++ have no particular interpretation
in this standard.

Some of the ANALYZE 7.5 fields marked as ++UNUSED++ may need to be set
to particular values for compatibility with other programs. The issue
of interoperability of ANALYZE 7.5 files is a murky one -- not all
programs require exactly the same set of fields. (Unobscuring this
murkiness is a principal motivation behind NIFTI-1.)

Some of the fields that may need to be set for other (non-NIFTI aware)
software to be happy are:

* **extents**:    dbh.h says this should be 16384

* **regular**: dbh.h says this should be the character 'r'

* **glmin, glmax**: dbh.h says these values should be the min and max
  voxel values for the entire dataset

It is best to initialize ALL fields in the NIFTI-1 header to 0 (e.g.,
with ``calloc()``), then fill in what is needed.

Unused fields are:

.. code-block:: C

   char data_type[10]; (not to be confused with the datatype field...)
   char db_name[18];
   int extents;
   short session_error;
   char regular;

   int glmax;
   int glmin; 


Field notes
=============================

.. _fields_nifti1__sizeof_hdr:

int sizeof_hdr
----------------

This field must be set to 348.


.. _fields_nifti1__data_type:

char data_type[10]
-------------------

See :ref:`fields_nifti1_unused`.

.. _fields_nifti1__db_name:

char db_name[18]
-----------------

See :ref:`fields_nifti1_unused`.


.. _fields_nifti1__extents:

int extents
------------

See :ref:`fields_nifti1_unused`.


.. _fields_nifti1__session_error:

short session_error
----------------------

See :ref:`fields_nifti1_unused`.


.. _fields_nifti1__regular:

char regular
----------------

See :ref:`fields_nifti1_unused`.


.. _fields_nifti1__dim_info:

char dim_info
----------------

(Original) nifti1.h header documentation:

.. code-block:: none

   /---------------------------------------------------------------------------/
   /* MRI-SPECIFIC SPATIAL AND TEMPORAL INFORMATION:
      ---------------------------------------------
      A few fields are provided to store some extra information
      that is sometimes important when storing the image data
      from an FMRI time series experiment.  (After processing such
      data into statistical images, these fields are not likely
      to be useful.)

     { freq_dim  } = These fields encode which spatial dimension (1,2, or 3)
     { phase_dim } = corresponds to which acquisition dimension for MRI data.
     { slice_dim } =
       Examples:
         Rectangular scan multi-slice EPI:
           freq_dim = 1  phase_dim = 2  slice_dim = 3  (or some permutation)
         Spiral scan multi-slice EPI:
           freq_dim = phase_dim = 0  slice_dim = 3
           since the concepts of frequency- and phase-encoding directions
           don't apply to spiral scan

       slice_duration = If this is positive, AND if slice_dim is nonzero,
                        indicates the amount of time used to acquire 1 slice.
                        slice_duration*dim[slice_dim] can be less than pixdim[4]
                        with a clustered acquisition method, for example.

       slice_code = If this is nonzero, AND if slice_dim is nonzero, AND
                    if slice_duration is positive, indicates the timing
                    pattern of the slice acquisition.  The following codes
                    are defined:
                      NIFTI_SLICE_SEQ_INC
                      NIFTI_SLICE_SEQ_DEC
                      NIFTI_SLICE_ALT_INC
                      NIFTI_SLICE_ALT_DEC
     { slice_start } = Indicates the start and end of the slice acquisition
     { slice_end   } = pattern, when slice_code is nonzero.  These values
                       are present to allow for the possible addition of
                       "padded" slices at either end of the volume, which
                       don't fit into the slice timing pattern.  If there
                       are no padding slices, then slice_start=0 and
                       slice_end=dim[slice_dim]-1 are the correct values.
                       For these values to be meaningful, slice_start must
                       be non-negative and slice_end must be greater than
                       slice_start.


     The following table indicates the slice timing pattern, relative to
     time=0 for the first slice acquired, for some sample cases.  Here,
     dim[slice_dim]=7 (there are 7 slices, labeled 0..6), slice_duration=0.1,
     and slice_start=1, slice_end=5 (1 padded slice on each end).

       slice
       index   SEQ_INC SEQ_DEC ALT_INC ALT_DEC
         6  --   n/a     n/a     n/a     n/a     n/a = not applicable
         5  --   0.4     0.0     0.2     0.0           (slice time offset
         4  --   0.3     0.1     0.4     0.3            doesn't apply to
         3  --   0.2     0.2     0.1     0.1            slices outside range
         2  --   0.1     0.3     0.3     0.4            slice_start..slice_end)
         1  --   0.0     0.4     0.0     0.2
         0  --   n/a     n/a     n/a     n/a


     The fields freq_dim, phase_dim, slice_dim are all squished into the single
     byte field dim_info (2 bits each, since the values for each field are
     limited to the range 0..3).  This unpleasantness is due to lack of space
     in the 348 byte allowance.

     The macros DIM_INFO_TO_FREQ_DIM, DIM_INFO_TO_PHASE_DIM, and
     DIM_INFO_TO_SLICE_DIM can be used to extract these values from the
     dim_info byte.

     The macro FPS_INTO_DIM_INFO can be used to put these 3 values
     into the dim_info byte.

Defined codes:

.. code-block:: C

   #define NIFTI_SLICE_UNKNOWN  0
   #define NIFTI_SLICE_SEQ_INC  1
   #define NIFTI_SLICE_SEQ_DEC  2
   #define NIFTI_SLICE_ALT_INC  3
   #define NIFTI_SLICE_ALT_DEC  4

Miscellaneous C macros:

.. code-block:: C

   #define DIM_INFO_TO_FREQ_DIM(di)   ( ((di)     ) & 0x03 )
   #define DIM_INFO_TO_PHASE_DIM(di)  ( ((di) >> 2) & 0x03 )
   #define DIM_INFO_TO_SLICE_DIM(di)  ( ((di) >> 4) & 0x03 )


   #define FPS_INTO_DIM_INFO(fd,pd,sd) ( ( ( ((char)(fd)) & 0x03)      ) |  \
                                         ( ( ((char)(pd)) & 0x03) << 2 ) |  \
                                         ( ( ((char)(sd)) & 0x03) << 4 )  )



.. _fields_nifti1__dim:

short dim[8]
-------------

(Original) nifti1.h header documentation:

.. code-block:: none

   /---------------------------------------------------------------------------/
   /* DATA DIMENSIONALITY (as in ANALYZE 7.5):
      ---------------------------------------
        dim[0] = number of dimensions;
                 - if dim[0] is outside range 1..7, then the header information
                   needs to be byte swapped appropriately
                 - ANALYZE supports dim[0] up to 7, but NIFTI-1 reserves
                   dimensions 1,2,3 for space (x,y,z), 4 for time (t), and
                   5,6,7 for anything else needed.

        dim[i] = length of dimension #i, for i=1..dim[0]  (must be positive)
                 - also see the discussion of intent_code, far below

        pixdim[i] = voxel width along dimension #i, i=1..dim[0] (positive)
                    - cf. ORIENTATION section below for use of pixdim[0]
                    - the units of pixdim can be specified with the xyzt_units
                      field (also described far below).

      Number of bits per voxel value is in bitpix, which MUST correspond with
      the datatype field.  The total number of bytes in the image data is
        dim[1]  ...  dim[dim[0]] * bitpix / 8

      In NIFTI-1 files, dimensions 1,2,3 are for space, dimension 4 is for time,
      and dimension 5 is for storing multiple values at each spatiotemporal
      voxel.  Some examples:
        - A typical whole-brain FMRI experiment's time series:
           - dim[0] = 4
           - dim[1] = 64   pixdim[1] = 3.75 xyzt_units =  NIFTI_UNITS_MM
           - dim[2] = 64   pixdim[2] = 3.75             | NIFTI_UNITS_SEC
           - dim[3] = 20   pixdim[3] = 5.0
           - dim[4] = 120  pixdim[4] = 2.0
        - A typical T1-weighted anatomical volume:
           - dim[0] = 3
           - dim[1] = 256  pixdim[1] = 1.0  xyzt_units = NIFTI_UNITS_MM
           - dim[2] = 256  pixdim[2] = 1.0
           - dim[3] = 128  pixdim[3] = 1.1
        - A single slice EPI time series:
           - dim[0] = 4
           - dim[1] = 64   pixdim[1] = 3.75 xyzt_units =  NIFTI_UNITS_MM
           - dim[2] = 64   pixdim[2] = 3.75             | NIFTI_UNITS_SEC
           - dim[3] = 1    pixdim[3] = 5.0
           - dim[4] = 1200 pixdim[4] = 0.2
        - A 3-vector stored at each point in a 3D volume:
           - dim[0] = 5
           - dim[1] = 256  pixdim[1] = 1.0  xyzt_units = NIFTI_UNITS_MM
           - dim[2] = 256  pixdim[2] = 1.0
           - dim[3] = 128  pixdim[3] = 1.1
           - dim[4] = 1    pixdim[4] = 0.0
           - dim[5] = 3                     intent_code = NIFTI_INTENT_VECTOR
        - A single time series with a 3x3 matrix at each point:
           - dim[0] = 5
           - dim[1] = 1                     xyzt_units = NIFTI_UNITS_SEC
           - dim[2] = 1
           - dim[3] = 1
           - dim[4] = 1200 pixdim[4] = 0.2
           - dim[5] = 9                     intent_code = NIFTI_INTENT_GENMATRIX
           - intent_p1 = intent_p2 = 3.0    (indicates matrix dimensions)

      BYTE ORDERING:
      -------------
      The byte order of the data arrays is presumed to be the same as the byte
      order of the header (which is determined by examining dim[0]).

      VECTOR-VALUED DATASETS:
      ----------------------
      The 5th dimension of the dataset, if present (i.e., dim[0]=5 and
      dim[5] > 1), contains multiple values (e.g., a vector) to be stored
      at each spatiotemporal location.  For example, the header values
       - dim[0] = 5
       - dim[1] = 64
       - dim[2] = 64
       - dim[3] = 20
       - dim[4] = 1     (indicates no time axis)
       - dim[5] = 3
       - datatype = DT_FLOAT
       - intent_code = NIFTI_INTENT_VECTOR
      mean that this dataset should be interpreted as a 3D volume (64x64x20),
      with a 3-vector of floats defined at each point in the 3D grid.

      A program reading a dataset with a 5th dimension may want to reformat
      the image data to store each voxels' set of values together in a struct
      or array.  This programming detail, however, is beyond the scope of the
      NIFTI-1 file specification!  Uses of dimensions 6 and 7 are also not
      specified here.

      STATISTICAL PARAMETRIC DATASETS (i.e., SPMs):
      --------------------------------------------
      Values of intent_code from NIFTI_FIRST_STATCODE to NIFTI_LAST_STATCODE
      (inclusive) indicate that the numbers in the dataset should be interpreted
      as being drawn from a given distribution.  Most such distributions have
      auxiliary parameters (e.g., NIFTI_INTENT_TTEST has 1 DOF parameter).

      If the dataset DOES NOT have a 5th dimension, then the auxiliary parameters
      are the same for each voxel, and are given in header fields intent_p1,
      intent_p2, and intent_p3.

      If the dataset DOES have a 5th dimension, then the auxiliary parameters
      are different for each voxel.  For example, the header values
       - dim[0] = 5
       - dim[1] = 128
       - dim[2] = 128
       - dim[3] = 1      (indicates a single slice)
       - dim[4] = 1      (indicates no time axis)
       - dim[5] = 2
       - datatype = DT_FLOAT
       - intent_code = NIFTI_INTENT_TTEST
      mean that this is a 2D dataset (128x128) of t-statistics, with the
      t-statistic being in the first "plane" of data and the degrees-of-freedom
      parameter being in the second "plane" of data.

      If the dataset 5th dimension is used to store the voxel-wise statistical
      parameters, then dim[5] must be 1 plus the number of parameters required
      by that distribution (e.g., intent_code=NIFTI_INTENT_TTEST implies dim[5]
      must be 2, as in the example just above).


   /---------------------------------------------------------------------------/
   /* UNITS OF SPATIAL AND TEMPORAL DIMENSIONS:
      ----------------------------------------
      The codes below can be used in xyzt_units to indicate the units of pixdim.
      As noted earlier, dimensions 1,2,3 are for x,y,z; dimension 4 is for
      time (t).
       - If dim[4]=1 or dim[0] < 4, there is no time axis.
       - A single time series (no space) would be specified with
         - dim[0] = 4 (for scalar data) or dim[0] = 5 (for vector data)
         - dim[1] = dim[2] = dim[3] = 1
         - dim[4] = number of time points
         - pixdim[4] = time step
         - xyzt_units indicates units of pixdim[4]
         - dim[5] = number of values stored at each time point

      Bits 0..2 of xyzt_units specify the units of pixdim[1..3]
       (e.g., spatial units are values 1..7).
      Bits 3..5 of xyzt_units specify the units of pixdim[4]
       (e.g., temporal units are multiples of 8).



Miscellaneous C macros:

.. code-block:: C

   /! Check if a nifti_1_header struct needs to be byte swapped.
       Returns 1 if it needs to be swapped, 0 if it does not.     /

   #define NIFTI_NEEDS_SWAP(h) ( (h).dim[0] < 0 || (h).dim[0] > 7 )

   /! Check if a nifti_1_header struct contains a 5th (vector) dimension.
       Returns size of 5th dimension if > 1, returns 0 otherwise.         /

   #define NIFTI_5TH_DIM(h) ( ((h).dim[0]>4 && (h).dim[5]>1) ? (h).dim[5] : 0 )


.. _fields_nifti1__intent_p123:

float intent_p1, intent_p2, intent_p3
--------------------------------------------

Re. STATISTICAL PARAMETRIC DATASETS (i.e., SPMs):

Values of intent_code from NIFTI_FIRST_STATCODE to NIFTI_LAST_STATCODE
(inclusive) indicate that the numbers in the dataset should be
interpreted as being drawn from a given distribution. Most such
distributions have auxiliary parameters (e.g., NIFTI_INTENT_TTEST has
1 DOF parameter).

If the dataset DOES NOT have a 5th dimension, then the auxiliary
parameters are the same for each voxel, and are given in header fields
intent_p1, intent_p2, and intent_p3.


.. _fields_nifti1__intent_code:

short intent_code
---------------------

Description from the original nifti1.h header file:

.. code-block:: none

   /---------------------------------------------------------------------------/
   /* INTERPRETATION OF VOXEL DATA:
      ----------------------------
      The intent_code field can be used to indicate that the voxel data has
      some particular meaning.  In particular, a large number of codes is
      given to indicate that the the voxel data should be interpreted as
      being drawn from a given probability distribution.

      VECTOR-VALUED DATASETS:
      ----------------------
      The 5th dimension of the dataset, if present (i.e., dim[0]=5 and
      dim[5] > 1), contains multiple values (e.g., a vector) to be stored
      at each spatiotemporal location.  For example, the header values
       - dim[0] = 5
       - dim[1] = 64
       - dim[2] = 64
       - dim[3] = 20
       - dim[4] = 1     (indicates no time axis)
       - dim[5] = 3
       - datatype = DT_FLOAT
       - intent_code = NIFTI_INTENT_VECTOR
      mean that this dataset should be interpreted as a 3D volume (64x64x20),
      with a 3-vector of floats defined at each point in the 3D grid.

      A program reading a dataset with a 5th dimension may want to reformat
      the image data to store each voxels' set of values together in a struct
      or array.  This programming detail, however, is beyond the scope of the
      NIFTI-1 file specification!  Uses of dimensions 6 and 7 are also not
      specified here.

      STATISTICAL PARAMETRIC DATASETS (i.e., SPMs):
      --------------------------------------------
      Values of intent_code from NIFTI_FIRST_STATCODE to NIFTI_LAST_STATCODE
      (inclusive) indicate that the numbers in the dataset should be interpreted
      as being drawn from a given distribution.  Most such distributions have
      auxiliary parameters (e.g., NIFTI_INTENT_TTEST has 1 DOF parameter).

      If the dataset DOES NOT have a 5th dimension, then the auxiliary parameters
      are the same for each voxel, and are given in header fields intent_p1,
      intent_p2, and intent_p3.

      If the dataset DOES have a 5th dimension, then the auxiliary parameters
      are different for each voxel.  For example, the header values
       - dim[0] = 5
       - dim[1] = 128
       - dim[2] = 128
       - dim[3] = 1      (indicates a single slice)
       - dim[4] = 1      (indicates no time axis)
       - dim[5] = 2
       - datatype = DT_FLOAT
       - intent_code = NIFTI_INTENT_TTEST
      mean that this is a 2D dataset (128x128) of t-statistics, with the
      t-statistic being in the first "plane" of data and the degrees-of-freedom
      parameter being in the second "plane" of data.

      If the dataset 5th dimension is used to store the voxel-wise statistical
      parameters, then dim[5] must be 1 plus the number of parameters required
      by that distribution (e.g., intent_code=NIFTI_INTENT_TTEST implies dim[5]
      must be 2, as in the example just above).

      Note: intent_code values 2..10 are compatible with AFNI 1.5x (which is
      why there is no code with value=1, which is obsolescent in AFNI).

      OTHER INTENTIONS:
      ----------------
      The purpose of the intent_* fields is to help interpret the values
      stored in the dataset.  Some non-statistical values for intent_code
      and conventions are provided for storing other complex data types.

      The intent_name field provides space for a 15 character (plus 0 byte)
      name string for the type of data stored. Examples:
       - intent_code = NIFTI_INTENT_ESTIMATE; intent_name = "T1";
          could be used to signify that the voxel values are estimates of the
          NMR parameter T1.
       - intent_code = NIFTI_INTENT_TTEST; intent_name = "House";
          could be used to signify that the voxel values are t-statistics
          for the significance of activation response to a House stimulus.
       - intent_code = NIFTI_INTENT_DISPVECT; intent_name = "ToMNI152";
          could be used to signify that the voxel values are a displacement
          vector that transforms each voxel (x,y,z) location to the
          corresponding location in the MNI152 standard brain.
       - intent_code = NIFTI_INTENT_SYMMATRIX; intent_name = "DTI";
          could be used to signify that the voxel values comprise a diffusion
          tensor image.

      If no data name is implied or needed, intent_name[0] should be set to 0.



