# A description of the Blender To NeuroML Conversion Algorithm

# Introduction

This document explains the algorithm used to convert Blender files representing neurons into NeuroML morphologies (i.e. MorphML).  The source code that implements this algorithm can be found [in our code repository](http://code.google.com/p/openworm/source/browse/?repo=neuroml#hg%2FBlenderToNeuroMLConverter)

## Key terms

**Vertex** – point has 3d coordinates (We get it from wrl or blender file)

**Vertices** – collection of vertex

**Face** – its collection of 3-4-more vertex. It contains only indexes of vertex from Vertices (We get it from wrl or blender file)

**Faces** – collection of face

**Slice** – collection of vertex which is located in junction of two segments of object. It is not face.

**Resulting_point** – its center of mass of slice. 

## Fig. 1

https://docs.google.com/uc?id=0B_t3mQaA-HaMZTY1NzY4ZDYtYzc4YS00YjE0LTgxMDAtZmQwOTVkODUwMWZl&export=download&hl=en_US&.png

                          
## Fig. 2

https://docs.google.com/uc?id=0B_t3mQaA-HaMODBjNDc0ZWEtZmY3ZC00NGIzLTlkMjAtZWVmYTkwOGM0YTc2&export=download&hl=en_US&.png


1. First step of algorithm we need find start point it means we need find some point located in soma.
- What soma is, in Fig.1, obvious its segment with slice which has maximum perimeter (see Fig2).
1. Algorithm of finding all resulting points
- Add current center point to resulting_points collection.
- Fill up collection vector_len which contains object with index of vertex from vertices collection and distance from this point to current center point

# Step 1

## iteration = 0

       Find for current center point nearest slice (find nearest slice from vector_len of the points). Count center point for finding slice (put verticies of this slice to checked point collection) and current center point = center point. Then iteration += 1 and we run this recursively with new center point.
	
## iteration != 0

        Find next center point. 
                 a.  If in input arguments _slice = None we initialize slice from vector_len collection.
                     Else _slice != None => slice = _slice
    
                 b.  Find adjacent point for all point from slice. 
                     Adjacent point collection contains only that point which don’t 
                     contain in checked points collection
    
                c. Adjacent point collection can have 4, 6, 8 or more points.  
    
                    a. If it has 4 point it means that it simple segment 
                       without any branching. In this case we find slice 
                       from this 4 adjacent point collection find new center 
                       point. Current center point = new center point, 
                       iteration += 1, put verticies of this slice to checked 
                       point collection, then we go to Step 1.
    
                    b. If it has > 4 point. 
    
                         i. If input argument isBranchStart = false it means that is branching segment. 
                            This two slices Slice1 and Slice2 are founded by analyzing adjacent points. 
    
                         ii. After we find center point for this two slice, put verticies of this slices 
                             to checked point collection and go to Step 1 for every new center points.
    
                         iii.  If we find 1 slice and If input argument isBranchStart = true. 
                               It means that we located in first segment after branching. 
                               In this case we create slice from adjacent points and find 
                               center point for it, put verticies of this slice to 
                               checked point collection and go to Step 1 for new center point. 
                                Current center point = new center point go to Step 1 for this.
                         iv.  If we find 0 slice or (If we find 1 slice and isBranchStart = false)
                              It means that we located in first point of axon or dendrite. 
                              In this case we select that slice perimeter of which has a less value, 
                              count new center point, put verticies of this slice to checked point 
                              collection and go to Step 1 for new center point.

## Fig. 3

https://docs.google.com/uc?id=0B_t3mQaA-HaMZWNhYzUzODEtZWM3Yy00ZjJlLWIxNDAtNzRhYjdhZTIyM2Qz&export=download&hl=en_US&.png
                 
## Fig. 4

https://docs.google.com/uc?id=0B_t3mQaA-HaMYWZhYjIzYTAtZmRjYi00YTY5LTg4NmQtOGQzYzQ5OWEzOTc1&export=download&hl=en_US&.png

## Fig. 5

https://docs.google.com/uc?id=0B_t3mQaA-HaMYmEzN2Y0MDctYWQ3ZS00MzNhLTg1ZDctMzFiZWJhNGViMmFl&export=download&hl=en_US&.png

## Fig. 6

https://docs.google.com/uc?id=0B_t3mQaA-HaMNDI5OGJkNDUtZGM0My00NjYxLWFmMmMtNDcxYzhhMDcwNDlj&export=download&hl=en_US&.png


# Step 2

## If iteration = 1

Need to check if Soma has any other dendrites. Check 5 nearest to start center point slices if we find it. If we find such slice then we go to step 1 with new current center point (count from this slice).