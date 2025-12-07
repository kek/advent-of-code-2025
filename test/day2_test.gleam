import day2
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleeunit
import helper

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn solution_test() {
  let ranges = helper.read_input("input/2.txt", ",", parse)
  assert invalid_id_sum(ranges) == 32_976_912_643
}

pub fn invalid_id_sum(ranges: List(#(Int, Int))) -> Int {
  ranges
  |> list.flat_map(day2.invalid_ids)
  |> list.fold(0, int.add)
}

pub fn parse_test() {
  let ranges = list.flat_map(["1-2", "3", "4-5-6", "7-8"], parse)
  assert ranges == [#(1, 2), #(7, 8)]
}

pub fn invalid_ids_for_range_test() {
  assert day2.invalid_ids(#(11, 22)) == [11, 22]
  assert day2.invalid_ids(#(95, 115)) == [99]
  assert day2.invalid_ids(#(998, 1012)) == [1010]
  assert day2.invalid_ids(#(1_188_511_880, 1_188_511_890)) == [1_188_511_885]
  assert day2.invalid_ids(#(222_220, 222_224)) == [222_222]
  assert day2.invalid_ids(#(1_698_522, 1_698_528)) == []
  assert day2.invalid_ids(#(446_443, 446_449)) == [446_446]
  assert day2.invalid_ids(#(38_593_856, 38_593_862)) == [38_593_859]
  assert day2.invalid_ids(#(565_653, 565_659)) == []
  assert day2.invalid_ids(#(824_824_821, 824_824_827)) == []
  assert day2.invalid_ids(#(2_121_212_118, 2_121_212_124)) == []
}

pub fn invalid_id_sum_example_test() {
  let ranges = [
    #(11, 22),
    #(95, 115),
    #(998, 1012),
    #(1_188_511_880, 1_188_511_890),
    #(222_220, 222_224),
    #(1_698_522, 1_698_528),
    #(446_443, 446_449),
    #(38_593_856, 38_593_862),
    #(565_653, 565_659),
    #(824_824_821, 824_824_827),
    #(2_121_212_118, 2_121_212_124),
  ]
  assert invalid_id_sum(ranges) == 1_227_775_554
}

pub fn split_number_test() {
  assert day2.split_number(1) == #("", "1")
  assert day2.split_number(12) == #("1", "2")
  assert day2.split_number(123) == #("1", "23")
  assert day2.split_number(1234) == #("12", "34")
  assert day2.split_number(12_345) == #("12", "345")
}

fn parse(item: String) -> List(#(Int, Int)) {
  case string.split(item, "-") {
    [start, end] -> {
      case int.parse(start), int.parse(end) {
        Ok(i), Ok(j) -> [#(i, j)]
        _, _ -> {
          io.println_error(
            "Failed to parse"
            |> string.append(start)
            |> string.append(", ")
            |> string.append(end),
          )
          []
        }
      }
    }
    _ -> {
      io.println_error("Failed to split " |> string.append(item))
      []
    }
  }
}
