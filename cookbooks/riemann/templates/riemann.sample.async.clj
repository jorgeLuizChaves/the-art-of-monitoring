; -*- mode: clojure; -*-
; vim: filetype=clojure
(require 'riemann.client)

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

(let [index (index)
; Each batch is sent when 100 events or 1/10th of a second has passed
    downstream (batch 100 1/10 
        (async-queue! :agg {    
            :queue-size 1e3
            :core-pool-size 4
            :max-pool-size  32}
            (forward
                (riemann.client/tcp-client :host "riemannmc"))))]

    (streams
        (default :ttl 60
        index

        #(info %)

        (where (service #"^riemann.*")
            downstream)))
)