easyqhull
=========

Simple processing wrapper for QuickHull3D

Minor modification of the original QuickHull3D, mainly to replace Vector with List, and add an accessor for Vertex to get Point3D (this was done so we can use arrays of double[] instead from processing). Currently designed to output convex hull from a given set of 3d coordinates as a double[][] (grouped by faces) also output to wavefront 3d file.
