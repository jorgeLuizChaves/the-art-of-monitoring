; -*- mode: clojure; -*-
; vim: filetype=clojure
(require 'riemann.client)
; (require '[examplecom.etc.email :refer :all])
(require '[examplecom.etc.graphite :refer :all])
(require '[examplecom.etc.checks :refer :all])
(require '[examplecom.etc.collectd :refer :all])
(require '[examplecom.etc.slack :refer :all])
(require '[examplecom.etc.logstash :refer :all])

(logging/init {:file "/var/log/riemann.log"})

; Listen on the local interface over TCP (5555), UDP (5555), and websockets
; (5556)
(let [
        host "0.0.0.0"
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

        (let [index (tap :index (index))
        ; Each batch is sent when 100 events or 1/10th of a second has passed
            downstream (batch 10 1/10 
                (async-queue! :agg {    
                    :queue-size 1e3
                    :core-pool-size 4
                    :max-pool-size  32}
                    (forward
                        (riemann.client/tcp-client :host "riemannmc" :port 5555))))]
            
            ; (tagged "collectd"
            ;     (where (not (= (:plugin event) "docker")))
            ;     (smap rewrite-service graph))
        
        (streams
            (default :ttl 60
            index
            ; (tagged "logstash_events"
            ;     #(info %)
            ;     logstash-send)
            ; (tagged "collectd"
            ;     logstash-send)
            #(info %)
            graph
            
            ; (tagged "logstash_events"
            ;     (where (not (= (:plugin event) "docker"))
            ;         (smap rewrite-service graph))
              
            ;     (where (= (:plugin event) "docker")
            ;       (smap #(assoc % :host (:plugin_instance %) :service (cond-> (str (:type %)) (:type_instance %) (str "." (:type_instance %))) )
            ;       (smap (comp parse-docker-service-host docker-attributes rewrite-service) graph))))
                    ))

            ; (streams
            ;     (default :ttl 60
            ;     index
            ;     ; (tagged "collectd"  #(info %))
            ;     #(info %)
            ;     ; graph
            ;     (where (= (:plugin event) "docker")
            ;     (smap (comp parse-docker-service-host docker-attributes rewrite-service) graph))
            ; (by :host
            ;     (check_percentiles "cpu/percent-user" 10 (smap rewrite-service graph))
            ;     (check_threshold "cpu/percent-user" 10 folds/median 80.0 90.0 (rollup 2 360 #(info %)))
            ;     (check_threshold "memory/percent-used" 10 folds/median 80.0 90.0 (rollup 2 360 #(info %))))
                ; {:host riemanna, :service cpu/percent-user
                 
                    ; (where 
                    ;     (and 
                    ;         (service "cpu/percent-user") 
                    ;         (> metric 60)) 
                    ;     (rollup 2 360 (slacker)))
                    
                ; (slacker)
                ; (where (service #"^riemann.*")
                    ; downstream))
                ; ))
            
            ; (streams
            ;     (default :ttl 60
            ;     index
            ;     #(prn "sending email: " %)
            ;     (where (service #"^riemann.*")
            ;         #(prn email %))))
        )

        (tests
            (deftest index-test
              (is (= (inject! [{:service "test"
                                :time    1}])
                     {:index [{:service "test"
                               :time    1
                               :ttl     60}]}))))