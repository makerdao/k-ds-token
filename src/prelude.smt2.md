```smt2
(set-option :auto-config false)
(set-option :smt.mbqi false)
;(set-option :smt.mbqi.max_iterations 15)

; (set-option :auto-config false)
; (set-option :smt.mbqi false)
; (set-option :smt.array.extensional false)

; int extra
(define-fun int_max ((x Int) (y Int)) Int (ite (< x y) y x))
(define-fun int_min ((x Int) (y Int)) Int (ite (< x y) x y))
(define-fun int_abs ((x Int)) Int (ite (< x 0) (- 0 x) x))
```
