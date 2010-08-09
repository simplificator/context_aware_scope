module ContextAwareScope
  def self.included(base)
     base.class_eval do
       extend ClassMethods
       class_eval do
         def initialize_with_context(proxy_scope, options, &block)
           @context = options[:context]
           initialize_without_context(proxy_scope, options, &block)
         end

         alias_method_chain :initialize, :context

         # get current context from scope chain
         def context
           if @proxy_scope.class == ActiveRecord::NamedScope::Scope
             @proxy_scope.context.deep_merge(@context)
           else
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
