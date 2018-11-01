import numpy as np

import fea_solver
import fea_mesh
import fea_beam_element


nodes = np.zeros((3, 2))

m = fea_mesh.FEAMesh()
m.set_nodes(nodes)

node_indices = np.array([
    [1, 4],
    [2, 6],
    [4, 5],
])
m.add_elements(fea_beam_element.FEABeamElement, node_indices)

node_indices = np.array([
    [1, 4],
    [2, 6],
    [4, 5],
])
m.add_elements(FEATrussElement, node_indices)


# f = fea_solver.FEASolver()
# f.setup()