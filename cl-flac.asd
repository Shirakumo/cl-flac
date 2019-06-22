#|
 This file is a part of cl-flac
 (c) 2017 Shirakumo http://tymoon.eu (shinmera@tymoon.eu)
 Author: Nicolas Hafner <shinmera@tymoon.eu>
|#

(asdf:defsystem cl-flac
  :version "1.0.0"
  :license "zlib"
  :author "Nicolas Hafner <shinmera@tymoon.eu>"
  :maintainer "Nicolas Hafner <shinmera@tymoon.eu>"
  :description "Bindings to libflac, a simple FLAC decoding library"
  :homepage "https://Shirakumo.github.io/cl-flac/"
  :bug-tracker "https://github.com/Shirakumo/cl-flac/issues"
  :source-control (:git "https://github.com/Shirakumo/cl-flac.git")
  :serial T
  :components ((:file "package")
               (:file "low-level")
               (:file "wrapper")
               (:file "documentation"))
  :depends-on (:cffi
               :trivial-features
               :trivial-garbage
               :documentation-utils))
