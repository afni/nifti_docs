
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
   * - :ref:`float intent_p1 <fields_nifti1__intent_p1>`
     - 1st intent parameter
     - short unused8; short unused9
     - 56
   * - :ref:`float intent_p2 <fields_nifti1__intent_p2>`
     - 2nd intent parameter
     - short unused10; short unused11
     - 60
   * - :ref:`float intent_p3 <fields_nifti1__intent_p3>`
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


Field notes
=============================

.. _fields_nifti1__sizeof_hdr:

int sizeof_hdr
----------------

This field must be set to 348.


.. _fields_nifti1__data_type:

char data_type[10]
-------------------

Unused fields are:

.. code-block:: C

   char data_type[10]; (not to be confused with the datatype field...)
   char db_name[18];
   int extents;
   short session_error;
   char regular;

   int glmax;
   int glmin; 


.. _fields_nifti1__db_name:

char db_name[18]
-----------------





.. _fields_nifti1__extents:

int extents
------------


.. _fields_nifti1__session_error:

short session_error
----------------------



.. _fields_nifti1__regular:

char regular
----------------



.. _fields_nifti1__dim_info:

char dim_info
----------------


.. _fields_nifti1__dim:

short dim[8]
-------------


.. _fields_nifti1__intent_p1:

float intent_p1
-----------------



.. _fields_nifti1__intent_p2:

float intent_p2
-----------------



.. _fields_nifti1__intent_p3:

float intent_p3
-----------------



.. _fields_nifti1__intent_code:

short intent_code
---------------------





