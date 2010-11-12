(defvar sys (require 'sys)
        utils (require 'utils)
        http (require 'http)
        node-static (require "./node-static/lib/node-static")
        rest (require "./restler/lib/restler")
        jade (require "./jade"))

(defvar server (http.create-server (lambda (request response)
                                     (response.write-head 200 (hash "Content-type" "text/plain"))
                                     (response.end "hello world"))))
(server.listen 8124 "127.0.0.1")

