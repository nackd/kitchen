class Role < ChefBase
  allowed_attributes :name, :chef_type, :json_class, :default_attributes, :description, :run_list, :override_attributes

  def initialize(attributes={})
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
    @node_list || nodes.collect(&:name)
  end

  def node_list=(new_node_list)
    old_nodes = nodes.collect &:name

    add_role = (new_node_list - old_nodes).collect { |name| Node.find(name) }
    del_role = (old_nodes - new_node_list).collect { |name|
      nodes.find { |node| node.name == name }
    }

    add_role.each { |node| node.add_to_role_and_save(self) }
    del_role.each { |node| node.del_from_role_and_save(self) }
  end

  def nodes(use_cache=true)
    return @nodes if @nodes and use_cache
    return [] if @name.blank?
    @nodes = Node.search("role:#{@name}")
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

  def self.name_of_role(role)
    name = case role
           when Role
             role.name
           else
             role
           end
    "role[#{name}]"
  end

  def self.delete(name)
    super
    Node.search("role:#{name}").each { |node| node.del_from_role_and_save(name) }
  end
end
