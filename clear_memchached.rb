require 'rubygems'
require 'memcache'
CACHE = MemCache.new('127.0.0.1')
CACHE.flush_all