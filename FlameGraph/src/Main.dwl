
input payload application/x-ndjson


import process, mergeNode from Flamegraph

import * from dw::core::Objects
import CORS from dw::io::http::Interceptors
import * from dw::io::http::Server
import fail from dw::Runtime

import run, ReaderInput,RunSuccess,ExecutionFailure from dw::Runtime
import dw::core::Binaries

var serverConfig: {host: String, port: Number} = { host: "localhost", port: 8082 }


var flameGraph = process(payload)
fun filterDepth(value: Any, maxDepth: Number, currentDepth: Number = 0) = do {
  value update {
    case children at .children -> 
      if(maxDepth > currentDepth)
        children map ((item) -> filterDepth(item, maxDepth, currentDepth + 1))
      else
        []
  }
}

---
 api(
  serverConfig mergeWith {interceptors: [CORS()]}, 
  {
    "/data.json": {
        GET: (request) -> {
              body: filterDepth(mergeNode(flameGraph), 200)
            }
      },
    "/": {
        GET: ((request) -> resourceResponse("index.html"))
      },
    "/.+": {
        GET: ((request) -> resourceResponse(request.path))
      }
  }
)