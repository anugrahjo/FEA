import cython
import numpy as np
cimport numpy as np
# from cpython cimport array
from linear_algebra.arrays import Array

from fea_element import FEAElement


cdef class FEAMesh():

    # cdef elem_to_node_indices_i0 = Array()
    # cdef elem_to_node_indices_i1 = Array()

    def __cinit__(self):

        self.num_elem = 0
        self.num_nodes = 0
        self.num_dim = 0

        self.eft = Array()                  #max. num of nodes per element set as 10
        self.node_coords = Array()
        # self.elem_to_node_indices_i0 = Array()
        # self.elem_to_node_indices_i1 = Array()

    
    cpdef void set_nodes(self, int[:, :] node_coords): #num of dim fixed for any given mesh at the start of the program
        cpdef node_coords_1d = np.empty(node_coords.size)
        cdef int t = 0

        for i in range(node_coords.shape[0]):
            for j in range(node_coords.shape[1]):
                node_coords_1d[t] = node_coords[i][j]
                t += 1

        cdef np.ndarray[int, ndim=1, mode='c'] shape = np.array([node_coords.shape[0], node_coords.shape[1]], dtype =np.intc)   #shape of node_coords input
        if self.num_dim == 0:
            self.num_dim = node_coords.shape[1]
            self.node_coords.init_np_double(<int*>shape.data, 2, node_coords_1d)             
        else:
            temp = Array()
            temp.init_np_double(<int*>shape.data, 2, node_coords_1d) 
            self.node_coords.append(temp, 1.)
        self.num_nodes += node_coords.shape[0]

    cpdef void add_element_group(self, element_class, int[:, :] eft):
        cpdef eft_1d = np.empty(eft.size)
        cdef int t = 0

        for i in range(eft.shape[0]):
            for j in range(eft.shape[1]):
                eft_1d[t] = eft[i][j]
                t += 1
            for j in range(eft.shape[1], 10):
                eft_1d[t] = -1
                t += 1
        
        cdef np.ndarray[int, ndim=1, mode='c'] shape = np.array([eft.shape[0], 10], dtype =np.intc)   #shape of eft input
        if self.num_dim == 0:
            self.eft.init_np_double(<int*>shape.data, 2, eft_1d) 
        else:
            temp = Array()
            temp.init_np_double(<int*>shape.data, 2, eft_1d) 
            self.eft.append(temp, 1.)

        self.num_elem += eft.shape[0]

    

    

    