#lang racket
(require rackunit)
(require "enigma3.0.rkt")
(require "rotor.rkt")

(check-equal? (encrypt rIII rII rI rB "AAA" (list) "AAA") "BDZ")
(check-equal? (encrypt rIII rII rI rB "HELLO WORLD" (list) "AAA") "ILBDA AMTAZ")
(check-equal? (encrypt rIII rII rI rB "HIHOWAREYOU" (list) "AAA") "IOTMQWNYGSG")
(check-equal? (encrypt rIII rII rI rB "HIHOWAREYOU" (list) "BAA") "PGKAACTWGLD")
(check-equal? (encrypt rIII rII rI rB "HIHOWAREYOU" (list) "JUT") "OLDJNZLJUVQ")
(check-equal? (encrypt rIII rII rI rB "HIHOWAREYOU" (list) "VDQ") "SDMCEFJJOXM")
(check-equal? (encrypt rIII rII rI rB "BDZ" (list) "AAA") "AAA")
(check-equal? (encrypt rIII rII rI rB "ILBDA AMTAZ" (list) "AAA") "HELLO WORLD")
(check-equal? (encrypt rIII rII rI rB "IOTMQWNYGSG" (list) "AAA") "HIHOWAREYOU")
(check-equal? (encrypt rIII rII rI rB "PGKAACTWGLD" (list) "BAA") "HIHOWAREYOU")
(check-equal? (encrypt rIII rII rI rB "OLDJNZLJUVQ" (list) "JUT") "HIHOWAREYOU")
(check-equal? (encrypt rIII rII rI rB "SDMCEFJJOXM" (list) "VDQ") "HIHOWAREYOU")
(check-equal? (encrypt rIII rII rI rB "SDMCEFJJOXM" (list "AB") "VDQ") "HIHOWBREYOU")
(check-equal? (encrypt rIII rII rI rB "SDMCEFJJOXM" (list "SB") "VDQ") "LIHOWAREYOU")
(check-equal? (encrypt rIII rII rI rB "HELLO WORLD"
                       (list "AB" "HL" "QW") "BAA") "ECKMK QWDNF")
(check-equal? (encrypt rIII rII rI rB "ECKMK QWDNF"
                       (list "AB" "HL" "QW") "BAA") "HELLO WORLD")