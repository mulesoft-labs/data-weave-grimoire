%dw 2.0
import * from Flamegraph

input payload application/x-ndjson

fun filterDepth(value: Any, maxDepth: Number, currentDepth: Number = 0) = do {
  value update {
    case children at .children -> 
      if(maxDepth > currentDepth)
        children map ((item) -> filterDepth(item, maxDepth, currentDepth + 1))
      else
        []
  }
}

output application/json 
---
mergeNode(process(payload))