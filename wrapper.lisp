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

(defstruct (file (:constructor %make-file (path handle))
                 (:conc-name ||))
  (path pathname :read-only T)
  (handle cffi:foreign-pointer))

(defmethod print-object ((file file) stream)
  (print-unreadable-object (file stream :type T)
    (format stream "~s" (path file))))

(defun make-file (path)
  (let ((path (pathname-utils:native-namestring path)))
    (cffi:with-foreign-object (handle :pointer)
      (with-error ()
        (cl-flac-cffi:open-file path handle))
      (let* ((handle (cffi:mem-ref handle :pointer))
             (file (%make-file path handle)))
        (tg:finalize file (lambda () (cl-flac-cffi:free-file handle)))
        file))))

(defun close-file (file)
  (cl-flac-cffi:free-file (handle file))
  (tg:cancel-finalization file)
  (setf (handle file) (cffi:null-pointer))
  file)

(defmacro define-cfun-wrapper (slot &optional cfun)
  (let ((file (gensym "FILE")))
    `(defun ,slot (,file)
       (,(or cfun (find-symbol (symbol-name slot) :cl-flac-cffi))
        (handle ,file)))))

(define-cfun-wrapper channels)
(define-cfun-wrapper samplerate cl-flac-cffi:sample-rate)
(define-cfun-wrapper bits-per-sample)
(define-cfun-wrapper sample-count)
(define-cfun-wrapper frame-count)

(defun read-directly (file buffer-pointer buffer-size)
  (* (cl-flac-cffi:read-f32 buffer-pointer
                            (/ buffer-size 4)
                            (handle file))
     4))

(defun read-into-vector (file vector &optional (start 0) end)
  (let ((samples (- (or end (length vector)) start)))
    (macrolet ((%i (type)
                 `(cffi:with-foreign-object (buffer ,type samples)
                    (let ((read (cl-flac-cffi:read-f32 buffer samples (handle file))))
                      (dolist (i read read)
                        (setf (aref vector (+ start i)) (cffi:mem-aref buffer ,type i)))))))
      (etypecase vector
        ((vector single-float)
         (%i :float))
        ((vector (signed-byte 16))
         (%i :int16))
        ((vector (signed-byte 32))
         (%i :int32))))))

(defun read-to-vector (file samples)
  (let ((vector (make-array samples :element-type 'single-float)))
    (values vector
            (read-into-vector file vector))))

(defun seek (file frame)
  (let ((handle (handle file)))
    (with-error ()
      (cl-flac-cffi:seek (* frame (cl-flac-cffi:channels handle)) handle)))
  file)
