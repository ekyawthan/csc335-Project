; Name: Set
; Author: Michael Cunha

; This Program implements a mathematical set handler. The program is capable of working with sets in 
;     4 forms; Lists, Trees, Hash Tables, Files
; Note that a set in a file form contains in it the type of representation it is.

; To add new underlying data structures to this program, simply intall a new package implementing the basic interfaces. 
; Than, update line 5, colum 5 of this file with total number of forms and append the new forms to the end of the list.
; 

; This file is organiszed in Layers. each Level has some underlying assumptions for its conteining definitions.
; Here is a quick discription of each Layer
;    Layer 0: Program level where the multiple reprensentation of sets is maintained, organized and stored. One single universal
;        table is kept with all curent packages and underlaying data forms.
;    Layer 1: Layer where Data Structure level (basic) interfaces are mentainned. Here is where all the different 
;        set packages are defined. The assumption of this layer is that a set is handed to it and a set is hand off by it.
;    Layer 2: In this layer the usual set operations are implemented. Here we work with a two element datum. The first element is
;        the type the second the set itself.
;    Layer 3: On this layer we install and load all nessesary parts for the set interpreter to work.

;------------------------------------------------------ LAYER 0 ----------------------------------------------------------
; Reference for this functions are in SICP section 3.3.3

(define (get key-1 key-2)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record (cdr record) false))
        false)))

(define (put key-1 key-2 value)
  (let ((subtable (assoc key-1 (cdr table))))
    (if subtable
        (let ((record (assoc key-2 (cdr subtable))))
          (if record
              (set-cdr! record value)
              (set-cdr! subtable (cons (cons key-2 value) (cdr subtable)))))
        (set-cdr! table (cons (list key-1 (cons key-2 value)) (cdr table)))))
  'ok)

(define (make-table)
  (list '*table*))

;------------------------------------------------------ LAYER 1 -----------------------------------------------------------
; Reference for this functions are in SICP section 2.4 and 2.5
(define (install-set-list)
 ;              ********************************** List Data Structure Fuctions ******************************* 
  (define (make-set lst)
    lst)
  
  (define (print-set set)
    (define (print-member element)
      (display " ")
      (display element)
      (display " "))
    (define (print-body set)
      (cond
        ((null? set) (display "}"))
        (else (print-member (car set)) (print-body (cdr set)))))
    (display "{")
    (print-body set))
  
  (define (add-set element set)
    (append set (list element)))
  
  (define (belong? element set)
    (cond
      ((null? set) #f)
      ((eq? (car set) element) #t)
      (else (belong? element (cdr set)))))
  
  (define (length? set)
    (cond
      ((null? set) 0)
      (else (+ 1 (length? (cdr set))))))
  
  (define (move-cursor set)
    (cond
      ((null? set) '())
      (else (cdr set))))
  
  ;              ********************************** Instaling Definitions ***********************************
  
  (put 'lst 'make-set make-set)
  (put 'lst 'print-set print-set)
  (put 'lst 'add-set add-set)
  (put 'lst 'belong? belong?)
  (put 'lst 'length? length?)
  (put 'lst 'move-cursor move-cursor)
  
   "List Package installed")

;-------------------------------------------------- LAYER 2 -----------------------------------------------------------------

(define (get-set data)
  (cdr data))

(define (get-type data)
  (car data))

(define (make-set type lst)
  (cons type ((get type 'make-set) lst)))

(define (add-set element data)
  (cond
    ((belong? element data) data)
    (else (cons (get-type data) ((get (get-type data) 'add-set) element (get-set data))))))

(define (belong? element data)
  ((get (get-type data) 'belong?) element (get-set data)))

(define (length? data)
  ((get (get-type data) 'length?) (get-set data)))

(define (print-set data)
  ((get (get-type data) 'print-set) (get-set data)))

(define (move-cursor data)
  (cons (get-type data) (get (get-type data) 'move-cursor (get-set data))))

;-------------------------------------------------- LAYER 3 ------------------------------------------------------------------

;(define (intersection set1 set2)
;  (let (result (make-set 'lst '())
;    ((<= (length? set1) (length? set2))))))
     

(define table (make-table))
(install-set-list)