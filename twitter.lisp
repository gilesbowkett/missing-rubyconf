(defvar http (require 'http)
        sys (require 'sys)
        utils (require 'utils)
        node-static (require "./vendor/node-static/lib/node-static")
        restler (require "./vendor/restler/lib/restler")
        jade (require "./vendor/jade"))

(chain (http.create-server (lambda (request response)

                             ;; static server
                             (defvar static-server (new (node-static.-server "./public" (hash cache false))))

                             (defvar path (request.url.replace /\// ""))
                             (switch path
                               (""
                                 (response.write-head 200 (hash "Content-type" "text/html"))
                                 ;; main response
                                  (defun simple-output (error html)
                                    ; (sys.puts error)
                                    (response.end html))
                                  (defvar api-url "http://search.twitter.com/search.json?q=rubyconf&rpp=100")
                                  (chain (restler.get api-url (hash data (hash)))
                                         (add-listener "complete" (lambda (data twitter-response)
                                                                    (jade.render-file "index.jade"
                                                                                      (hash locals (hash data data
                                                                                                         response twitter-response))
                                                                                      simple-output)))))
                               (default
                                 ;; static response
                                 (static-server.serve request response)))))
       (listen 3002 "67.23.3.57"))

