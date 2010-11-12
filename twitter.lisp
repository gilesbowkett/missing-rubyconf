(defvar http (require 'http))

(chain (http.create-server (lambda (request response)
                             (response.write-head 200 (hash "Content-type" "text/plain"))
                             (response.end "hello world")))
       (listen 8124 "127.0.0.1"))

