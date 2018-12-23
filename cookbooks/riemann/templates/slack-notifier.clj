(def slacker 
  (slack credentials 
    { :username "Riemann bot", 
      :channel "#monitoring"
      :formatter (fn [e] 
        { :text (:state e)
          :icon ":happy:"})))