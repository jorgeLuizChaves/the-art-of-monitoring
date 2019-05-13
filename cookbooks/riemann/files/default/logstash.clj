(ns examplecom.etc.logstash
  (:require [riemann.logstash :refer :all]
    [riemann.config :refer :all]))
; throuput problems can be releated to how much message can riemann send
(def port-size 20)

(def logstash-send (async-queue! :logstash {:queue-size 1000}
             (logstash {:host "10.20.0.8" 
                        :port 2003 })))