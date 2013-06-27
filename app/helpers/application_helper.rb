module ApplicationHelper

  # class BraintreeFormBuilder < ActionView::Helpers::FormBuilder
  #   include ActionView::Helpers::AssetTagHelper
  #   include ActionView::Helpers::TagHelper

  #   def initialize(object_name, object, template, options, proc)
  #     super
  #     @braintree_params = @options[:params]
  #     @braintree_errors = @options[:errors]
  #   end

  #   def fields_for(record_name, *args, &block)
  #     options = args.extract_options!
  #     options[:builder] = BraintreeFormBuilder
  #     options[:params] = @braintree_params && @braintree_params[record_name]
  #     options[:errors] = @braintree_errors && @braintree_errors.for(record_name)
  #     new_args = args + [options]
  #     super record_name, *new_args, &block
  #   end

  #   def text_field(method, options = {})
  #     has_errors = @braintree_errors && @braintree_errors.on(method).any?
  #     field = super(method, options.merge(:value => determine_value(method)))
  #     result = content_tag("div", field, :class => has_errors ? "fieldWithErrors" : "")
  #     result.safe_concat validation_errors(method)
  #     result
  #   end

  #   protected

  #   def determine_value(method)
  #     if @braintree_params
  #       @braintree_params[method]
  #     else
  #       nil
  #     end
  #   end

  #   def validation_errors(method)
  #     if @braintree_errors && @braintree_errors.on(method).any?
  #       @braintree_errors.on(method).map do |error|
  #         content_tag("div", ERB::Util.h(error.message), {:style => "color: red;"})
  #       end.join
  #     else
  #       ""
  #     end
  #   end
  # end

  def email_anchor(title, url)
    email_link(title, url, "color: #FF2B06;")
  end

  def email_button(title, url)
    email_link(title, url, "display: inline-block; padding: .25em .75em; margin: -.25em 0; font-weight: bold; text-decoration: none; color: white; background: #FF2B06; border-radius: 4px;")
  end

  private
  
  def email_link(title, url, style)
    link_to title, url, title: title, style: style
  end
end
