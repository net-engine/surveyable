module Surveyable
  module SurveysHelper
    def link_to_remove_fields(name, form)
      form.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", class: 'remove_link')
    end

    def link_to_add_fields(name, form, association)
      new_object = form.object.class.reflect_on_association(association).klass.new

      3.times { new_object.answers.build } if new_object.class.to_s == 'Surveyable::Question'

      fields = form.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", form: builder)
      end

      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn-add')
    end
  end
end
