module Certmeister

  module Redis

    class Store

      include Enumerable

      def initialize(redis, environment = "development")
        @redis = redis
        @environment = environment
        @healthy = true
      end

      def store(cn, pem)
        @redis.set(pem_key(cn), pem)
      end

      def fetch(cn)
        @redis.get(pem_key(cn))
      end

      def remove(cn)
        num_removed = @redis.del(pem_key(cn))
        num_removed == 1
      end

      def each
        @redis.scan_each do |key|
          cn = cn_from_pem_key(key)
          yield cn, fetch(cn)
        end
      end

      def health_check
        @healthy
      end
      
      private

      def pem_key(cn)
        "certmeister:#{@environment}:certificate:#{cn}"
      end

      def cn_from_pem_key(key)
        key.split(':')[3]
      end

      def break!
        @healthy = false
      end
      
    end

  end

end
