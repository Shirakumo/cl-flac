(asdf:defsystem cl-flac
  :version "1.0.0"
  :license "zlib"
  :author "Yukari Hafner <shinmera@tymoon.eu>"
  :maintainer "Yukari Hafner <shinmera@tymoon.eu>"
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
               :pathname-utils
               :trivial-features
               :trivial-garbage
               :documentation-utils))
