class Role < ChefBase
  def initialize(attributes={})
    attributes.reject! { |key, value|
      ["chef_type", "chef_name"].include? key.to_s
    }
    attributes = {
      "name"                => nil,
      "chef_type"           => "role",
      "json_class"          => "Chef::Role",
      "default_attributes"  => {},
      "description"         => nil,
      "run_list"            => [],
      "override_attributes" => {}
    }.merge(attributes)
    super(attributes)
  end

  def nodes_list
    [] # TODO
  end

  def nodes
    [] # TODO
  end

  def available_roles
    [] # TODO
  end

  def available_recipes
    [] # TODO
  end

  def extended_run_list
    [] # TODO
  end
end
