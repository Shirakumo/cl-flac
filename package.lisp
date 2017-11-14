#|
 This file is a part of cl-flac
 (c) 2017 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:cl-user)
(defpackage #:cl-flac-cffi
  (:nicknames #:org.shirakumo.fraf.flac.cffi)
  (:use #:cl #:cffi)
  ;; low-level.lisp
  (:export))

(defpackage #:cl-flac
  (:nicknames #:org.shirakumo.fraf.flac)
  (:use #:cl)
  ;; wrapper.lisp
  (:export))
