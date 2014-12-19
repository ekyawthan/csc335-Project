##The Generic Definition and Procedure of Symbolic Polynomial In Scheme 
---
###programming language Paradigm
###Fall 2014
###Computer Science Department 
###CCNY, The City University of New York.
---
####By
<Strong>Kyaw Than Mong <br>

Joe

Ahmed


##Introduction
<P>
As an example of symbolic manipulation and data abstraction in Scheme , the design of generic polynomial definition and procedure can be one way to illustrate the understanding of Scheme symbolic manipulation and design.
In developing the symbolic polynomial generic system, we will define a generic symbolic polynomial system with the  capabilities of addition , subtraction, multiplication , derivative , and integral of the polynomial.  Thus , the system will be capable of handling symbolic manipulation of polynomial.<p>

---
##Construction of Symbolic Polynomial :
<P>We are proposing to use univariable symbolic polynomial. Thus we define our constructor for symbolic polynomial as follow - <p><br>
```scheme
; Constructor: 
;(note: Describes how we will store our data structure, polynomial)
; Pre-Condition: variable must be a symbol, list must be a list of atoms 
;(ints or symbols), no element may be a list
; Post-Condition: Returns a new list with var as the first element,
; the first element in the list will be of var to power 0 and increase 
; from there.
; ex: (1 4 5 3 6) will mean (1 4x (5x^2) (3x^3) (6x^4))
(define (make-poly var list)
  (if (not (and (list? list) (symbol? var))) (quote Error) (cons var list)))
  ```
  
