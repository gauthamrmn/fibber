#import "layers.typ": generate-legend

#let format-legend-pairs(materials, format-text: (it) => text(it)) = {
  let legend-pairs = generate-legend(materials).pairs()
  let formatted-pairs = ()
  for p in legend-pairs {
    p.at(0) = format-text(p.at(0))
    formatted-pairs.push(
      grid(
        columns: (1fr, 1fr),
        column-gutter: 10%,
        align: horizon,
        ..p.rev()
      )
    )
  }
  formatted-pairs
}

#let format-legend(columns: 1, column-gutter: 10%, row-gutter: 2.5%, materials: (:), format-text: (it) => text(it)) = {
  grid(
    columns: columns,
    column-gutter: column-gutter, 
    row-gutter: row-gutter,
    ..format-legend-pairs(materials, format-text: format-text)
  )
}

#let step-diagram(device-steps: (), step-desc: (), legend: [], columns: 1, column-gutter: 5%, row-gutter: 5%) = {
  grid(
    columns: columns,
    column-gutter: column-gutter,
    row-gutter: row-gutter,
    ..device-steps.zip(step-desc).map(
      pair => [
        #block()[
          #pair.at(0)
          #pair.at(1)
        ]
      ]
    ),
    legend
  )
}
