import gleam/int
import gleam/list
import gleam/string

pub fn invalid_ids(value: #(Int, Int)) -> List(Int) {
  case value {
    #(start, end) -> {
      list.range(start, end)
      |> list.flat_map(fn(i) {
        case invalid(i) {
          True -> [i]
          False -> []
        }
      })
    }
  }
}

fn invalid(i: Int) -> Bool {
  let #(first, second) = split_number(i)
  first == second
}

pub fn split_number(i: Int) -> #(String, String) {
  let digits = int.to_string(i)
  let len = string.length(digits)
  let half = len / 2
  let first = string.slice(digits, 0, half)
  let second = string.slice(digits, half, half + 1)
  #(first, second)
}
