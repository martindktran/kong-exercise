local cjson = require "cjson"

local _M = {}

function _M.execute(plugin_conf)
    
    country = ""
    region = ""
    cluster=""

    country = kong.request.get_header('X-Country')
    region = kong.request.get_header('X-Region')

    rules = cjson.decode(plugin_conf.rules)
  
    for _, rule in pairs(rules) do
      if country == rule["XCountry"] and region == rule["XRegion"] then
        cluster = rule["Cluster"]
      end
    end
  
    if cluster ~= "" then
      local ok, err = kong.service.set_upstream(cluster)
      if not ok then
        ngx.log(ngx.ERR, "ERR: " ..err)
        return
      end
    else
      local ok, err = kong.service.set_upstream("europe_cluster")
      if not ok then
        ngx.log(ngx.ERR, "ERR: " ..err)
        return
      end
    end
end

return _M