(ns examplecom.etc.logstash
    (:require [riemann.logstash :refer :all]))

  (def logstash-url "logstash")

  (def logstash (async-queue! :logstash {:queue-size 1000}
               (logstash {:host logstash-url 
                          :port 2003 
                          :port-size 20})))