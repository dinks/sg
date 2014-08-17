topics = {}

jQuery.Topic = (id)->
  topic = id and topics[id]
  if !topic
    callbacks = jQuery.Callbacks()
    topic =
      publish: callbacks.fire
      subscribe: callbacks.add
      unsubscribe: callbacks.remove
    if id
      topics[id] = topic
  topic
