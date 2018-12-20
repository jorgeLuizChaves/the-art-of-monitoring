; -*- mode: clojure; -*-
; vim: filetype=clojure

(logging/init {:file "riemann.log"})

; Listen on the local interface over TCP (5555), UDP (5555), and websockets
; (5556)
(let [host "0.0.0.0"
      repl "127.0.0.1"
      tcp-port 5555
      udp-port 5555
      ws-port 5556
      repl-port 5557]
  (tcp-server {:host host :port tcp-port})
  (udp-server {:host host :port udp-port})
  (ws-server  {:host host :port ws-port})
  (repl-server {:host repl :port repl-port}))

; Expire old events from the index every 5 seconds.
(periodically-expire 5)

; Choose custom fields
; (periodically-expire 5 {:keep-keys [:host :service :tags]})

(let [index (index)]
  ; Inbound events will be passed to these streams:
  (streams
    (default :ttl 60
      ; Index all events immediately.
      index

      ; log riemann file
      ; #(info %)
      ; log riemann file w/ prefix
      ; #(info "prefix" %)
      ; specific fields
      ; #(info (:host %) (:service %))
      ; Print "output", then the event
        #(prn "STDOUT: " %)
      ; (where (and (service "disk /") (> metric 0.01))
      ;   #(info "Disk space on / is over 10%!" %))

      ; filters can be used to 

      ; Log expired events.
      (expired
        (fn [event] (info "expired" event))))))
