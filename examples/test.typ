#import "../src/exports.typ": *


#let Si = luma(120)
#let LN = olive
#let Pt = gray
#let Au = yellow

#let electrode-pattern = ((left, middle, right)) => (
  (left + 0.5, left + 1.25),
  (left + 1.75, middle - 0.75),
  (middle - 0.5, middle + 0.5),
  (middle + 0.75, right - 1.75),
  (right - 1.25, right - 0.5),
)

#let release-hole-etch-pattern = ((left, middle, right)) => (
  (left + 1.25, left + 1.75),
  (right - 1.75, right - 1.25),
)


#let func(param1: none, param2: none) = {
  draw.rect((0,0),(1,1))
}

#func(param1: "Hello").fields()

#device(
  materials: (
    Si: Si,
    LN: LN,
    Pt: Pt,
    Au: Au,
  ),
  steps: (
    (
      process: "deposit",
      material: "Si",
    ),
    (
      process: "deposit",
      material: "LN",
    ),
    (
      process: "etch",
      height: 1.05,
      pattern: release-hole-etch-pattern
    ),
    (
      process: "deposit",
      height: 0.5,
      material: "Pt",
      pattern: electrode-pattern
    ), 
    (
      process: "deposit",
      height: 0.5,
      material: "Au",
      pattern: electrode-pattern
    ),
    (
      process: "etch",
      start-layer: 0,
      height: 1,
      pattern: ((left, middle, right)) => ((left + 0.5, right - 0.5),)
    ),
  ),
)
