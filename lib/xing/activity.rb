module Xing
  class Activity < Xing::Base
    lazy_attr_reader :id, :link, :link_desc, :image, :title, :text, :object, :type, :url

    # @return String
    def link
      @link ||= @attrs["permalink"] unless @attrs["permalink"].nil?
    end

    # @return String
    def link_desc
      @name ||= @attrs["name"].nil? ? @attrs["display_name"] : @attrs["name"]
    end

    def object
      name = @attrs["type"].camelize
      if Xing.const_defined?(name)
        @object ||= Xing.const_get(name).new(@attrs)
      end
    end

    # @return String
    def text
      @text ||= case @attrs["type"]
                  when "status" then @attrs["content"]
                  when "bookmark" then @attrs["description"]
                  else nil
                end
    end

  end
end

class String
  def camelize
    self.split(/[^a-z0-9]/i).map{|w| w.capitalize}.join
  end
end