import gleam/list
import gleam/string
import simplifile

pub fn read_input(
  file: String,
  separator: String,
  parse: fn(String) -> List(a),
) -> List(a) {
  let assert Ok(input) = simplifile.read(from: file)
  string.split(input, separator)
  |> list.filter(fn(item) { item != "" })
  |> list.flat_map(parse)
}
