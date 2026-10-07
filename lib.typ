#let _plugin = plugin("rusterd.wasm")

#let _source-text(source) = if type(source) == str {
  source
} else {
  source.text
}

#let _bool-text(value) = if value { "true" } else { "false" }

#let erd(
  source,
  focus: none,
  view: none,
  detail: "all",
  notation: "crowsfoot",
  legend: false,
  dense: false,
  aspect: "1:1",
  image-options: (:),
) = {
  let selected-focus = if focus != none {
    focus
  } else if view == none {
    ""
  } else {
    view
  }
  if image-options.keys().contains("format") {
    panic("image-options cannot override format; rusterd always renders SVG")
  }

  image(
    _plugin.render(
      bytes(_source-text(source)),
      bytes(selected-focus),
      bytes(detail),
      bytes(notation),
      bytes(_bool-text(legend)),
      bytes(_bool-text(dense)),
      bytes(aspect),
    ),
    format: "svg",
    ..image-options,
  )
}
