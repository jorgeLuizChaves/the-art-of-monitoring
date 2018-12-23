; -*- mode: clojure; -*-
; vim: filetype=clojure

(logging/init {:file "riemann.log"})

; Listen on the local interface over TCP (5555), UDP (5555), and websockets
; (5556)
(let [host "0.0.0.0"
      repl "127.0.0.1"
      tcp-port 5555
      udp-port 5555
      ws-port 5556]
  (tcp-server {:host host :port tcp-port})
  (udp-server {:host host :port udp-port})
  (ws-server  {:host host :port ws-port})
  (repl-server {:host "127.0.0.1"}))

; Expire old events from the index every 5 seconds.
(periodically-expire 5)

(let [index (index)
      infra-ttl 25
      app-ttl 5]
  ; Inbound events will be passed to these streams:
  (streams
    (default :ttl infra-ttl
      ; Index all events immediately.
      index

      ; Log expired events.
      ; (expired
      ;  (fn [event] (info "expired" event))))))
      
        #(info "prefix" %))))
