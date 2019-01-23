(ns examplecom.etc.elasticsearch
    (:require [riemann.elasticsearch :refer :all]))


(def elasticsearch-url "https://search-easynvest-logs-yw4vdxtfajsqesoyeyy4af4uia.us-east-1.es.amazonaws.com:443")
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