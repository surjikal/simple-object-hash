simple-object-hash.coffee
=========================

Hash your objects. Check for deep equality. Or whatever!

```coffee
objectHash = require 'simple-object-hash'

objectHash {foo:'1', bar:'2'}
# f34bb66026d79c27b0b8318590ce39f8

objectHash {bar:'2', foo:'1'}
# f34bb66026d79c27b0b8318590ce39f8
```
