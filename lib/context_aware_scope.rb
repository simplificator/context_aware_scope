module ContextAwareScope
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      class_eval do
        def initialize_with_context(proxy_scope, options, &block)
          @context = options ? options[:context] || {} : {}
          initialize_without_context(proxy_scope, options, &block)
        end

        alias_method_chain :initialize, :context

        # get current context from scope chain
        def context
          p @proxy_scope.class
          if @proxy_scope.class == ActiveRecord::NamedScope::Scope
            p @context
            recursive_context = @proxy_scope.context
            recursive_context = recursive_context.keep_merge(@context)
            recursive_context
          else
            p @context
            @context
          end
        end

        # exclude context from proxy options
        # that way it is not sent to the with_scope on the ActiveRecord model
        def proxy_options
          @proxy_options.except(:context)
        end
      end
    end
  end

  module ClassMethods

  end
end

class ActiveRecord::NamedScope::Scope
  include ContextAwareScope
end

class Hash
  def keep_merge(hash)
    target = dup
    hash.keys.each do |key|
      if hash[key].is_a? Hash and self[key].is_a? Hash
        target[key] = target[key].keep_merge(hash[key])
        next
      end
      #target[key] = hash[key]
      target.update(hash) { |key, *values| values.flatten.uniq }
    end
    target
  end
end
