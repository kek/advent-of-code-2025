import gleam/int
import gleam/list

pub fn compute(input) -> Int {
  let #(_, positions) =
    list.map_fold(from: 50, over: input, with: fn(position, rotation) {
      let assert Ok(newpos) = turn(position, rotation)
      #(newpos, newpos)
    })
  list.count(positions, fn(i) { i == 0 })
}

pub fn turn(start: Int, rotation: String) -> Result(Int, String) {
  case rotation {
    "L" <> s -> {
      let assert Ok(i) = int.parse(s)
      Ok(spin(start - i))
    }
    "R" <> s -> {
      let assert Ok(i) = int.parse(s)
      Ok(spin(start + i))
    }
    _ -> Error("Invalid rotation")
  }
}

fn spin(i: Int) -> Int {
  let j = case i {
    i if i >= 100 -> i - 100
    i if i < 0 -> 100 + i
    i -> i
  }
  case j {
    j if j == i -> i
    j -> spin(j)
  }
}
