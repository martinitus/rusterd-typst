#let _plugin = plugin("rusterd.wasm")

#let _source-text(source) = if type(source) == str {
  source
} else {
  source.text
}

#let erd(
  source,
  focus: none,
  view: none,
  detail: "all",
  notation: "crowsfoot",
  width: auto,
) = {
  let selected-focus = if focus != none {
    focus
  } else if view == none {
    ""
  } else {
    view
  }
  image(
    _plugin.render(
      bytes(_source-text(source)),
      bytes(selected-focus),
      bytes(detail),
      bytes(notation),
    ),
    format: "svg",
    width: width,
  )
}
