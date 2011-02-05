Objtri
=============================================================================

I've recently had a need for testing graphics stuff on arbitrary models which
I tried to solve by grabbing random free OBJ models off the net. Unfortunately,
most of these models are made of quads and I need triangles. This small
and naive utility triangulates the models.

There's nothing fancy applied to the model. No optimizations, no geometry modifications.


Usage
=============================================================================
Input is path to an .obj file, e.g. "C:/folder/model.obj".
Output will be "C:/folder/tri_model.obj".