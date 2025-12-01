import gleam/int
import gleam/io
import gleam/list

pub fn compute(input) -> Int {
  let #(_, positions) =
    list.map_fold(from: 50, over: input, with: fn(position, rotation) {
      let newpos = case turn(position, rotation) {
        Ok(i) -> i
        Error(s) -> {
          io.print(s)
          -1
        }
      }
      #(newpos, newpos)
    })
  list.count(positions, fn(i) { i == 0 })
}

pub fn turn(start: Int, rotation: String) -> Result(Int, String) {
  case rotation {
    "L" <> s -> {
      case int.parse(s) {
        Ok(i) -> Ok(spin(start - i))
        Error(Nil) -> Error("Failed to parse rotation number")
      }
    }
    "R" <> s -> {
      case int.parse(s) {
        Ok(i) -> Ok(spin(start + i))
        Error(Nil) -> Error("Failed to parse rotation number")
      }
    }
    _ -> Error("Invalid rotation")
  }
}

fn spin(i: Int) -> Int {
  case i {
    i if i >= 100 -> i - 100
    i if i < 0 -> 100 + i
    i -> i
  }
}
