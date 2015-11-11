#lang racket
(require "accessors.rkt")
(require "rotor.rkt")
;; a rotor will be a list of 1) the settings 2) the numbers of times
;; it has rotated % 26 3) it's notch 4) the corresponding encryption

;; the letter passed to the next rotor will not fall onto the same position
;; it depends on the number of times this rotor rotated and the next rotor
;; rotated; encryption before the reflector
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define alph (string->list "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))

;; plugs are passed in as a list of strings and converted to a list of string->list
;; pairs of letters: (list (string->list "AD") (string->list "BC"))
(define (encrypt r1 r2 r3 ref string pl init-sets)
  (define plugs (convert-to-list-of-chars pl))
  (define str (string->list string))
  (define is (string->list init-sets))
  (define (iter r1 r2 r3 ref string encoded)
    ;; first must rotate all the rotors
    (if (empty? string) (list->string encoded)
        (if (= -1 (get-idx-of (car string) alph))
            (iter r1 r2 r3 ref (cdr string) (append encoded
                                                    (string->list " ")))
            (let* ((r1first (car (get-rotor-alph r1))) ;; first letter in the first rotor before rotation
               (r2first (car (get-rotor-alph r2))) ;; first letter of second rotor before rotation
               (r11 (rotate-times r1 1)) ;; the first rotor is always rotated
               (r21 (if (or (equal? r1first (car (get-rotor-notch r1)))
                            (equal? r2first (car (get-rotor-notch r2)))) ;; second rotor rotated if first rotor passes the notch
                        ;; or the second rotor is about to pass its notch (if these two happen simultaneously, rotate only once)
                        (rotate-times r2 1) r2))
               (r31 (if (equal? r2first (car (get-rotor-notch r2)))
                        (rotate-times r3 1) r3))) ;; rotate the third rotor is the second rotor passes its notch
              (printf "r1-first: ~a, r2-first: ~a, r1-notch: ~a, r2-notch: ~a\n" r1first r2first
                      (get-rotor-notch r1) (get-rotor-notch r2))
              (printf "Current settings: ~a\n~a\n~a\n\n" (get-rotor-alph r11) (get-rotor-alph r21) (get-rotor-alph r31))
              (iter r11 r21 r31 ref (cdr string)
                     (append encoded (list
                              (get-plug plugs (pass-through
                                               r11 r21 r31 ref
                                               (get-plug plugs
                                                         (car string)))))))))))
  (define rotors (set-rotor-ground-settings is r1 r2 r3))
  (printf "Initial settings: ~a\n~a\n~a\n\n" (car rotors) (cadr rotors) (caddr rotors))
  (iter (car rotors) (cadr rotors) (caddr rotors) ref str (list)))

(provide alph encrypt)