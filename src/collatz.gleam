import gleam/int
import gleam/io
import gleam/list
import gleam/otp/task

pub fn main() {
  let n = reverse(40, 1, [])
  print(n)
  let l = collatz(n, 0)
  print(l)
}

pub fn collatz(n, l) {
  case n {
    0 -> 0
    1 -> l
    _ if n % 2 == 0 -> collatz(n / 2, l + 1)
    _ -> collatz(3 * n + 1, l + 1)
  }
}

fn reverse(n: Int, c: Int, l: List(Int)) -> Int {
  case n {
    0 -> c
    _ -> {
      case c > 1 && { c - 1 } % 3 == 0 && !list.contains(l, { c - 1 } / 3) {
        True -> reverse(n - 1, { c - 1 } / 3, [c, ..l])
        False -> reverse(n - 1, c * 2, [c, ..l])
      }
    }
  }
}

fn print(n: Int) {
  io.println(int.to_string(n))
}
