%dw 2.0
import * from Flamegraph

input payload application/x-ndjson

fun toCollapsedStack(value: Node, parent: String = ""): Array<String> = do {
  if(isEmpty(value.children))
    [(parent ++ ";" ++ value.name ++ " " ++ (value.value as String))]
  else
    value.children flatMap ((item, index) -> toCollapsedStack(item, parent ++ ";" ++ value.name))
}


output application/csv header=false
var result = mergeNode(process(payload))

---
toCollapsedStack(result.children[0], result.name)
  map (t) -> {stack: t}