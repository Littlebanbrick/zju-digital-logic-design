# **CLASS THREE**

## Canonical Forms

### SOM and POM
- Sum of Minterms (minterm: a conjunction with only one assignment of input makes it 1)  
- Product of Maxterms (maxterm: a disjunction with only one assignment of input makes it 0)

<img src="photos/eg_minmaxterms.png" width=400px>  

m<sub>x</sub>: the minterm whose index<sub>10</sub> is x.  
M<sub>x</sub>: maxterm ...  

Shorthand:
- m<sub>1</sub>+m<sub>4</sub>+m<sub>5</sub>+m<sub>6</sub>+m<sub>7</sub> = &Sigma;<sub>m</sub>(1,4,5,6,7)  
- And POM uses &Pi;.  
  
**NOTICE that:** m<sub>x</sub> and M<sub>x</sub> are complements to each other.

>The complement of a function expressed as a SOM is constructed by selecting the minterms missing in the SOM.  
E.G. F(x,y,z) = &Sigma;<sub>m</sub>(1,3,6,7) implies F'(x,y,z) = &Sigma;<sub>m</sub>(0,2,4,5)

>To convert between SOM and POM:   
Identify the terms that are NOT included in the expression.   
Combine all the terms using the corresponding form.   
E.G. &Sigma;<sub>m</sub>(1,3,6,7) = &Pi;<sub>M</sub>(0,2,4,5)

### Simplification
**Original expression -> Canonical -> Simplified**
1. Segmentation: ensure every term contains all the variables
2. Deduplication
3. Merging

## Standard Forms

Where terms can only contains part of all variables.

### SOP and POS
- Sum of Products: DNF  
- Product od sums: CNF

<img src="photos/Canonical_and_SOP.png" width=400px>  

## Circuit Optimization

### Literal cost
How many literals are in the expression.

### Gate Input cost
<img src="photos/eg_GateInputCost.png" width=400px>   
<br><br>

1. Calculate Literal cost (L)
2. Add the number AND/OR calculations (**Without the last ones (output)**)
3. Add the number of "NOT variable"s (GN) (**Do not count duplicatedly**)

<img src="photos/eg_G.png" width=400px>   

## Karnaugh map (K-map)

Serves as a bridge between Canonical and Standard.

><img src="photos/dim2_Kmap.png" width=400px>  
>
><img src="photos/dim3_Kmap.png" width=400px>  
>
>**Notice that:** m<sub>0</sub> is adjacent to m<sub>2</sub>.

### Alternative Map Labeling

No need of writing Gray codes while processing 3 variables.  
<img src="photos/alter_map_labling.png" width=300px>  

**NOTICE:** Always form the largest rectangular (e.g. 2x2 or 2x4) directly instead of forming several smaller ones.

### <span style="color:red">Don't Cares</span> in K-maps

**Definition:** The outputs of those inputs illegal, whose truth value can be either 0 or 1. <span style="color:grey">(e.g. Let F(x,y,z,w) requires a 4-bits BCD input, making 6 invalid inputs whose output value is not defined and cared about.)</span>

How does this theory simplify our optimization of a circuit?  
<img src="photos/dontcares_apply.png" width=400px>