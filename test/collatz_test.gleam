import collatz.{Valid}
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn sequence_test() {
  let input = 27
  let output = collatz.collatz(input, 0)

  assert output == 111
}

pub fn reverse_guess_test() {
  let input = 100
  let output = collatz.reverse_guess(input, 1, [])
  let check = collatz.collatz(output, 0)

  assert check == input
}

pub fn reverse_traverse_test() {
  let input = 20
  let assert Valid(output) = collatz.reverse_traverse(input, 1, [])
  let check = collatz.collatz(output, 0)

  assert check == input
}
