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

  def node_list
    @node_list || []
  end

  def nodes
    Node.search("run_list:role\\[#{self.name}\\]")
  end

  def available_roles
    @available_roles || []
  end

  def available_recipes
    @available_recipes || []
  end

  def extended_run_list
    @extended_run_list || []
  end
end
