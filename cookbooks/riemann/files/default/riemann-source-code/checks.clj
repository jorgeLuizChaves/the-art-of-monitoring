(ns examplecom.etc.checks
  (:require [clojure.tools.logging :refer :all]
            [riemann.streams :refer :all]))

(defn set_state [warning critical]
  (fn [event]
     (assoc event :state
        (condp < (:metric event)
                  critical "critical"
                  warning "warning"
                  "ok"))))
  
(defn check_threshold
  "Check threshold of a specific service"
  [srv window func warning critical & children]
  (where (service srv)
    (fixed-time-window window
      (smap func
        (where (< warning metric)
          (smap (set_state warning critical)
            (fn [event]
              (call-rescue event children))))))))
  
(defn check_percentiles 
  "Check percentiles of a specific service and stream to another function"
  [srv window & children]
  (where (service srv)
    (percentiles window [0.5 0.95 0.99 1]
      (fn [event]
        (call-rescue event children)))))