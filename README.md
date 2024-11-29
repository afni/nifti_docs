# README #

### What is this repository for? ###

* This is a repository of Sphinx/RST files for building an HTML tree
  of NIfTI (Neuroimaging Informatics Technology Initiative)
  documentation notes.

### Getting your Linux computer setup ###

* You should have Python 3.[something] as your installed Python

* Install Python dependencies.  This can be done by:

  * installing Conda (e.g., Miniconda)

  * ... and then using the attached ``environment_sphinxdocs.yml`` file:

    ```
    conda env create -f environment_sphinxdocs.yml
    ```

### Building Sphinx: converting RST -> HTML ###

* In the main directory where you are editing files, type:

  ```
  make html
  ```
      
* To view the subsequent HTML tree, type:
  
  ```
  firefox _build/html/index.html
  ```

* Note for convenience, we have added a script called
  "do_build_nifti_docs_from_git.tcsh" that can be run to copy
  the git tree to a new location and build the current files that are
  in the "master" branch online.
  
  + I would recommend then editing files in that new ~/nifti_docs/
    directory, and then just running "make html" there to see what
    your changes look like.  When happy with the changes, then copy
    those into the main git repo, commit and push them.  I find that a
    reasonable work flow.

