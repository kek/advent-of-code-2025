import day1
import gleam/list
import gleam/string
import gleeunit
import simplifile

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn turn_test() {
  assert day1.turn(50, day1.Left(68)) == 82
  assert day1.turn(82, day1.Left(30)) == 52
  assert day1.turn(52, day1.Right(48)) == 0
  assert day1.turn(0, day1.Left(5)) == 95
  assert day1.turn(95, day1.Right(60)) == 55
  assert day1.turn(55, day1.Left(55)) == 0
  assert day1.turn(0, day1.Left(1)) == 99
  assert day1.turn(99, day1.Left(99)) == 0
  assert day1.turn(0, day1.Right(14)) == 14
  assert day1.turn(14, day1.Left(82)) == 32
}

pub fn split_turns_test() {
  assert day1.split_turns([day1.Left(1)]) == [day1.Left(1)]
  assert day1.split_turns([day1.Left(2)]) == [day1.Left(1), day1.Left(1)]
}

// gleeunit test functions end in `_test`
pub fn day1_example_test() {
  let lines = [
    "L68",
    "L30",
    "R48",
    "L5",
    "R60",
    "L55",
    "L1",
    "L99",
    "R14",
    "L82",
  ]

  let turns = list.flat_map(lines, day1.parse)
  let result = day1.compute(turns)
  assert result == 3
}

pub fn day1_test() {
  let assert Ok(input) = simplifile.read(from: "input/1.txt")
  let lines = string.split(input, "\n") |> list.filter(fn(item) { item != "" })
  let turns = list.flat_map(lines, day1.parse)
  assert day1.compute(turns) == 1078
}

pub fn day1b_test() {
  let assert Ok(input) = simplifile.read(from: "input/1.txt")
  let lines = string.split(input, "\n") |> list.filter(fn(item) { item != "" })
  let turns = list.flat_map(lines, day1.parse)
  let split_turns = day1.split_turns(turns)
  assert day1.compute(split_turns) == 6412
}
