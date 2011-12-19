class Role < ChefBase
  def initialize(attributes={})
    attributes = { "name" => nil,
                   "nodes_list" => [] }.merge(attributes)
    super(attributes)
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
