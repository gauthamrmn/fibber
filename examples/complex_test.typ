#import "../src/exports.typ": *

#let materials = (
  "aSi": gray,
  "Al2O3": rgb("b0bccc"),
  "Metal": yellow,
  "SiO2": rgb("#742ca8"),
  "LN": rgb("#08b4f4"),
)

#let device = device-steps(
  materials: materials,
  display-steps: (3,4,5,8,9,10),
  steps: (
    deposit(
      material: "Al2O3",
      height: 2.5,
    ),
    deposit(
      material: "aSi",
    ),
    deposit(
      material: "Metal",
    ),
    deposit(
      material: "LN",
      pattern: ((left, middle, right)) => ((left, right - 2),)
    ),
    etch(
      height: 2,
      pattern: ((left, middle, right)) => ((left, left + 2),),
    ),
    deposit(
      material: "SiO2",
      start-layer: 3.5,
      pattern: ((left, middle, right)) => ((left, left + 2),),
      height: 2,
    ),
    deposit(
      material: "Metal",
      pattern: ((left, middle, right)) => ((left, left + 1.5),),
      height: 2,
    ),
    deposit(
      material: "Metal",
      start-layer: 5.5,
      pattern: ((left, middle, right)) => (
        (middle - 1.75, middle - 1),
        (middle - 0.75, middle - 0.25),
        (middle + 0.25, middle + 0.75),
        (middle + 1, middle + 1.75),
      ),
    ),
    deposit(
      material: "Metal",
      start-layer: 4.5,
      height: 3,
      pattern: ((left, middle, right)) => ((right - 2, right),),
    ),
    etch(
      start-layer: 4.5,
      height: 2,
      pattern: ((left, middle, right)) => ((middle - 0.25, middle + 0.25),),
    ),
    etch(
      start-layer: 2.5,
      pattern: ((left, middle, right)) => ((left + 1.5, right - 1.5,),
    )
  )
  )
)

#let step-desc = (
  [1. Electrode Exposure],
  [2. Active Area Etch],
  [3. SiO2 Backfill],
  [4. 3x Metal Deposition],
  [5. Release Window Etch],
  [6. XeF2 Release],
)
#grid(
  columns: (1fr,1fr,1fr),
  column-gutter: 5%,
  row-gutter: 5%,
  ..device.zip(step-desc).map(
    pair => [
      #block()[
        #pair.at(0)
        #pair.at(1)
      ]
    ]
  )
)
