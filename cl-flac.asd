(asdf:defsystem cl-flac
  :version "1.0.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
  :description "Bindings to libflac, a simple FLAC decoding library"
  :homepage "https://shirakumo.org/docs/cl-flac/"
  :bug-tracker "https://shirakumo.org/project/cl-flac/issues"
  :source-control (:git "https://shirakumo.org/project/cl-flac.git")
  :serial T
  :components ((:file "package")
               (:file "low-level")
               (:file "wrapper")
               (:file "documentation"))
  :depends-on (:cffi
               :pathname-utils
               :trivial-features
               :trivial-garbage
               :documentation-utils))
