import numpy as np
from distutils.core import setup
from Cython.Build import cythonize


setup(
    ext_modules = cythonize([
        'fea_element.pyx',
        'fea_beam_element.pyx',
        'fea_solver.pyx',
        'fea_mesh.pyx',
    ]),
    include_dirs=[np.get_include()]
)