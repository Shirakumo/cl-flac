(in-package #:org.shirakumo.fraf.flac.cffi)

(defvar *here* #.(or *compile-file-pathname* *load-pathname* *default-pathname-defaults*))
(defvar *static* (make-pathname :name NIL :type NIL :defaults (merge-pathnames "static/" *here*)))
(pushnew *static* cffi:*foreign-library-directories*)

(define-foreign-library libflac
  (:darwin (:or #+X86 "mac32-libflac.dylib"
                #+X86-64 "mac64-libflac.dylib"
                "libflac.dylib" "libflac.so"))
  (:unix (:or #+X86 "lin32-libflac.so"
              #+X86-64 "lin64-libflac.so"
              "libflac.so"))
  (:windows (:or #+X86 "win32-libflac.dll"
                 #+X86-64 "win64-libflac.dll"
                 "libflac.dll" "flac.dll"))
  (t (:default "flac")))

(use-foreign-library libflac)

(defctype flac-file :pointer)

(defcenum error
  :no-error
  :open-failed
  :bad-file
  :seek-too-far
  :seek-failed)

(defcfun (open-file "flac_open") error
  (path :string)
  (file :pointer))

(defcfun (free-file "flac_free") :void
  (file :pointer))

(defcfun (channels "flac_channels") :uint8
  (file :pointer))

(defcfun (sample-rate "flac_sample_rate") :uint32
  (file :pointer))

(defcfun (bits-per-sample "flac_bits_per_sample") :uint8
  (file :pointer))

(defcfun (sample-count "flac_sample_count") :uint64
  (file :pointer))

(defcfun (frame-count "flac_frame_count") :uint64
  (file :pointer))

(defcfun (read-s16 "flac_read_s16") :uint64
  (data :pointer)
  (samples :uint64)
  (file :pointer))

(defcfun (read-s32 "flac_read_s32") :uint64
  (data :pointer)
  (samples :uint64)
  (file :pointer))

(defcfun (read-f32 "flac_read_f32") :uint64
  (data :pointer)
  (samples :uint64)
  (file :pointer))

(defcfun (seek "flac_seek") error
  (sample :uint64)
  (file :pointer))

(defcfun (strerror "flac_strerror") :string
  (error error))
