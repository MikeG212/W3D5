class AttrAccessorObject
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method(name) do
        instance_variable_get("@#{name}")
      end

      define_method("#{name}=") do |val|
        instance_variable_set("@#{name}", val)
      end
    end
  end
end

#create getter and setter methods
#use the splat operator to take in an array of instance variables
#iterate through the argument array

#getter: create a method named after the instance variable (no @)
#use instance variable get to get the value of the instance variable

#setter: use interpolation to create a method name after instance variable (no @)
#with equal sign
#pipes to take in the value you are setting it to
#use instance variable set to set the instance variable to val
