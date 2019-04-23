return {
  no_consumer = false, -- this plugin is available on APIs as well as on Consumers,
  fields = {
    rules = {
      type = "string"
    } 
  },
  self_check = function(schema, plugin_t, dao, is_updating)
    -- perform any custom verification
    return true
  end
}
