import cython
import numpy as np
cimport numpy as np

from fea_mesh import FEAMesh


cdef class FEASolver():

    cdef FEAMesh

    cdef void dummy(self):
        self.num_total_nodes

    cpdef void setup(self):
        self.num_dimension = 1
        print('anugrah')