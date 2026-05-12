# **CLASS FOUR**

## Quine-McCluskey algorithm

**Implicant, Prime Implicant, Essential Prime Implicant:**  

>**Implicant**  
A product that implies the function is true, meaning <u>whenever the term is true, the function is true</u>.  

<span style="color:yellow">

**How to count implicants?**  
Every rectangle containing 2<sup>n</sup> blocks with <u>at least one "1" </u> and several don't-cares is called an implicant.

</span>

>**Prime Implicant**  
An implicant that cannot be expanded by removing a literal — i.e., it is maximal. In a Karnaugh map, it is the largest possible rectangular group in its region, but “largest” means it cannot be enlarged further without including a 0; <u>different prime implicants may have different sizes</u>.

>**Essential Prime Implicant**  
A prime implicant that covers at least one minterm (a distinguished minterm) covered by no other prime implicant, so it must appear in every minimal sum‑of‑products expression.

### Algorithm Steps

1. Find all prime implicants. 
2. Include all essential prime implicants in the solution.
3. Find a cover with minimum cost.