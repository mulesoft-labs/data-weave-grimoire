%dw 2.0
import fail from dw::Runtime

type Node = {
  name: String,
  id: String,
  value: Number,
  children: Array<Node>
}

type OpenNode = {
  name: String,
  id: String,
  kind: String, 
  parent: OpenNode | Null,
  timeStamp: Number | Null,
  children: Array<Node>
}

type Event = "DW.PRE_EXECUTION"
| "DW.POST_EXECUTION"
| "DW.START_WRITING"
| "DW.END_WRITING"
| "DW.START_READING" 
| "DW.END_READING"

type RawData = {
  kind: Event,
  threadId: String,
  id: String,
  timeStamp: Number,
  location: String,
  data: {
      node?: String,
      sPos?: String,
      ePos?: String,
      name?: String,
      'type'?: String,
      'variable'?: String,
      kind?: String,
    }
}

fun process(data: Array<RawData>): Node =                                    
  produce(data, {name: "root", parent: null, timeStamp: null, children: [], id: "root", kind: "root"})

fun closeAll(@DesignOnlyType() acc: OpenNode): Node = do{
    var p = acc.parent    
    ---
    if(p != null) 
      closeAll(
        p update {
          case children at .children! -> 
            children << {
              name: acc.name,                                    
              value: sum(acc.children map $.value),
              children: acc.children,                     
              id: acc.id,
            }           
        })
    else
      {
        name: acc.name,                                    
        value: sum(acc.children map $.value),
        children: acc.children,                     
        id: acc.id,
      }
  }

fun closeUnitl(@DesignOnlyType() acc: OpenNode, depth: Number): OpenNode = do {
    var p = acc.parent    
    ---
    if(depth == 0)
      acc
    else if(p != null) 
      closeUnitl(
        p update {
          case children at .children! -> 
            children << {
              name: acc.name,                                    
              value: sum(acc.children map $.value),
              id: acc.id,                     
              children: acc.children
            }           
        }, depth - 1)
    else
      fail("No more parents")
  }  

fun findParentWith(@DesignOnlyType() acc: OpenNode, id: String, withMax: Number, currentLevel: Number = 0): Number = do {
    if(withMax < currentLevel)
      -1
    else if(acc.id == id)
      currentLevel
    else if(acc.parent != null)
      findParentWith(acc.parent, id, withMax, currentLevel + 1)  
    else 
      -1  
  }

fun produce(data: Array<RawData>, @DesignOnlyType() acc: OpenNode): Node =                                    
  data match {
    case [] ->  do {
        closeAll(acc)
      }
    case [ x ~ xs ] -> do {
        x.kind match {
          case is "DW.PRE_EXECUTION" | "DW.START_READING"   -> do {
              var newNode = {
                  name:                       
                    if(x.kind == "DW.PRE_EXECUTION") 
                      " `" ++ (x.data.name default "") ++ "` @ " ++ x.location 
                    else if(x.kind == "DW.START_WRITING")
                      "Writing $(x.data.`type`!) $(x.data.kind!) "
                    else 
                      "Reading $(x.data.`variable`!) $(x.data.kind!)",                       
                  kind: x.kind,        
                  id: x.id,                                       
                  parent: acc,
                  timeStamp: x.timeStamp,                                   
                  children: []
                }
          // var c = log(">" ++ newNode.name ++ " " ++ x.id)   
              ---
              produce(xs, newNode)
            }
          case is "DW.POST_EXECUTION" | "DW.END_READING"  -> 
            if(acc.id == x.id) do {
              // var c = log("<" ++ acc.name ++ " " ++ x.id)                          
                var p = acc.parent
                var n =                                    
                  if(p != null)               
                    p update {
                      case children at .children! -> 
                        children << {
                          name: acc.name,                        
                          id: acc.id,               
                          value:                          
                            if (acc.timeStamp is Number) 
                              x.timeStamp - acc.timeStamp
                            else 
                              fail("It should have a timestamp"),                     
                          children: acc.children
                        }
                    }                                     
                  else
                    fail("It should have a parent")                    
                ---
                produce(xs, n)
              }
            else do {                                          
              var parent = findParentWith(acc, x.id, 20)
              ---
              if(parent == -1) do{   
                  var c = log("Ignoring `$(x.kind)` expected: $(acc.id), actual: $(x.id)")
                  ---           
                  produce(xs, acc)
                } else do{ 
                var c = log("AutoClosing nodes: $(parent) because of -> $(acc.kind) $(acc.id) ")
                ---                
                produce(xs, closeUnitl(acc, parent))
              }

            }        
          else -> produce(xs, acc)                        
        }
      }
  }



fun mergeNode(@DesignOnlyType() node:  Node) = do {
    {
      name: node.name,     
      id: node.id,
      value: node.value,     
      children:   
        valuesOf(node.children
            groupBy ((item, index) -> item.id))
          map ((item, index) -> mergeNode(mergeNodes(item)))
    }
  }

fun mergeNodes(nodes: Array<Node>): Node = do {
    nodes
      reduce ((item, accumulator) -> do {                     
            {
                name: accumulator.name,     
                id: accumulator.id,
                count: accumulator.count default 1 + 1,
                value: accumulator.value + item.value,     
                children: accumulator.children ++ item.children
              }
          }) 


  }  
