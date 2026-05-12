# **CLASS SIX**

## **Propagation delay**

Propagation delay (*t<sub>pd</sub>*) is the finite time required for a change at the input of a logic gate to be reflected at its output.

### **Definitions**

- ***t<sub>PHL</sub>*** – Time for output to fall from High to Low (50% to 50%).
- ***t<sub>PLH</sub>*** – Time for output to rise from Low to High (50% to 50%).

Average propagation delay:  
$$ t_{pd} = \frac{t_{PHL} + t_{PLH}}{2} $$

### **Why It Matters**

#### **Maximum Clock Frequency**
The total delay along the **critical path** (longest logic chain between two flip‑flops) limits the clock period:

$$ T_{clock} > t_{pd(FF)} + t_{pd(logic)} + t_{setup} $$

Exceeding this causes **setup‑time violations**.

#### **Glitches**
Because signals do not change instantaneously, momentary incorrect outputs can appear.  
Example: ***AA'*** briefly becomes **1** due to inverter delay before settling to **0**.

#### **Adder Architecture**
- **Ripple‑carry adder:** Delay grows linearly with bit‑width.
- **Carry‑lookahead adder:** Reduces delay to roughly **constant** time, regardless of bit‑width.

### **Contamination Delay**
- ***t<sub>pd</sub>*** – Longest time until output is **valid** (worst‑case).
- ***t<sub>cd</sub>*** – Shortest time until output **begins** to change (best‑case).


