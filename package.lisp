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
  (:export
   #:libflac
   #:error
   #:open-file
   #:free-file
   #:channels
   #:sample-rate
   #:bits-per-sample
   #:sample-count
   #:frame-count
   #:read-s16
   #:read-s32
   #:read-f32
   #:seek
   #:strerror))

(defpackage #:cl-flac
  (:nicknames #:org.shirakumo.fraf.flac)
  (:use #:cl)
  ;; wrapper.lisp
  (:export
   #:file
   #:handle
   #:make-file
   #:channels
   #:sample-rate
   #:bits-per-sample
   #:sample-count
   #:frame-count
   #:read-directly
   #:read-into-vector
   #:read-to-vector))
