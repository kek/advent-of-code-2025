import gleam/int
import gleam/list
import gleam/result

pub fn compute(input: List(Turn)) -> Int {
  let #(_, positions) =
    list.map_fold(from: 50, over: input, with: fn(position, rotation) {
      let newpos = turn(position, rotation)
      #(newpos, newpos)
    })
  list.count(positions, fn(i) { i == 0 })
}

pub fn turn(start: Int, rotation: Turn) -> Int {
  case rotation {
    Left(i) -> spin(start - i)
    Right(i) -> spin(start + i)
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

pub type Turn {
  Left(Int)
  Right(Int)
}

pub fn parse(rotation: String) -> List(Turn) {
  let turn = case rotation {
    "L" <> s -> {
      let assert Ok(i) = int.parse(s)
      Ok(Left(i))
    }
    "R" <> s -> {
      let assert Ok(i) = int.parse(s)
      Ok(Right(i))
    }
    _ -> panic as "Invalid turn pattern"
  }
  result.values([turn])
}

pub fn split_turns(turns: List(Turn)) -> List(Turn) {
  turns
  |> list.flat_map(fn(turn) {
    case turn {
      Left(i) -> list.repeat(Left(1), i)
      Right(i) -> list.repeat(Right(1), i)
    }
  })
}
