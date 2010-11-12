(defvar http (require 'http)
        sys (require 'sys)
        node-static (require "./vendor/node-static/lib/node-static")
        restler (require "./vendor/restler/lib/restler")
        jade (require "./vendor/jade"))

(chain (http.create-server (lambda (request response)
                             (response.write-head 200 (hash "Content-type" "text/html"))
                             (defun simple-output (error html)
                               (sys.puts error)
                               (response.end html))
                             (defvar api-url "http://search.twitter.com/search.json?q=rubyconf")
                             (chain (restler.get api-url (hash data (hash)))
                                    (add-listener "complete" (lambda (data twitter-response)
                                                               (jade.render-file "index.jade"
                                                                                 (hash locals (hash data data
                                                                                                    response twitter-response))
                                                                                 simple-output))))))
       (listen 8124 "127.0.0.1"))

