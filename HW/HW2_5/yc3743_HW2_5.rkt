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

(define (zip . lst)
  lst
)

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
(define (mem elem lis)
  (cond
    ((null? lis) #f)
    ((= elem (car lis)) lis)
    (else (mem elem (cdr lis)))
  )
)

(define (to-set xs) 
  (cond
    ((null? xs) xs)
    ((mem (car xs) (cdr xs)) (to-set (cdr xs)))
    (else (cons (car xs) (to-set (cdr xs))))
  )
)

(define (intersectlist lst1 lst2)
  (cond
    ((null? lst1) '())
    ((null? lst2) '())
    ((mem (car (to-set lst1)) (to-set lst2))
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
5.8.a  edge-list-to-adjacency-list
|#
(define (app lst1 lst2)
  (cond
    ((null? lst1) lst2)
    (else
     (cons (car lst1) (app (cdr lst1) lst2)))
  )
)

(define (in node lst)
  (cond
    ((null? lst) #f)
    ((member node (caar lst)) #t)
    (else
     (in node (cdr lst)))
  )
)

(define (add node1 node2 lst)
  (cond
    ((not (in node1 lst))
     (cond
       ((not (in node2 lst))
        (cons (cons (cons node1 '()) (cons (cons node2 '()) '()))
              (cons (cons (cons node2 '()) (cons '() '())) lst)))
       (else (cons (cons (cons node1 '()) (cons (cons node2 '()) '())) lst))
     )
    )
    (else
     (cond
       ((equal? node1 (caaar lst)) (cons (cons (cons node1 '()) (cons (app (cadar lst) (cons node2 '())) '())) (cdr lst)))
       (else
        (add node1 node2 (app (cdr lst) (cons (car lst) '()))))
     ))
  )
)

(define (edge-list-to-adjacency-list lst)
  (cond
    ((null? lst) '())
    (else
     (add (caar lst) (cadar lst) (edge-list-to-adjacency-list (cdr lst))))
  )
)

#|
5.8.b  adjacency-list-to-edge-list
Notice: when testing the function, the input list should only have one quote at the beginning, such as '(((a) (b c)))
|#
(define (edge-one-node lst1 lst2)
  (cond
    ((null? lst2) '())
    (else
     (cons (cons (car lst1) (cons (car lst2) '()))
           (edge-one-node lst1 (cdr lst2))
     )
    )
  )
)
  
(define (adjacency-list-to-edge-list lst)
  (cond
    ((null? lst) '())
    (else
     (app (edge-one-node (car (car lst)) (car (cdr (car lst))))
           (adjacency-list-to-edge-list (cdr lst))))
  )
)

     