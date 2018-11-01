import cython
import numpy as np
cimport numpy as np
# from libcpp.string cimport string

from fea_element cimport FEAElement

# cdef class FEAElement:

#     cdef int i


cdef class FEABeamElement(FEAElement):

    cdef int num_nodes_per_element
    cdef int num_stresses_per_element
    # cdef char * dof_names

    def __cinit__(self):
        self.num_nodes_per_element = 2
        self.num_stresses_per_element = 2
        # cdef string[2] name # = ['ab', 'bc']
        name = ['ab', 'casa']
