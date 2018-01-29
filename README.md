easyqhull
=========

Simple ruby-processing wrapper for QuickHull3D, this is an evolving project, that will exclusively target JRubyArt and propane. There is no need for a processing version. The intention is to create a gem that is easy to use but backed up by fast java algorithms. The idea is to hide ruby to java conversions (possibly writ jruby extensions), get rid of ridiculous java indexed for loops and to replace small arrays (that should be objects) with classes of struct (see Point). Progress is being made.
