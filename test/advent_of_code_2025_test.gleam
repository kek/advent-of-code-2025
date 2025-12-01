import day1
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn day1_example_test() {
  let input = [
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

  let result = day1.compute(input)
  assert result == 3
}

pub fn turn_test() {
  assert day1.turn(50, "L68") == Ok(82)
  assert day1.turn(82, "L30") == Ok(52)
  assert day1.turn(52, "R48") == Ok(0)
  assert day1.turn(0, "L5") == Ok(95)
  assert day1.turn(95, "R60") == Ok(55)
  assert day1.turn(55, "L55") == Ok(0)
  assert day1.turn(0, "L1") == Ok(99)
  assert day1.turn(99, "L99") == Ok(0)
  assert day1.turn(0, "R14") == Ok(14)
  assert day1.turn(14, "L82") == Ok(32)
}
