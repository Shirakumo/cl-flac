(ql:quickload '(cl-out123 cl-flac))

(defun play (path)
  (let* ((file (cl-flac:make-file path))
         (out (cl-out123:connect (cl-out123:make-output NIL)))
         (buffersize (* (cl-flac:channels file)
                        (/ (cl-flac:samplerate file) 100))))
    (cl-out123:start out :rate (cl-flac:samplerate file)
                         :channels (cl-flac:channels file)
                         :encoding :float)
    (unwind-protect
         (cffi:with-foreign-object (buffer :float buffersize)
           (loop for read = (cl-flac:read-directly file buffer (* buffersize 4))
                 for played = (cl-out123:play out buffer read)
                 while (< 0 read)
                 do (when (/= played read)
                      (format T "~&Warning: playback not catching up with input by ~a bytes."
                              (- read played)))))
      (cl-out123:stop out)
      (cl-out123:disconnect out)
      (cl-flac:close-file file))))