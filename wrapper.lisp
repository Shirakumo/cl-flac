#|
 This file is a part of cl-flac
 (c) 2017 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(in-package #:org.shirakumo.fraf.flac)

(define-condition flac-error (error)
  ((code :initarg :code :accessor code))
  (:report (lambda (c s) (format s "Flac error ~d: ~a"
                                 (code c) (cl-flac-cffi:strerror (code c))))))

(defmacro with-error (() &body body)
  (let ((result (gensym "RESULT")))
    `(let ((,result (progn ,@body)))
       (unless (eql ,result :no-error)
         (error 'flac-error :code ,result)))))

(defstruct (file (:constructor %make-file (handle))
                 (:conc-name ||))
  (handle cffi:foreign-pointer))

(defun make-file (path)
  (cffi:with-foreign-object (handle :pointer)
    (with-error ()
      (cl-flac-cffi:open-file (uiop:native-namestring path) handle))
    (let* ((handle (cffi:mem-ref handle :pointer))
           (file (%make-file handle)))
      (tg:finalize file (lambda () (cl-flac-cffi:free-file handle)))
      file)))

(defmacro define-deferred (slot)
  (let ((file (gensym "FILE")))
    `(defun ,slot (,file)
       (,(find-symbol (symbol-name slot) :cl-flac-cffi)
        (handle ,file)))))

(define-deferred channels)
(define-deferred sample-rate)
(define-deferred bits-per-sample)
(define-deferred sample-count)
(define-deferred frame-count)

(defun read-directly (file buffer-pointer buffer-size)
  (cl-flac-cffi:read-f32 buffer-pointer
                         (/ buffer-size 4)
                         (handle file)))

(defun read-into-vector (file vector &optional (start 0) end)
  (let ((samples (- (or end (length vector)) start)))
    (etypecase vector
      ((vector single-float)
       (cffi:with-foreign-object (buffer :float samples)
         (cl-flac-cffi:read-f32 buffer samples (handle file))
         (loop for i from 0 below samples
               do (setf (aref vector (+ start i)) (cffi:mem-aref buffer :float i)))))
      ((vector (signed-byte 16))
       (cffi:with-foreign-object (buffer :int16 samples)
         (cl-flac-cffi:read-s16 buffer samples (handle file))
         (loop for i from 0 below samples
               do (setf (aref vector (+ start i)) (cffi:mem-aref buffer :int16 i)))))
      ((vector signed-byte)
       (cffi:with-foreign-object (buffer :int32 samples)
         (cl-flac-cffi:read-s32 buffer samples (handle file))
         (loop for i from 0 below samples
               do (setf (aref vector (+ start i)) (cffi:mem-aref buffer :int32 i))))))))

(defun read-to-vector (file samples)
  (let ((vector (make-array samples :element-type 'single-float)))
    (values vector
            (read-into-vector file vector))))
