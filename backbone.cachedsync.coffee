((window) ->
    Backbone = window.Backbone
    _ = window._
    $ = window.$
    localStorage = window.localStorage

    Backbone.Collection.prototype.sync = (method, collection, options) ->
        if not collection.cache
            return Backbone.sync.apply(that, arguments)

        url = if _.isFunction(collection.url) then collection.url() else collection.url
        cache_data = JSON.parse(localStorage.getItem(url))
        cache_meta = JSON.parse(localStorage.getItem(collection.cache))
        that = this

        if collection.cache
            if cache_data
                $.get collection.cache, (data) ->
                    if _.isEqual(data, cache_meta)
                        options.success.call(that, cache_data, "success", $.Deferred().resolve())
                        return $.Deferred().resolve()
                    else
                        localStorage.setItem collection.cache, JSON.stringify(data)
                        jqXHR = Backbone.sync.apply(that, arguments);
                        jqXHR.then (data) ->
                            localStorage.setItem url, JSON.stringify(data)
                        return jqXHR
            else
                $.get collection.cache, (data) ->
                    localStorage.setItem collection.cache, JSON.stringify(data)
                jqXHR = Backbone.sync.apply(that, arguments);
                jqXHR.then (data) ->
                    localStorage.setItem url, JSON.stringify(data)
                return jqXHR
)(this)