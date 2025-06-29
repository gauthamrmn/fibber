#import "deps.typ": cetz
#import cetz: draw, vector


#let deposit(layer-height, layer, width, height, position, color) = {
  draw.rect(
    (position, layer*layer-height),
    (position+width, (layer+height)*layer-height+0.01),
    fill: color,
    stroke: none
  )
}

#let etch(layer-height, bottom, top, width, position, color) = {
    draw.rect(
      (position, bottom*layer-height),
      (position + width, (top+1)*layer-height+0.02),
      fill: color,
      stroke: none
    )
}
   

#let device(width: 8, layer-height: 1, background-color: white, materials: (), steps: ()) = {
  let device-anchors = ( (left: 0, middle: width/2, right: width) )
  cetz.canvas({
    let layer = 0
    for s in steps {
      if "height" not in s {
        s.insert("height", 1)
      }
      if s.process == "deposit" {
        if "start-layer" not in s {
          s.insert("start-layer", layer)
        }
        if "pattern" not in s {
          s.insert("pattern", ((left, middle, right)) => ((left, right),))
        }
        for p in (s.pattern)(device-anchors) {
          deposit(layer-height, s.start-layer, p.at(1)-p.at(0), s.height, p.at(0), materials.at(s.material))
        }
        layer += s.height
      } else if s.process == "etch" {
          if "start-layer" not in s {
            s.insert("start-layer", layer)
          }
          if "pattern" not in s {
            s.insert("pattern", ((left, middle, right)) => ((left, right),))
          }
          for p in (s.pattern)( device-anchors ) {
            etch(layer-height, s.start-layer - s.height, s.start-layer, p.at(1)-p.at(0), p.at(0), background-color) 
          }
      } else {
        panic("Invalid process argument")
      }
    }
  })
}

