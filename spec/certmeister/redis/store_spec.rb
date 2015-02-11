require 'spec_helper'
require 'certmeister/test/memory_store_interface'

require 'redis'
require 'certmeister/redis/store'

describe Certmeister::Redis::Store do

  class << self
    include Certmeister::Test::MemoryStoreInterface
  end

  let(:redis) { Redis.new }
  subject { Certmeister::Redis::Store.new(redis, "test") }

  it_behaves_like_a_certmeister_store

  private

  def redis_cleanup
    redis.keys(subject.send(:pem_key, "*")).each do |key|
      redis.del(key)
    end
    leftovers = redis.keys("*")
    if !leftovers.empty?
      fail "redis keys not cleaned up: #{leftovers.inspect}"
    end
  end

  before(:each) do
    redis_cleanup
  end

  after(:each) do
    redis_cleanup
  end

end

