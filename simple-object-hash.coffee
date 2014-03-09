crypto = require 'crypto'


isObject = (x) ->
    Boolean(x) and (x.constructor is Object)


flattenObject = (object, {separator, maxDepth} = {}, result = {}, prefix = '', depth = 0) ->
    maxDepth   = Number.POSITIVE_INFINITY if not (typeof maxDepth is 'number')
    separator ?= ''

    return object if object is null

    Object.keys(object).forEach (key) ->
        invalid = key.indexOf(separator) isnt -1
        throw new Error("Key `#{key}` contains separator `#{separator}`") if invalid

    for key, value of object
        if isObject(value) and depth < maxDepth
            flattenObject(value, {separator, maxDepth}, result, "#{prefix}#{key}#{separator}", depth+1)
        else
            result["#{prefix}#{key}"] = value

    return result


defaultHashFn = (x) ->
    crypto
    .createHash('md5')
    .update(x)
    .digest("hex")


module.exports = (object, hashFn = defaultHashFn) ->
    throw new Error("`object` argument is required.")            if not object
    throw new Error("`object` argument must be of type Object.") if not isObject(object)
    object = flattenObject(object)
    object = Object.keys(object).sort().reduce ((result, key) ->
        result.concat [[key, object[key]]]
    ), []
    return hashFn(JSON.stringify(object))
