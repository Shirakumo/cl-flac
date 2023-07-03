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
   #:close-file
   #:channels
   #:samplerate
   #:bits-per-sample
   #:sample-count
   #:frame-count
   #:read-directly
   #:read-into-vector
   #:read-to-vector
   #:seek))
