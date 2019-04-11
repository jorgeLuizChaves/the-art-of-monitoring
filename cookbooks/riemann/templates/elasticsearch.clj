(ns examplecom.etc.elasticsearch
    (:require [riemann.elasticsearch :refer :all]))


(def elasticsearch-url "localhost-address")
(def index "gocd")
(def index-suffix "-yyyy.MM.DD")
(def tags ["gocd-metrics"])

(defn send-elasticsearch [e]
    (elasticsearch
        ; ES options
        {:es-endpoint elasticsearch-url
        :es-index index
        :index-suffix index-suffix}
        ; (optional) custom event formatter
        (fn [event]
          (let
            [newtags (concat (:tags event) tags)]
            (merge event {:tags newtags})))))