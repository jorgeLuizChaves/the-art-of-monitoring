(ns examplecom.etc.graphite
    (:require [riemann.graphite :refer :all]
      [riemann.config :refer :all]))
  
(def environment "productiona.hosts.")
(def environment-docker "productiona.docker.")
(def graphite-url "graphitea")
(def graphite-port 2003)

(defn add-environment-to-graphite [event] 
  (if (= (:plugin event) "docker")
  (str environment-docker, (riemann.graphite/graphite-path-percentiles event))
  (str environment, (riemann.graphite/graphite-path-percentiles event))))
  
  
(def graph (async-queue! :graphite {:queue-size 1000}
  (graphite { :host graphite-url 
              :port graphite-port 
              :path add-environment-to-graphite})))