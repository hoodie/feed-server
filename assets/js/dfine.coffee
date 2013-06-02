if window?
  window.dfinitions = {}

  window.dfine = (name, callback) ->
    #switch typeof name
    switch Object.prototype.toString.call(name)
      when '[object Function]'
        callback = name
        name = callback.name
        window.dfinitions[name] = callback
      when '[object Object]'
        object = name
        for name,callback of object
          window.dfinitions[name] = callback
      when '[object Array]'
        dfine object for object in name
      else
        window.dfinitions[name] = callback


  window.rquire = (name) -> window.dfinitions[name]

else if module?
  module.exports.rquire = ()->

  module.exports.dfine = (name, callback)->
    #switch typeof name
    switch Object.prototype.toString.call(name)
      when '[object Function]'
        callback = name
        name = callback.name
        exports[name] = callback
      when '[object Object]'
        object = name
        for name,callback of object
          exports[name] = callback
      when '[object Array]'
        dfine object for object in name
      else
        exports[name] = callback
    exports



