if defined?(ChefSpec)
  def run_apqc_php_php_ini(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:apqc_php_php_ini, :create, resource_name)
  end

  def run_apqc_php_pecl_extension(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:apqc_php_pecl_extension, :create, resource_name)
  end
end
