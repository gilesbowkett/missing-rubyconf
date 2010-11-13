; I created this just to figure out wtf was up node-static here (answer: use the "new'
; macro correctly), but if you want a simple Sibilant / Node.js static file server,
; here you go.

;;  var nodeStatic = require("./vendor/node-static/lib/node-static");
;;  var fileServer = new nodeStatic.Server('./public', {});

;;  require('http').createServer(function (request, response) {
;;    request.addListener('end', function () {
;;      fileServer.serve(request, response);
;;    });
;;  }).listen(3002, "67.23.3.57");

(defvar node-static (require "./vendor/node-static/lib/node-static")
        file-server (new (node-static.-server "./public" (hash cache false))))

(chain
  (chain (require 'http)
         (create-server (lambda (request response)
                           (request.add-listener "end" (lambda ()
                                                          (file-server.serve request response))))))
  (listen 3002 "67.23.3.57"))

