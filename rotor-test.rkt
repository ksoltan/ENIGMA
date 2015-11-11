#lang racket
(require rackunit)
(require "rotor.rkt" "accessors.rkt")

(define rots (set-rotor-ground-settings (string->list "GUX") rIII rII rI))
(define rots2 (set-rotor-ground-settings (string->list "XDR") rIII rII rI))
(printf "~a\n~a\n~a\n\n" (car rots2) (cadr rots2) (caddr rots2))
;; check getting idx forward
(check-equal? (get-idx-next-letter-forward (rotate rI) rII 4) 3)
(check-equal? (get-idx-next-letter-forward rII rIII 4) 4)
(check-equal? (get-idx-next-letter-forward (rotate (rotate rI)) rII 6) 4)
(check-equal? (get-idx-next-letter-forward (rotate rI) (rotate rII) 4) 4)
(check-equal? (get-idx-next-letter-forward (rotate (rotate rI)) (rotate rII) 6) 5)
(check-equal? (get-idx-next-letter-forward rI (rotate (rotate rII)) 2) 4)

(check-equal? (get-idx-next-letter-forward a (rotate (car rots)) 1) 8)
(check-equal? (get-idx-next-letter-forward (rotate (car rots)) (cadr rots) 16) 3)

;; check getting idx backward
(check-equal? (get-idx-next-letter-backward  rII (rotate rI) 5) 6)
(check-equal? (get-idx-next-letter-backward rIII rII 19) 19)
(check-equal? (get-idx-next-letter-backward rII (rotate (rotate rI)) 4) 6)
(check-equal? (get-idx-next-letter-backward (rotate rII) (rotate rI)  15) 15)
(check-equal? (get-idx-next-letter-backward (rotate rII) (rotate (rotate rI)) 19) 20)
(check-equal? (get-idx-next-letter-backward (rotate (rotate rII)) rI 21) 19)
(check-equal? (get-idx-next-letter-backward rB (rotate rI) 25) 26)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(check-equal? (pass-through-rotor-forward (rotate rIII) 1) 4)
(check-equal? (pass-through-rotor-forward rII 4 (rotate rIII)) 4)
(check-equal? (pass-through-rotor-forward rI 4 rII) 6)
(check-equal? (pass-through-ref rB rI 6) 19)
(check-equal? (pass-through-rotor-backward rI 19 rB) 19)
(check-equal? (pass-through-rotor-backward rII 19 rI) 5)
(check-equal? (pass-through-rotor-backward (rotate rIII) 5 rII) 3)

(check-equal? (pass-through-rotor-forward (cadr rots) 16 (rotate (car rots))) 4)
(check-equal? (pass-through-rotor-forward (caddr rots) 4 (cadr rots)) 4)
(check-equal? (pass-through-rotor-forward (rotate (car rots)) 1) 16)
(check-equal? (pass-through-ref rB (caddr rots) 4) 12)
(check-equal? (pass-through-rotor-backward (caddr rots) 12 rB) 22)
(check-equal? (pass-through-rotor-backward (cadr rots) 22 (caddr rots)) 5)
(check-equal? (pass-through-rotor-backward (rotate (car rots)) 5 (cadr rots)) 9)

(check-equal? (pass-through (rotate rIII) rII rI rB (car (string->list "A"))) (car (string->list "B")))
(check-equal? (pass-through (rotate (car rots)) (cadr rots) (caddr rots) rB (car (string->list "A")))
              (car (string->list "B")))

(check-equal? (get-plug (list (string->list "SB")) (car (string->list "S"))) (car (string->list "B")))
(check-equal? (get-plug (list (string->list "SB") (string->list "AD")) (car (string->list "D"))) (car (string->list "A")))
(check-equal? (get-plug (list (string->list "SB") (string->list "AD")) (car (string->list "A"))) (car (string->list "D")))
(check-equal? (get-plug (list (string->list "SB") (string->list "AD")) (car (string->list "S"))) (car (string->list "B")))
(check-equal? (get-plug (list (string->list "SB") (string->list "AD")) (car (string->list "B"))) (car (string->list "S")))


(check-equal? (get-plug (list (string->list "AB") (string->list "CD") (string->list "FK"))
                        (car (string->list "A"))) (car (string->list "B")))
(check-equal? (get-plug (list (string->list "AB") (string->list "CD") (string->list "FK"))
                        (car (string->list "H"))) (car (string->list "H")))
(check-equal? (get-plug (list (string->list "AB") (string->list "CD") (string->list "FK"))
                        (car (string->list "B"))) (car (string->list "A")))
(check-equal? (get-plug (list (string->list "AB") (string->list "CD") (string->list "FK"))
                        (car (string->list "K"))) (car (string->list "F")))