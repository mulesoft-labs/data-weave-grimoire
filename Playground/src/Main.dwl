%dw 2.0

input payload application/json

@ResourceDependency(url = "https://github.com/mulesoft-labs/data-weave-playground-ui/releases/download/v0.1/api-0.1-SNAPSHOT-api.zip", unzip=true)
// @ResourceDependency(url = "file:///Users/mdeachaval/labs/mulesoft-labs/data-weave-playground-ui/frontend/dist/dw-playground-0.2.zip", unzip=true)
@ResourceDependency(url = "https://github.com/mulesoft-labs/data-weave-playground-ui/releases/download/v0.2/dw-playground-0.2.zip", unzip=true)
import * from dw::deps::Deps
import * from dw::core::Objects
import CORS from dw::io::http::Interceptors
import * from dw::io::http::Server
import raml!playground::api::dwplayground as PlaygroundAPI
import run, ReaderInput,RunSuccess,ExecutionFailure from dw::Runtime
import dw::core::Binaries

var serverConfig: {host: String, port: Number} = { host: "localhost", port: 8082 }

fun runTransform(transformRequest: PlaygroundAPI::TransformRequest): PlaygroundAPI::TransformResponse = do {
    var inputs: Dictionary<ReaderInput> = {
                    (
                        transformRequest.inputs mapObject {
                            ($$) : $ update {
                               case .value -> Binaries::fromBase64($)                               
                            }
                        }
                    )
                 }
                 

    ---
    run(transformRequest.main,transformRequest.fs, inputs)  match {
    		case is RunSuccess -> {
    		   success: true,
    		   result: {
    		        value: $.value as String {encoding: $.encoding default "UTF-8"},
    		        mimeType: $.mimeType,
    		        encoding: $.encoding default "UTF-8",
    		        logs: $.logs
    		   }
    		}
    		case is ExecutionFailure -> {
    		    success: false,
    		    error: {
    		        message: $.message,
    		        location: $.location,
    		        logs: $.logs
    		    }
    		}
    }
}

---
PlaygroundAPI::server(
  serverConfig mergeWith {interceptors: [CORS()]}, {
    "/transform": {
        POST: (request) -> {
            body: runTransform(request.body)
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
