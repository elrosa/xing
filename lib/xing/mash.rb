require 'hashie'
require 'multi_json'

module Xing
  class Mash < ::Hashie::Mash

    def self.from_json(json_string)
      result_hash = MultiJson.load(json_string)
      new(result_hash)
    end

  end
end
