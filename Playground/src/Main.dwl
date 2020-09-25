%dw 2.0

import * from dw::deps::Deps
@ResourceDependency(url = "file:///Users/mdeachaval/labs/mulesoft/data-weave-playground/frontend/dist/dw-playground-2.0.0.zip", unzip=true)
import * from dw::io::http::Server


var serverConfig = { host: "localhost", port: 8082 }
var LOCALHOST = '$(serverConfig.host):$(serverConfig.port)'

---
api(
  serverConfig, {
    "/transform": {
      GET: (request) -> {
        body: {
          name: "Mariano"
        }
      },
      POST: (request) -> {
        body: {
          // TODO: Remove as String
          name: (request).body.name as String
        },
        status: 302
      }
    },
      //TODO: need uri params to extract parts of the path
    "/": {
        GET: ((request) -> resourceResponse("index.html"))
    },
    "/.+": {
        GET: ((request) -> resourceResponse(request.path))
    }
  }
)
