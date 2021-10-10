#|
5.1  arg-max
|#
(define (arg-max fun lst)
  (cond
    ((null? (cdr lst)) (car lst))
    ((< (fun (car lst)) (fun (arg-max fun (cdr lst)))) (arg-max fun (cdr lst)))
    (else (car lst))
  )
)

#|
5.2  zip
|#

#|
5.3  unzip
|#
(define (unzip lst n)
  (cond
    ((and (= n 0) (null? lst)) '())
    ((= n 0) (car lst))
    (else (unzip (cdr lst) (- n 1)))
  )
)

#|
5.4  intersectlist
|#
(define (to-set xs) 
  (cond
    ((null? xs) xs)
    ((member (car xs) (cdr xs)) (to-set (cdr xs)))
    (else (cons (car xs) (to-set (cdr xs))))
  )
)

(define (intersectlist lst1 lst2)
  (cond
    ((null? lst1) '())
    ((null? lst2) '())
    ((member (car (to-set lst1)) (to-set lst2))
     (cons (car (to-set lst1)) (intersectlist (cdr (to-set lst1)) (to-set lst2))))
    (else (intersectlist (cdr (to-set lst1)) (to-set lst2)))
  )
)

#|
5.5  sortedmerge
|#
(define (sortedmerge lst1 lst2)
  (cond
    ((null? lst1) lst2)
    ((null? lst2) lst1)
    ((< (car lst1) (car lst2)) (cons (car lst1) (sortedmerge (cdr lst1) lst2)))
    (else (cons (car lst2) (sortedmerge lst1 (cdr lst2))))
  )
)

#|
5.6  interleave
|#
(define (interleave lst1 lst2)
  (cond
    ((null? lst1) lst2)
    ((null? lst2) lst1)
    (else
     (cons (car lst1) (interleave lst2 (cdr lst1))))
  )
)

#|
5.7  map2
|#
(define (len lst)
  (cond
    ((null? lst) 0)
    (else (+ 1 (len (cdr lst))))
  )
)

(define (map2 lst1 lst2 p f)
  (cond
    ((not (= (len lst1) (len lst2))) '(error: two lists are not of the same size))
    ((null? lst1) '())
    ((p (car lst1))
     (cons (f (car lst2)) (map2 (cdr lst1) (cdr lst2) p f)))
    (else
     (cons (car lst2) (map2 (cdr lst1) (cdr lst2) p f)))
  )
)

#|
5.8.a edge-list-to-adjacency-list
|#
(define (edge-list-to-adjacency-list lst)
  (cond
    ((null? lst) '())
    (else
     ((car lst)