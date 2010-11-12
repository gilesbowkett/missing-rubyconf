(defvar http (require 'http)
        sys (require 'sys)
        node-static (require "./vendor/node-static/lib/node-static")
        restler (require "./vendor/restler/lib/restler")
        jade (require "./vendor/jade"))

(chain (http.create-server (lambda (request response)
                             (defun simple-output (error html)
                               (response.end html))
                             (response.write-head 200 (hash "Content-type" "text/plain"))
                             (jade.render-file "index.jade", (hash), simple-output)))
       (listen 8124 "127.0.0.1"))

