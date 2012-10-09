#Backbone.cachedsync

A small plugin that makes Backbone.Collection cacheable via external resource with hash or any identificator that set has been changed.

Just drop backbone.cachedsync.js into your project and add a property called "cache" to your collection. This property should contain an url, which will return a haso of model's ids or its total count or timestamp of last change or something else you could imagine, that identifies that there is new data.

##Example

    Hotels = xo.Collection.extend({
        url: 'hotels/',
        model: Hotel,
        cache: 'hotel_hash/', //this resourse returns an MD5() of concated hotel's ids
    });

Works in all major browsers from IE8.