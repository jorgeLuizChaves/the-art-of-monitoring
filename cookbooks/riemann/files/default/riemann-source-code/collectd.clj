(ns examplecom.etc.collectd
  (:require [clojure.tools.logging :refer :all]
            [riemann.streams :refer :all]
            [clojure.string :as str]
            [clojure.walk :as walk]))

(def default-services
  [{:service #"^load/load/(.*)$" :rewrite "load $1"}
   {:service #"^cpu/percent-(.*)$" :rewrite "cpu $1"}
   {:service #"^interface-(.*)/if_(errors|packets|octets)/(tx|rx)$" :rewrite "nic $1 $3 $2"}])

(defn rewrite-service-with
  [rules]
  (let [matcher (fn [s1 s2] (if (string? s1) (= s1 s2) (re-find s1 s2)))]
    (fn [{:keys [service] :as event}]
      (or
       (first
        (for [{:keys [rewrite] :as rule} rules
              :when (matcher (:service rule) service)]
          (assoc event :service
                 (if (string? (:service rule))
                   rewrite
                   (str/replace service (:service rule) rewrite)))))
       event))))

(def rewrite-service
  (rewrite-service-with default-services))

(defn docker-attribute-map
  "Parses labels from collectd plugin_stances" 
  [attributes]
  (let [instance (str/split (str/replace attributes #"^.*\[(.*)\]$" "$1") #",")]
    (walk/keywordize-keys (into {} (for [pair instance] (apply hash-map (str/split pair #"=")))))))

(defn docker-attributes
  "check if our event has any attributes and if it does send it off to be mapped."
  [{:keys [plugin_instance] :as event}]
  (if-let [attributes (re-find #"^.*\[.*\]$" plugin_instance)]
    (merge event (docker-attribute-map attributes))
    event))

  (defn parse-docker-service-host
    "replicate our existing event parsing and rewriting of the :host and :service fields."
    [{:keys [type type_instance plugin_instance] :as event}]
    (let [host (re-find #"^\w+\.?\w+\.?\w+" (:plugin_instance event))
          service (cond-> (str (:type event)) (:type_instance event)
          (str "." (:type_instance event)))]
            (assoc event :service service :host host)))