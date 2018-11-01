import cython
import numpy as np
cimport numpy as np
from cpython cimport array


from fea_element import FEAElement


cdef class FEAMesh():

    cdef int num_dimensions
    cdef int num_total_nodes

    cdef int num_total_elements

    cdef array.array node_coords

    cdef array.array elem_to_node_indices
    cdef array.array elem_to_node_indices_i0
    cdef array.array elem_to_node_indices_i1

    def __cinit__(self):
        self.num_total_elements = 0

        self.elem_to_node_indices = array.array('i', [])
        self.elem_to_node_indices_i0 = array.array('i', [])
        self.elem_to_node_indices_i1 = array.array('i', [])

    cpdef void set_nodes(self, double[:, :] in_node_coords):
        # in_node_coords: 2-D Python array
        # self.node_coords: 1-D Cython array
        # node_coords: 1-D Cython memory view

        cdef int inode, idim
        cdef double[:] node_coords

        # Initial allocation of memory for self.node_coords
        self.node_coords = array.array('i', [])
        self.node_coords.resize(in_node_coords.shape[0] * in_node_coords.shape[1])

        # The local variable node_coords points to self.node_coords
        node_coords = self.node_coords

        self.num_total_nodes = in_node_coords.shape[0]
        self.num_dimensions = in_node_coords.shape[1]

        # Turn 2-D array (in_node_coords) into 1-D array (node_coords)
        for inode in range(self.num_total_nodes):
            for idim in range(self.num_dimensions):
                node_coords[self.num_dimensions * inode + idim] = in_node_coords[inode, idim]
                node_coords[0] = 1

    cpdef void add_element_group(self, element_class, int[:, :] in_elem_to_node_indices):
        # in_elem_to_node_indices: 2-D Python array
        # self.elem_to_node_indices: 1-D Cython array
        # elem_to_node_indices: 1-D Cython memory view

        cdef int i, j, ni, nj
        cdef int old_length, new_length

        cdef int[:] elem_to_node_indices = self.elem_to_node_indices
        cdef int[:] elem_to_node_indices_i0 = self.elem_to_node_indices_i0
        cdef int[:] elem_to_node_indices_i1 = self.elem_to_node_indices_i1

        num_new_elements = in_elem_to_node_indices.shape[0]
        num_nodes_per_element = in_elem_to_node_indices.shape[1]

        old_length = len(self.elem_to_node_indices)
        new_length = old_length + num_new_elements * num_nodes_per_element

        print(self.node_coords)
        array.extend


        # array.extend(self.elem_to_node_indices_i0, [old_length])
        # array.extend(self.elem_to_node_indices_i1, [new_length])
        # array.extend(self.elem_to_node_indices, new_elem_to_node_indices)






    # cpdef void add_element_group00(self, FEAElement elem, int[:, :] node_indices):
    #     cdef int i, j, ni, nj

    #     ni = node_indices.shape[0]
    #     nj = node_indices.shape[1]

    #     new_node_indices = np.zeros(
    #         self.node_indices.shape[0] + ni * nj)

    #     new_node_indices_ranges = np.zeros(
    #         (self.node_indices_ranges[0] + 1, 2))

    #     for i in range(self.node_indices.shape[0]):
    #         new_node_indices[i] = self.node_indices[i]

    #     for i in range(self.node_indices_ranges.shape[0]):
    #         for j in range(2):
    #             new_node_indices_ranges[i, j] = self.node_indices_ranges[i, j]

    #     new_node_indices_ranges[self.node_indices_ranges.shape[0] + 1, 0] = self.node_indices_ranges[i, 1]
    #     new_node_indices_ranges[self.node_indices_ranges.shape[0] + 1, 1] = self.node_indices_ranges[i, 1] + ni * nj

    #     for i in range(ni):
    #         for j in range(nj):
            
    #             new_node_indices[self.node_indices.shape[0] + i * nj + j] = node_indices[i, j]

    #     self.node_indices = new_node_indices
    #     self.node_indices_ranges = new_node_indices_ranges

    #     self.num_total_elements = self.num_total_elements + node_indices.shape[0]